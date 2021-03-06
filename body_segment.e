note
	description: "Summary description for {BODY_SEGMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BODY_SEGMENT

inherit
	SNAKE_PART
		redefine
			bite
		end

create
	make

feature

	make (ll: INTEGER_32; col: GAME_COLOR; s: SNAKE)
		do
			l := ll
			color := col
			snake := s
			successor := Void
			grow_by := 0
		end

	draw (x_offset, y_offset: INTEGER_32; surface: GAME_SURFACE)
		do
			surface.draw_rectangle (color, x_offset + 3, y_offset + 3, l - 6, l - 6)
		end

	move (new_cell: detachable WORLD_CELL)
		local
			prev_cell: detachable WORLD_CELL
		do
			prev_cell := cell
			if attached cell as c then
				c.remove_content (Current)
			end
			if attached new_cell as nc then
				nc.add_content (Current)
			end
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

	bite (force: NATURAL_32): EFFECT
		do
			snake.bite (force)
			Result := create {NO_EFFECT}.make
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
		end

end
