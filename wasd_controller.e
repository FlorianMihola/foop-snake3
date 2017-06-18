note
	description: "Summary description for {VUIA_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WASD_CONTROLLER

inherit
	CONTROLLER
		redefine
			on_key_down,
			force
		end

create
	make

feature
	make
		do
			direction := create {DIRECTION}.make_down
		end

	direction: DIRECTION

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			if key_state.is_w then
				direction := create {DIRECTION}.make_up
			elseif key_state.is_a then
				direction := create {DIRECTION}.make_left
			elseif key_state.is_s then
				direction := create {DIRECTION}.make_down
			elseif key_state.is_d then
				direction := create {DIRECTION}.make_right
			end
		end

	force (d: DIRECTION)
		do
			direction := d
		end
end
