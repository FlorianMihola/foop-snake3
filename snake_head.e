note
	description: "Summary description for {SNAKE_HEAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SNAKE_HEAD

inherit
	DRAWABLE
--	UPDATABLE

create
	make

feature
	make(ll: INTEGER_32; col: GAME_COLOR)
		do
			l := ll
			color := col
			movement_status := "ok"
		end

	draw(x_offset, y_offset: INTEGER_32; surface: GAME_SURFACE)
		do
			surface.draw_rectangle (color, x_offset + 2, y_offset + 2, l - 4, l - 4)
		end

--	update
--		do
--			if attached controller as control then
--				move (control.direction)
--			end
--		end

	move(direction: DIRECTION)
		do
			movement_status := "ok"
			if attached cell as c then
				if direction.is_left then
					if attached c.left as left then
						c.remove_content (Current)
						left.add_content (Current)
					else
						movement_status := "bumped into wall"
					end
				elseif direction.is_right then
					if attached c.right as right then
						c.remove_content (Current)
						right.add_content (Current)
					else
						movement_status := "bumped into wall"
					end
				elseif direction.is_up then
					if attached c.up as up then
						c.remove_content (Current)
						up.add_content (Current)
					else
						movement_status := "bumped into wall"
					end
				elseif direction.is_down then
					if attached c.down as down then
						c.remove_content (Current)
						down.add_content (Current)
					else
						movement_status := "bumped into wall"
					end
				else
					movement_status := "invalid"
				end
			end
		end

--	set_controller(control: CONTROLLER)
--		do
--			controller := control
--		end

	status: STRING
		local
			others: LINKED_LIST [DRAWABLE]
		do
			if movement_status.is_equal ("bumped into wall") then
				Result := "dead"
			elseif attached cell as c then
				others := c.other_content (Current)
--				print ("others in snake_head.status")
--				print (others)
				if others.empty then
					Result := "ok"
				else
					Result := "dead"
				end
			else
				Result := "invalid"
			end
		end

feature {NONE}
	l: INTEGER_32 -- width and height of single cell

	color: GAME_COLOR

	movement_status: STRING -- TODO

--	controller: detachable CONTROLLER
end
