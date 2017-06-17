note
	description: "Summary description for {GROWTH_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GROWTH_EFFECT

inherit
	EFFECT

create
	make

feature
	make (g: INTEGER_32)
		do
			growth := g
		end

	affect (snake: SNAKE)
		do
			snake.grow (growth)
		end

feature {NONE}
	growth: INTEGER_32

end
