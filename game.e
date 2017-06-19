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
			mech_step := 25 -- 1000 / second
			game_state := "setup"
			snake_length := 10
			world_cols := 100
			world_rows := 60

			snake_pos_offset := 10

			-- setup window
			create window_builder
			window_builder.set_title ("FOOP-Snake")
			window_builder.set_dimension (world_cols * l,  world_rows * l)
			window := window_builder.generate_window
			create surface.make_for_window (window, window.width, window.height)

			-- setup game world etc
			world := create {ENDLESS_WORLD}.make (world_rows, world_cols, l)

			-- player 1
			create player1.make (l, snake_length.as_natural_32, create {GAME_COLOR}.make_rgb (0, 255, 0))
			player1.set_name("Player One")
			player1_start_cell := world.cell_at (snake_pos_offset + snake_length - 1, snake_pos_offset - 1)
			if attached player1_start_cell as p1sc then
				player1.set_cell (p1sc, create {DIRECTION}.make_left)
			end
			--player1_controller := create {SAFETY_CONTROLLER}.make (create {WASD_CONTROLLER}.make)
			player1_controller := create {SLOW_CONTROLLER}.make(
				create {SAFETY_CONTROLLER}.make (create {WASD_CONTROLLER}.make),
				4
			)
--			player1_controller := create {DELAYING_CONTROLLER}.make (player1_controller, 80)
			player1.set_controller (player1_controller)

			-- player 2
			create player2.make(l, snake_length.as_natural_32, create {GAME_COLOR}.make_rgb (255, 0, 0))
			player2.set_name("Enemy")
			player2_start_cell := world.cell_at (snake_pos_offset + snake_length - 1 + 3, snake_pos_offset - 3)
			if attached player2_start_cell as p2sc then
				player2.set_cell (p2sc, create {DIRECTION}.make_down)
			end
			player2_controller := create {AVOIDING_LEFT_CONTROLLER}.make (player2, create {DIRECTION}.make_up)
			player2.set_controller (player2_controller)

			-- longer
			if attached world.cell_at (10, 10) as wc then
				wc.add_content (create {GROWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (0, 0, 255)))
			end
			if attached world.cell_at (10, 11) as wc then
				wc.add_content (create {GROWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (0, 0, 255)))
			end
			if attached world.cell_at (10, 12) as wc then
				wc.add_content (create {GROWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (0, 0, 255)))
			end
			if attached world.cell_at (10, 13) as wc then
				wc.add_content (create {TEMPORARY_GROWTH_POTION}.make (l, create {GAME_COLOR}.make_rgb (0, 0, 255)))
			end

			-- shorter
--			if attached world.cell_at (30, 10) as wc then
--				wc.add_content (create {SHRINKING_POTION}.make (l, create {GAME_COLOR}.make_rgb (0, 0, 255)))
--			end
--			if attached world.cell_at (30, 11) as wc then
--				wc.add_content (create {SHRINKING_POTION}.make (l, create {GAME_COLOR}.make_rgb (0, 0, 255)))
--			end
--			if attached world.cell_at (30, 12) as wc then
--				wc.add_content (create {SHRINKING_POTION}.make (l, create {GAME_COLOR}.make_rgb (0, 0, 255)))
--			end

			-- health down
			if attached world.cell_at (60, 10) as wc then
				wc.add_content (create {HEALING_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 0)))
			end
			-- health up
			if attached world.cell_at (60, 12) as wc then
				wc.add_content (create {POISON}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 0)))
			end

			-- mirror
--			if attached world.cell_at (snake_pos_offset + snake_length - 1, 40) as wc then
--				wc.add_content (create {CONFUSING_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 255, 0)))
--			end

			-- speed up
			if attached world.cell_at (30, 10) as wc then
				wc.add_content (create {SPEED_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 11) as wc then
				wc.add_content (create {SPEED_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 12) as wc then
				wc.add_content (create {SPEED_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 13) as wc then
				wc.add_content (create {SPEED_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 14) as wc then
				wc.add_content (create {SPEED_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end

			-- speed down
			if attached world.cell_at (30, 30) as wc then
				wc.add_content (create {SLOWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 31) as wc then
				wc.add_content (create {SLOWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 32) as wc then
				wc.add_content (create {SLOWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 33) as wc then
				wc.add_content (create {SLOWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end
			if attached world.cell_at (30, 34) as wc then
				wc.add_content (create {SLOWING_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end

			-- delay
			if attached world.cell_at (40, 10) as wc then
				wc.add_content (create {DELAY_POTION}.make (l, create {GAME_COLOR}.make_rgb (255, 0, 255)))
			end

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

--	block1: BLOCK
--	block2: BLOCK
--	block3: BLOCK
--	block4: BLOCK

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
		do
			if attached last_tick as lt then
				mech_queue := mech_queue + (timestamp - lt)
			end

			last_tick := timestamp

			from
				until mech_queue < mech_step
				loop
					if game_state.is_equal ("running") then
						player1.move
						player2.move

						player1.update
						player2.update
					end
					mech_queue := mech_queue - mech_step
				end

			world.draw (window.surface)
			window.update
		end
end

