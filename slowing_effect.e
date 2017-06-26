note
	description: "Summary description for {SLOWING_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SLOWING_EFFECT

inherit
	EFFECT

create
	make

feature
	make
		do
		end

	affect (snake: SNAKE)
		do
			if attached snake.controller as sc then
				if sc.steps < 8 then
					sc.set_steps (sc.steps * 2)
				end
			end
		end

end
