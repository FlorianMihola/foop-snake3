note
	description: "Summary description for {SAFETY_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SAFETY_CONTROLLER

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
	prev_dir: DIRECTION

feature
	make(control: CONTROLLER)
		do
			controller := control
			prev_dir := control.direction
		end

	direction: DIRECTION
		local
			new_dir: DIRECTION
		do
			new_dir := controller.direction
			if new_dir.is_left and prev_dir.is_right then
				new_dir := prev_dir
			elseif new_dir.is_right and prev_dir.is_left then
				new_dir := prev_dir
			elseif new_dir.is_up and prev_dir.is_down then
				new_dir := prev_dir
			elseif new_dir.is_down and prev_dir.is_up then
				new_dir := prev_dir
			end

			prev_dir := new_dir
			Result := new_dir
		end

	on_key_up(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			controller.on_key_up (timestamp, key_state)
		end

	on_key_down(timestamp: NATURAL_32; key_state: GAME_KEY_STATE)
		do
			controller.on_key_down (timestamp, key_state)
		end
end
