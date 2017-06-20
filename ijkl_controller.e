note
	description: "Summary description for {IJKL_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IJKL_CONTROLLER

inherit
	WASD_CONTROLLER
		redefine
			make,
			on_key_down
		end

create
	make

feature
	make
		do
			direction := create {DIRECTION}.make_left
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			if key_state.is_i then
				direction := create {DIRECTION}.make_up
			elseif key_state.is_j then
				direction := create {DIRECTION}.make_left
			elseif key_state.is_k then
				direction := create {DIRECTION}.make_down
			elseif key_state.is_l then
				direction := create {DIRECTION}.make_right
			end
		end
end
