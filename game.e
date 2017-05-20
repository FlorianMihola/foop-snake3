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
			player2_start_cell: detachable WORLD_CELL
			snake_length: INTEGER_32
			world_cols: INTEGER_32
			world_rows: INTEGER_32
			snake_pos_offset: INTEGER_32
		do
			l := 8
			mech_queue := 0
			mech_step := 100
			game_state := "setup"
			snake_length := 10
			world_cols := 100
			world_rows := 70

			snake_pos_offset := 20

			-- setup window
			create window_builder
			window_builder.set_title ("FOOP-Snake")
			window_builder.set_dimension (world_cols * l,  world_rows * l)
			window := window_builder.generate_window
			create surface.make_for_window (window, window.width, window.height)

			-- setup game world etc
			create world.make (world_rows, world_cols, l) --, surface)

			create player1.make (l, snake_length.as_natural_32, create {GAME_COLOR}.make_rgb (0, 255, 255))
			player1_start_cell := world.cell_at (snake_pos_offset + snake_length, snake_pos_offset)
			if attached player1_start_cell as p1sc then
				player1.set_cell (p1sc, create {DIRECTION}.make_left)
			end
			player1_controller := create {SAFETY_CONTROLLER}.make (create {WASD_CONTROLLER}.make)

			create player2.make(l, snake_length.as_natural_32, create {GAME_COLOR}.make_rgb (255, 0, 0))
			player2_start_cell := world.cell_at (world_cols - snake_pos_offset - snake_length, world_rows - snake_pos_offset)
			if attached player2_start_cell as p2sc then
				player2.set_cell (p2sc, create {DIRECTION}.make_right)
			end
			player2_controller := create {MIRROR_CONTROLLER}.make (player1_controller)

			-- setup input etc
			game_library.quit_signal_actions.extend (agent on_quit)
			window.key_pressed_actions.extend(agent on_key_down)
			window.key_released_actions.extend (agent on_key_up)
			game_library.iteration_actions.extend (agent step)

			-- run
			pause
			game_library.launch
		end

	window: GAME_WINDOW_SURFACED

	world: WORLD

	game_state: STRING

	player1: SNAKE
	player1_controller: CONTROLLER

	player2: SNAKE
	player2_controller: CONTROLLER

	mech_step:             NATURAL_32
	mech_queue:            NATURAL_32
	last_tick:  detachable NATURAL_32

	on_quit(timestamp: NATURAL_32)
		do
			game_library.stop
		end

	on_key_up(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			if key_state.is_space then
				if game_state.is_equal ("paused") then
					unpause
				elseif game_state.is_equal ("running") then
					pause
				end
			end

			player1_controller.on_key_up (timestamp, key_state)
			player2_controller.on_key_up (timestamp, key_state)
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			player1_controller.on_key_down (timestamp, key_state)
			player2_controller.on_key_down (timestamp, key_state)
		end

	pause
		do
			io.put_string ("Paused. Press Space to continue/start game.")
			io.put_new_line
			game_state := "paused"
		end

	unpause
		do
			game_state := "running"
		end

	step(timestamp: NATURAL_32)
		local
			world_surface: GAME_SURFACE
		do
			if attached last_tick as lt then
				mech_queue := mech_queue + (timestamp - lt)
			end

			last_tick := timestamp

			from
				until mech_queue < mech_step
				loop
					if game_state.is_equal ("running") then
						player1.move (player1_controller.direction)
						player2.move (player2_controller.direction)

						if player1.status.is_equal("dead") and player2.status.is_equal("dead") then
							io.put_string ("Both players died. It's a draw!")
							io.put_new_line
							game_state := "halted"
						elseif player1.status.is_equal("dead") then
							io.put_string ("Player 1 is dead. Player 2 wins!")
							io.put_new_line
							game_state := "halted"
						elseif player2.status.is_equal("dead") then
							io.put_string ("Player 2 is dead. Player 1 wins!")
							io.put_new_line
							game_state := "halted"
						end
					end
					mech_queue := mech_queue - mech_step
				end

			world.draw (window.surface)
			window.update
		end
end

