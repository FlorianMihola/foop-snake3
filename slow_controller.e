note
	description: "Summary description for {SLOW_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SLOW_CONTROLLER

inherit
	WRAPPING_CONTROLLER
		redefine
			steps,
			set_steps,
			step
		end

create
	make

feature
	make(control: CONTROLLER; s: NATURAL_32)
		do
			controller := control
			steps := s
			now := 0
		end

	direction: DIRECTION
		do
			if now = 0 then
				Result := controller.direction
			else
				Result := create {DIRECTION}.make_stop
			end
		end

	step
		do
			controller.step
			now := (now + 1) \\ steps
		end

	set_steps (s: NATURAL_32)
		do
			steps := s
		end

	steps: NATURAL_32

feature {NONE}
	now: NATURAL_32

end
