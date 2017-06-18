note
	description: "Summary description for {CONFUSION_EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONFUSION_EFFECT

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
				snake.set_controller(create {MIRROR_CONTROLLER}.make(sc))
				io.put_string (snake.name)
				io.put_string (" is now confused")
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

feature {NONE}
	growth: INTEGER_32

end

