note
	description: "Summary description for {SAFETY_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SAFETY_CONTROLLER

inherit
	WRAPPING_CONTROLLER

create
	make

feature {NONE}
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

end
