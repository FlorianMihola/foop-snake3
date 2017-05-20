note
	description: "Summary description for {MIRROR_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MIRROR_CONTROLLER

inherit
	CONTROLLER
		redefine
			on_key_up,
			on_key_down
		end

create
	make

feature {NONE}
	controller: CONTROLLER

feature
	make(control: CONTROLLER)
		do
			controller := control
		end

	direction: DIRECTION
		do
			Result := controller.direction.opposite
		end

	on_key_up(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
		end
end
