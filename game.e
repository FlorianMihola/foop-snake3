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
	make (enemy: BOOLEAN)
		local
			window_builder: GAME_WINDOW_SURFACED_BUILDER
			surface: GAME_SURFACE
			l: INTEGER_32
			snake_start_cell: detachable WORLD_CELL
			snake_length: INTEGER_32
			snake_pos_offset: INTEGER_32

			snake: SNAKE
			controller: CONTROLLER

			red, green, blue, white, yellow, violet: GAME_COLOR

			now: TIME
		do
			l := 16
			mech_queue := 0
			mech_step := 25 -- 1000 / second
			game_state := "setup"
			snake_length := 10
			world_cols := 50
			world_rows := 30
			game_time := (40 * 60).as_natural_32

			snake_pos_offset := 5

			spawn_max_delay := (40 * 6).as_natural_32
			spawn_min_delay := (20).as_natural_32
			despawn_max_delay := (40 * 20)
			despawn_min_delay := (40 * 5)
			spawn_countdown := 0
			create spawnables.make
			create potions.make
			create rand.make
			create now.make_now
			rand.set_seed (now.milli_second + now.second * 1000 + now.minute * 60 * 1000)

			create players.make
			create controllers.make

			-- colors
			create red.make_rgb    (255,   0,   0)
			create green.make_rgb  (  0, 255,   0)
			create blue.make_rgb   (  0,   0, 255)
			create yellow.make_rgb ( 255, 255,  0)
			create violet.make_rgb ( 250,  0, 255)
			create white.make_rgb  (255, 255, 255)

			-- images
			io.put_string ("Setting up images.. ")
			create health_up.make_filled(Void, 16, 16)
			create health_down.make_filled(Void, 16, 16)
			create speed_up.make_filled(Void, 16, 16)
			create speed_down.make_filled(Void, 16, 16)
			create grow.make_filled(Void, 16, 16)
			create shrink.make_filled(Void, 16, 16)
			create grow_temp.make_filled(Void, 16, 16)
			create confusion.make_filled(Void, 16, 16)
			create delay.make_filled(Void, 16, 16)

			-- heart
			across 4 |..| 6 as i loop health_up.put (red, 3, i.item); health_down.put (red, 3, i.item) end
			across 8 |..| 10 as i loop health_up.put (red, 3, i.item); health_down.put (red, 3, i.item) end
			across 4 |..| 6 as j loop across 3 |..| 11 as i loop health_up.put (red, j.item, i.item); health_down.put (red, j.item, i.item) end end
			across 4 |..| 10 as i loop health_up.put (red, 7, i.item); health_down.put (red, 7, i.item) end
			across 5 |..| 9 as i loop health_up.put (red, 8, i.item); health_down.put (red, 8, i.item) end
			across 6 |..| 8 as i loop health_up.put (red, 9, i.item); health_down.put (red, 9, i.item) end
			health_up.put (red, 10, 7); health_down.put (red, 10, 7)

			-- S
			across 3 |..| 4 as j
			loop
				across 3 |..| 8 as i
				loop
					speed_up.put (blue, j.item, i.item)
					speed_down.put (blue, j.item, i.item)
				end
			end
			across 5 |..| 6 as j
			loop
				across 3 |..| 4 as i
				loop
					speed_up.put (blue, j.item, i.item)
					speed_down.put (blue, j.item, i.item)
				end
			end
			across 7 |..| 8 as j
			loop
				across 3 |..| 8 as i
				loop
					speed_up.put (blue, j.item, i.item)
					speed_down.put (blue, j.item, i.item)
				end
			end
			across 9 |..| 10 as j
			loop
				across 7 |..| 8 as i
				loop
					speed_up.put (blue, j.item, i.item)
					speed_down.put (blue, j.item, i.item)
				end
			end
			across 11 |..| 12 as j
			loop
				across 3 |..| 8 as i
				loop
					speed_up.put (blue, j.item, i.item)
					speed_down.put (blue, j.item, i.item)
				end
			end

			-- L
			across 3 |..| 10 as j
			loop
				across 3 |..| 4 as i
				loop
					grow.put (green, j.item, i.item)
					shrink.put (green, j.item, i.item)
					grow_temp.put (green, j.item, i.item)
				end
			end
			across 11 |..| 12 as j
			loop
				across 3 |..| 8 as i
				loop
					grow.put (green, j.item, i.item)
					shrink.put (green, j.item, i.item)
					grow_temp.put (green, j.item, i.item)
				end
			end

			-- confusion
			across 8 |..| 9 as j
			loop
				across 2 |..| 15 as i
				loop
					confusion.put (yellow, j.item, i.item)
				end
			end
			across 2 |..| 15 as j
			loop
				across 8 |..| 9 as i
				loop
					confusion.put (yellow, j.item, i.item)
				end
			end
			across 3 |..| 4 as j loop confusion.put (yellow, j.item, 7) end
			across 13 |..| 14 as j loop confusion.put (yellow, j.item, 7) end
			across 3 |..| 4 as j loop confusion.put (yellow, j.item, 10) end
			across 13 |..| 14 as j loop confusion.put (yellow, j.item, 10) end
			across 3 |..| 4 as i loop confusion.put (yellow, 7, i.item) end
			across 13 |..| 14 as i loop confusion.put (yellow, 7, i.item) end
			across 3 |..| 4 as i loop confusion.put (yellow, 10, i.item) end
			across 13 |..| 14 as i loop confusion.put (yellow, 10, i.item) end
			confusion.put (yellow, 4, 6)
			confusion.put (yellow, 4, 11)
			confusion.put (yellow, 13, 6)
			confusion.put (yellow, 13, 11)
			confusion.put (yellow, 6, 4)
			confusion.put (yellow, 11, 4)
			confusion.put (yellow, 6, 13)
			confusion.put (yellow, 11, 13)

			-- delay
			-- circle
			across 7 |..| 10 as j
			loop
				delay.put (violet, j.item, 2)
				delay.put (violet, 2, j.item)
				delay.put (violet, j.item, 15)
				delay.put (violet, 15, j.item)
			end
			across 5 |..| 6 as j
			loop
				delay.put (violet, j.item, 3)
				delay.put (violet, 3, j.item)
				delay.put (violet, j.item, 14)
				delay.put (violet, 14, j.item)
			end
			across 11 |..| 12 as j
			loop
				delay.put (violet, j.item, 3)
				delay.put (violet, 3, j.item)
				delay.put (violet, j.item, 14)
				delay.put (violet, 14, j.item)
			end
			delay.put (violet, 4, 4)
			delay.put (violet, 4, 13)
			delay.put (violet, 13, 4)
			delay.put (violet, 13, 13)
			-- hands
			across 8 |..| 9 as j
			loop
				across 5 |..| 9 as i
				loop
					delay.put (violet, j.item, i.item)
				end
			end
			across 4 |..| 7 as j
			loop
				across 8 |..| 9 as i
				loop
					delay.put (violet, j.item, i.item)
				end
			end

			-- plus & minus
			across 10 |..| 15 as i loop across 12 |..| 13 as j
			loop
				health_up.put (white, i.item, j.item)
				speed_up.put (white, i.item, j.item)
				grow.put (white, i.item, j.item)
			end end
			across 10 |..| 15 as i loop across 12 |..| 13 as j
			loop
				health_up.put (white, j.item, i.item)
				speed_up.put (white, j.item, i.item)
				grow.put (white, j.item, i.item)

				health_down.put (white, j.item, i.item)
				speed_down.put (white, j.item, i.item)
				shrink.put (white, j.item, i.item)
			end end

			-- L clock
			-- circle
			across 10|..| 12 as i
			loop
				grow_temp.put (white, 7, i.item)
				grow_temp.put (white, 15, i.item)
			end
			across 10|..| 12 as j
			loop
				grow_temp.put (white, j.item, 15)
			end
			grow_temp.put (white, 9, 14)
			grow_temp.put (white, 8, 13)
			grow_temp.put (white, 8, 9)
			grow_temp.put (white, 9, 8)
			grow_temp.put (white, 10, 7)
			grow_temp.put (white, 14, 9)
			grow_temp.put (white, 13, 8)
			grow_temp.put (white, 14, 13)
			grow_temp.put (white, 13, 14)
			-- hands
			across 9 |..| 11 as i
			loop
				grow_temp.put (white, i.item, 11)
			end
			across 9 |..| 10 as i
			loop
				grow_temp.put (white, 11, i.item)
			end

			io.put_string ("done")
			io.put_new_line


			spawnables.put_right ([health_up, create {HEALTH_EFFECT}.make (10)])
			spawnables.put_right ([health_down, create {HEALTH_EFFECT}.make (-10)])
			spawnables.put_right ([speed_up, create {SPEED_UP_EFFECT}.make])
			spawnables.put_right ([speed_down, create {SLOWING_EFFECT}.make])
			spawnables.put_right ([grow, create {GROWTH_EFFECT}.make (5)])
			spawnables.put_right ([shrink, create {GROWTH_EFFECT}.make (-5)])
			spawnables.put_right ([grow_temp, create {TEMPORARY_GROWTH_EFFECT}.make (20, (40 * 10).as_natural_32)])
			spawnables.put_right ([delay, create {DELAY_EFFECT}.make ((40 * 5).as_natural_32)])
