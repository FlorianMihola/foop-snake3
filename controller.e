note
	description: "Summary description for {CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTROLLER

feature
	direction: DIRECTION
		deferred
		end

	on_key_up(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
		end

	step
		do
		end

	unpack: CONTROLLER
		do
			Result := Current
		end

	force (d: DIRECTION)
		do
		end

	set_steps (s: NATURAL_32)
		do
		end

	steps: NATURAL_32
		do
			Result := 1
		end
end
