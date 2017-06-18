note
	description: "Summary description for {SLOWING_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SLOWING_EFFECT

inherit
	EFFECT
		redefine
			revert,
			duration
		end

create
	make

feature
	make (d: NATURAL_32)
		do
			duration := d
		end

	affect (snake: SNAKE)
		do
			if attached snake.controller as sc then
				if sc.steps < 8 then
					sc.set_steps (sc.steps * 2)
					snake.add_effect(Current)
				end
				io.put_string ("steps: ")
				io.put_natural_32 (sc.steps)
				io.put_new_line
			end
		end

	revert (snake: SNAKE)
		do
			if attached snake.controller as sc then
				if sc.steps > 1 then
					sc.set_steps (sc.steps |>> 1) -- / 2
				end
				io.put_string ("steps: ")
				io.put_natural_32 (sc.steps)
				io.put_new_line
			end
		end

	duration: NATURAL_32

end
