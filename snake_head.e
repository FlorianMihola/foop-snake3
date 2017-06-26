note
	description: "Summary description for {SNAKE_HEAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SNAKE_HEAD

inherit
	SNAKE_PART
		redefine
			bite
		end

create
	make

feature
	make(ll: INTEGER_32; col: GAME_COLOR; s: SNAKE)
		do
			l := ll
			color := col
			snake := s
			can_bite := True
		end

	draw(x_offset, y_offset: INTEGER_32; surface: GAME_SURFACE)
		do
			surface.draw_rectangle (color, x_offset + 2, y_offset + 2, l - 4, l - 4)
		end

	move(direction: DIRECTION)
		local
			prev_cell: detachable WORLD_CELL
			ok: BOOLEAN
		do
			prev_cell := cell
			ok := true
			if attached cell as c then
				if direction.is_left then
					if attached c.left as left then
						c.remove_content (Current)
						left.add_content (Current)
					else
						ok := false
					end
				elseif direction.is_right then
					if attached c.right as right then
						c.remove_content (Current)
						right.add_content (Current)
					else
						ok := false
					end
				elseif direction.is_up then
					if attached c.up as up then
						c.remove_content (Current)
						up.add_content (Current)
					else
						ok := false
					end
				elseif direction.is_down then
					if attached c.down as down then
						c.remove_content (Current)
						down.add_content (Current)
					else
						ok := false
					end
				else
					print ("Invalid direction%N")
					ok := false
				end
			end

			if ok then
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

	bite (force: NATURAL_32): EFFECT
		do
			snake.bite(force)

			Result := create {NO_EFFECT}.make
		end

	update
		local
			others: LINKED_LIST [DRAWABLE]
			force: NATURAL_32
			hit_other_snake: BOOLEAN
		do
			hit_other_snake := False
			force := successors
			if attached cell as c then
				others := c.other_content (Current)
				from
					others.start
				until
					others.exhausted
				loop
					if not others.item.is_snake or can_bite then
						others.item.bite(force).affect(snake)
					end
					hit_other_snake := hit_other_snake or others.item.is_snake
					others.forth
				end
			end
			can_bite := not hit_other_snake
		end

	grow (growth: INTEGER_32)
		do
			grow_by := grow_by + growth
			if attached successor as s then
				if grow_by + s.successors.as_integer_32 < 0 then
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
	can_bite: BOOLEAN

end
