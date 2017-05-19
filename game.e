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
		do
			create window_builder
			create world.make (10, 10, 16)

			window_builder.set_title ("FOOP-Snake")
			window := window_builder.generate_window
			game_library.quit_signal_actions.extend (agent on_quit)
			game_library.iteration_actions.extend (agent step)

			game_library.launch
		end

	window: GAME_WINDOW_SURFACED

	world: WORLD

	on_quit(timestamp: NATURAL_32)
		do
			game_library.stop
		end

	step(timestamp: NATURAL_32)
		do
			io.put_string ("step ")
			io.put_natural_32 (timestamp)
			io.put_new_line
		end
end