--			spawnables.put_right ([confusion, create {CONFUSION_EFFECT}.make ((40 * 5).as_natural_32)])

			-- setup window
			create window_builder
			window_builder.set_title ("FOOP-Snake")
			window_builder.set_dimension (world_cols * l,  world_rows * l)
			window := window_builder.generate_window
			create surface.make_for_window (window, window.width, window.height)

			-- setup game world etc
			world := create {ENDLESS_WORLD}.make (world_rows, world_cols, l)

			-- player 1
			create snake.make (l, snake_length.as_natural_32, green)
			snake.set_name("Player One")
			snake_start_cell := world.cell_at (snake_pos_offset, snake_pos_offset)
			if attached snake_start_cell as p1sc then
				snake.set_cell (p1sc, create {DIRECTION}.make_left)
			end
			controller := create {SLOW_CONTROLLER}.make(
				create {SAFETY_CONTROLLER}.make (create {WASD_CONTROLLER}.make),
				4
			)
			snake.set_controller (controller)
			controllers.put_right(controller)
			players.put_right(snake)

			-- player 2
			create snake.make (l, snake_length.as_natural_32, blue)
			snake.set_name("Player Two")
			snake_start_cell := world.cell_at (world_cols - snake_pos_offset - 1, world_rows - snake_pos_offset - 1)
			if attached snake_start_cell as p1sc then
				snake.set_cell (p1sc, create {DIRECTION}.make_left)
			end
			controller := create {SLOW_CONTROLLER}.make(
				create {SAFETY_CONTROLLER}.make (create {IJKL_CONTROLLER}.make),
				4
			)
			snake.set_controller (controller)
			controllers.put_right(controller)
			players.put_right(snake)

			-- enemy
			if enemy then
				create snake.make (l, snake_length.as_natural_32, red)
				snake.set_name("Enemy Snake")
				snake_start_cell := world.cell_at (world_cols - 1, world_rows - 1)
				if attached snake_start_cell as p1sc then
					snake.set_cell (p1sc, create {DIRECTION}.make_left)
				end
				controller := create {SLOW_CONTROLLER}.make(
					create {AVOIDING_LEFT_CONTROLLER}.make (snake, create {DIRECTION}.make_up),
					4
				)
				snake.set_controller (controller)
				controllers.put_right(controller)
				players.put_right(snake)
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

	world_cols: INTEGER_32
	world_rows: INTEGER_32

	game_time: NATURAL_32

	rand: RANDOM
	spawn_max_delay, spawn_min_delay: NATURAL_32
	despawn_max_delay, despawn_min_delay: INTEGER_32
	spawnables: LINKED_LIST[TUPLE[image: ARRAY2[detachable GAME_COLOR]; effect: EFFECT]]
	spawn_countdown: NATURAL_32
	potions: LINKED_LIST[POTION]

	health_up, health_down, speed_up, speed_down, grow, shrink, grow_temp, confusion, delay: ARRAY2[detachable GAME_COLOR]

	game_state: STRING

	players: LINKED_LIST[SNAKE]
	controllers: LINKED_LIST[CONTROLLER]

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

			across controllers as controller
			loop
				controller.item.on_key_up (timestamp, key_state)
			end
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			across controllers as controller
			loop
				controller.item.on_key_down (timestamp, key_state)
			end
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
			rand_x, rand_y, rand_i: INTEGER_32
			best_player: detachable SNAKE
			potion: detachable POTION
			despawn_countdown: INTEGER_32
		do
			if attached last_tick as lt then
				mech_queue := mech_queue + (timestamp - lt)
			end

			last_tick := timestamp

			from
				until mech_queue < mech_step
				loop
					if game_state.is_equal ("running") then
						if spawn_countdown = 0 then
							spawn_countdown := spawn_min_delay +
								(rand.item \\ ((spawn_max_delay - spawn_min_delay).as_integer_32 + 1)).as_natural_32
							rand.forth

							rand_x := rand.item \\ world_cols
							rand.forth
							rand_y := rand.item \\ world_rows
							rand.forth

							rand_i := rand.item \\ spawnables.count
							rand.forth

							despawn_countdown := despawn_min_delay +
								rand.item \\ ((despawn_max_delay - despawn_min_delay).as_integer_32 + 1)
							rand.forth

							potion := create {POTION}.make( spawnables.i_th (rand_i + 1).image
							                              , spawnables.i_th (rand_i + 1).effect
								                          , despawn_countdown
								                          )

							if attached world.cell_at (rand_x, rand_y) as wc then
								if attached potion as p then
									potions.put_front(p)
									wc.add_content (p)
								end
							end
						else
							spawn_countdown := spawn_countdown - 1
						end

						across players as player
						loop
							player.item.move
						end

						across players as player
						loop
							player.item.update
						end

						from potions.start
						until potions.exhausted
						loop
							if not potions.item.update then
								potions.remove
							end
							if not potions.exhausted then
								potions.forth
							end
						end

						game_time := (game_time - 1).as_natural_32
						if game_time = 0 then
							io.put_string ("Game Over")
							io.put_new_line

							best_player := Void

							across players as player
							loop
								io.put_string(player.item.name)
								if player.item.score > 0 then
									io.put_string (" scored ")
									io.put_integer_32(player.item.score)
								else
									io.put_string (" is dead")
								end
								io.put_new_line

								if player.item.score > 0 then
									if attached best_player as bp then
										if player.item.score > bp.score then
											best_player := player.item
										end
									else
										best_player := player.item
									end
								end
							end

							if attached best_player as bp then
								io.put_string (bp.name)
								io.put_string (" won!")
								io.put_new_line
							else
								io.put_string ("Everybody died")
								io.put_new_line
							end

							game_state := "game over"
						end
					end
					mech_queue := mech_queue - mech_step
				end

			world.draw (window.surface)
			window.update
		end
end

