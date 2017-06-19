note
	description: "Summary description for {DELAYING_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DELAYING_CONTROLLER

inherit
	WRAPPING_CONTROLLER
		redefine
			step
		end

create
	make

feature
	make(control: CONTROLLER; d: NATURAL_32)
		do
			controller := control
			delay := d
			create queue.make (delay.as_integer_32)
			across 1 |..| delay.as_integer_32 as i
			loop
				queue.put (controller.direction)
				controller.step
			end
		end

	direction: DIRECTION
		do
			Result := queue.item
		end

	step
		do
			controller.step
			queue.remove
			queue.put(controller.direction)
		end

feature {NONE}
	delay: NATURAL_32

	queue: BOUNDED_QUEUE[DIRECTION]
end
