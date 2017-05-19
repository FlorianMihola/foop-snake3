note
	description: "FOOP-Snake application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
		local
			game: GAME
		do
			game_library.enable_video
			create game.make
		end

end
