note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE}
	make
		local
			window_builder: GAME_WINDOW_SURFACED_BUILDER
			surface: GAME_SURFACE
			l: INTEGER_32
			player1_start_cell: detachable WORLD_CELL
		do
			l := 8
			mech_queue := 0
			mech_step := 100

			-- setup window
			create window_builder
			window_builder.set_title ("FOOP-Snake")
			window := window_builder.generate_window
			create surface.make_for_window (window, window.width, window.height)

			-- setup game world etc
			create world.make (100, 100, l, surface)
			create player1.make (l, 30)
			player1_start_cell := world.cell_at (0, 0)
			if attached player1_start_cell as p1sc then
				io.put_string ("got player1 start cell")
				io.put_new_line
				player1.set_cell (p1sc)
			end
			player1_controller := create {KEYBOARD_CONTROLLER}.make

--			player1.set_controller (player1_controller)

			-- setup input etc
			game_library.quit_signal_actions.extend (agent on_quit)
			window.key_pressed_actions.extend(agent on_key_down)
			window.key_released_actions.extend (agent on_key_up)
			game_library.iteration_actions.extend (agent step)

			-- run
			game_library.launch
		end

	window: GAME_WINDOW_SURFACED

	world: WORLD

	player1: SNAKE
	player1_controller: KEYBOARD_CONTROLLER

	mech_step:             NATURAL_32
	mech_queue:            NATURAL_32
	last_tick:  detachable NATURAL_32

	on_quit(timestamp: NATURAL_32)
		do
			game_library.stop
		end

	on_key_up(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			player1_controller.on_key_up (timestamp, key_state)
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			player1_controller.on_key_down (timestamp, key_state)
		end

	step(timestamp: NATURAL_32)
		local
			world_surface: GAME_SURFACE
		do
--			io.put_string ("step ")
--			io.put_natural_32 (timestamp)
--			io.put_new_line

			if attached last_tick as lt then
				mech_queue := mech_queue + (timestamp - lt)
			end

			last_tick := timestamp

			from
				until mech_queue < mech_step
				loop
					player1.move (player1_controller.direction)
					mech_queue := mech_queue - mech_step
				end

			world_surface := world.draw
			window.surface.draw_sub_surface (world_surface, 0, 0, world_surface.width, world_surface.height, 0, 0)
			window.update
		end
end

