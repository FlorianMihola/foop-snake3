note
	description: "Summary description for {SNAKE_PART}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SNAKE_PART

inherit
	DRAWABLE
		redefine
			is_snake
		end

feature
	successors: NATURAL_32
		do
			if attached successor as s then
				Result := 1 + s.successors
			else
				Result := 0
			end
		end

	is_snake: BOOLEAN
		do
			Result := True
		end

feature {NONE}
	l: INTEGER_32

	color: GAME_COLOR

	snake: SNAKE

	successor: detachable BODY_SEGMENT

	grow_by: INTEGER_32
end
