note
	description: "Summary description for {HEALTH_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEALTH_EFFECT

inherit
	EFFECT

create
	make

feature
	make (h: INTEGER_32)
		do
			health := h
		end

	affect (snake: SNAKE)
		do
			snake.heal (health)
		end

feature {NONE}
	health: INTEGER_32

end
