note
	description: "Summary description for {KEYBOARD_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KEYBOARD_CONTROLLER

inherit
	CONTROLLER

create
	make

feature
	make
		do
			direction := create {DIRECTION}.make_right
		end

	direction: DIRECTION

	on_key_up(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			if key_state.is_v then
				direction := create {DIRECTION}.make_up
			elseif key_state.is_i then
				direction := create {DIRECTION}.make_down
			elseif key_state.is_u then
				direction := create {DIRECTION}.make_left
			elseif key_state.is_a then
				direction := create {DIRECTION}.make_right
			end
		end

end
