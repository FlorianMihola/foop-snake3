note
	description: "Summary description for {SPEED_UP_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPEED_UP_EFFECT

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
				if sc.steps > 1 then
					sc.set_steps (sc.steps |>> 1) -- / 2
				end
			end
		end
end
