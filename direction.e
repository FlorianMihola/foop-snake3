note
	description: "Summary description for {DIRECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTION

inherit
	ANY redefine is_equal end

create
	make_left,
	make_right,
	make_up,
	make_down

feature {DIRECTION}
	enum: NATURAL_8

	make_left
		do
			enum := 1
		end

	make_right
		do
			enum := 2
		end

	make_up
		do
			enum := 3
		end

	make_down
		do
			enum := 4
		end

feature
	is_equal(other: DIRECTION): BOOLEAN
		do
			Result := (enum = other.enum)
		end
end
