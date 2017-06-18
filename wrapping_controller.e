note
	description: "Summary description for {WRAPPING_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WRAPPING_CONTROLLER

inherit
	CONTROLLER
		redefine
			on_key_up,
			on_key_down,
			steps,
			set_steps,
			step,
			unpack
		end

feature {NONE}
	controller: CONTROLLER

feature
	on_key_up(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			controller.on_key_up (timestamp, key_state)
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			controller.on_key_down (timestamp, key_state)
		end

	set_steps(s: NATURAL_32)
		do
			controller.set_steps(s)
		end

	steps: NATURAL_32
		do
			Result := controller.steps
		end

	step
		do
			controller.step
		end

	unpack: CONTROLLER
		do
			Result := controller
		end

end
