note
	description: "Summary description for {TEMPORARY_GROWTH_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPORARY_GROWTH_EFFECT

inherit
	EFFECT
		redefine
			affect,
			revert,
			duration
		end

create
	make

feature
	make (g: INTEGER_32; d: NATURAL_32)
		do
			growth := g
			duration := d
		end

	duration: NATURAL_32

	affect (snake: SNAKE)
		do
			snake.grow (growth)
			snake.add_effect (Current)
		end

	revert (snake: SNAKE)
		do
			snake.grow (-growth)
		end

feature {NONE}
	growth: INTEGER_32

end
