note
	description: "Summary description for {DELAY_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DELAY_EFFECT

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
				snake.set_controller(create {DELAYING_CONTROLLER}.make(sc, 60))
				io.put_string (snake.name)
				io.put_string (" will react with delay")
				io.put_new_line
				snake.add_effect(Current)
			end
		end

	duration: NATURAL_32

	revert (snake: SNAKE)
		do
			if attached snake.controller as sc then
				snake.set_controller(sc.unpack)
				io.put_string (snake.name)
				io.put_string (" is back to normal")
				io.put_new_line
			end
		end

end
