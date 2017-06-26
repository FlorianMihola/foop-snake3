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
			enable_enemy: BOOLEAN
		do
			game_library.enable_video
			if attached separate_character_option_value('e') as enemy then
				enable_enemy := true
			else
				enable_enemy := false
			end

			create game.make (enable_enemy)
		end

end
