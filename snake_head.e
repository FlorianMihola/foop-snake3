note
	description: "Summary description for {SNAKE_HEAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SNAKE_HEAD

inherit
	DRAWABLE
	UPDATABLE

create
	make

feature
	make(ll: INTEGER_32)
		do
			l := ll
		end

	draw(x_offset, y_offset: INTEGER_32; surface: GAME_SURFACE)
		do
			surface.draw_rectangle (create {GAME_COLOR}.make_rgb (0, 255, 255), x_offset + 2, y_offset + 2, l - 4, l - 4)
		end

	update
		do
			if attached controller as control then
				move (control.direction)
			end
		end

	move(direction: DIRECTION)
		do
			if attached cell as c then
				if direction.is_equal (create {DIRECTION}.make_left) then
					if attached c.left as left then
						c.remove_content (Current)
						left.add_content (Current)
					end
				elseif direction.is_equal (create {DIRECTION}.make_right) then
					if attached c.right as right then
						c.remove_content (Current)
						right.add_content (Current)
					end
				elseif direction.is_equal (create {DIRECTION}.make_up) then
					if attached c.up as up then
						c.remove_content (Current)
						up.add_content (Current)
					end
				elseif direction.is_equal (create {DIRECTION}.make_down) then
					if attached c.down as down then
						c.remove_content (Current)
						down.add_content (Current)
					end
				end
			end
		end

	set_controller(control: CONTROLLER)
		do
			controller := control
		end

feature {NONE}
	l: INTEGER_32 -- width and height of single cell

	controller: detachable CONTROLLER
end
