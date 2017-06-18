note
	description: "Summary description for {SNAKE_HEAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SNAKE_HEAD

inherit
	DRAWABLE
		redefine
			bite
		end
--	UPDATABLE

create
	make

feature
	make(ll: INTEGER_32; col: GAME_COLOR; s: SNAKE)
		do
			l := ll
			color := col
			snake := s
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
		local
			prev_cell: detachable WORLD_CELL
		do
			prev_cell := cell
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
					print ("Invalid direction%N")
					movement_status := "invalid"
				end
			end

			if movement_status.is_equal("ok") then
				if attached prev_cell as pc then
					if attached successor as s then
						s.move (pc)
					else
						if grow_by > 0 then
							successor := create {BODY_SEGMENT}.make (l, color, snake)
							if attached successor as s then
								s.grow (grow_by - 1)
								s.move (pc)
								grow_by := 0
							else
								-- todo: panic!
							end
						end
					end
				end
			end
		end

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
				if others.is_empty then
					Result := "ok"
				else
					Result := "dead"
				end
			else
				Result := "invalid"
			end
		end

	bite (force: NATURAL_32): EFFECT
		do
			snake.bite(force)

			Result := create {NO_EFFECT}.make
		end

	update
		local
			others: LINKED_LIST [DRAWABLE]
		do
			if attached cell as c then
				others := c.other_content (Current)
				from
					others.start
				until
					others.exhausted
				loop
					others.item.bite (10).affect (snake) -- todo: calculate force
					others.forth
				end
			end
		end

	grow (growth: INTEGER_32)
		do
			grow_by := grow_by + growth
			if attached successor as s then
				if grow_by + s.successors < 0 then
					s.die
					successor := Void
				else
					s.grow (grow_by)
				end
				grow_by := 0
			end
			if grow_by < 0 then
				grow_by:= 0 -- do not "save" negative growth	
			end
		end

feature {NONE}
	l: INTEGER_32 -- width and height of single cell

	color: GAME_COLOR

	movement_status: STRING -- TODO

	snake: SNAKE

	successor: detachable BODY_SEGMENT
	grow_by: INTEGER_32
end
