note
	description: "Summary description for {WORLD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WORLD

create
	make

feature {NONE}
	make(rows, cols, l: INTEGER_32)
		local
			cur_row:  WORLD_CELL
			prev_row: WORLD_CELL
		do
			prev_row := Void
			across 0 |..| (rows - 1) as i
				loop
					cur_row := make_row	(0, l * i.item, l, cols)
					if top_left = Void then
						top_left := cur_row
					end
					if attached prev_row as p then
						glue (p, cur_row)
					end
					prev_row := cur_row
				end

			create bg_color.make_rgb (0, 0, 0)
		end

	top_left: detachable WORLD_CELL

	bg_color: GAME_COLOR

	make_row(x_offset, y_offset, l, num: INTEGER_32): detachable WORLD_CELL
		local
			first: detachable WORLD_CELL
			cur:              WORLD_CELL
			prev:  detachable WORLD_CELL
		do
			prev := Void
			first := Void
			across 0 |..| (num - 1) as i
				loop
					create cur.make (x_offset + l * i.item, y_offset, l, l)
					if first = Void then
						first := cur
					end
					if attached prev as p then
						cur.set_left (prev)
						p.set_right (cur)
					end
					prev := cur
				end
			Result := first
		end

	glue(upper, lower: detachable WORLD_CELL)
		local
			cur_u: detachable WORLD_CELL
			cur_l: detachable WORLD_CELL
		do
			from cur_u := upper
				 cur_l := lower
				until cur_u = Void or cur_l = Void
				loop
					cur_u.set_down (cur_l)
					cur_l.set_up (cur_u)
					cur_u := cur_u.right
					cur_l := cur_l.right
				end
		end

feature
	draw(surface: GAME_SURFACE)
		local
			cur_row: WORLD_CELL
			cur:     WORLD_CELL
		do
			from cur_row := top_left
				until cur_row = Void
				loop
					from cur := cur_row
						until cur = Void
						loop
							cur.draw(surface)
							cur := cur.right
						end
					cur_row := cur_row.down
				end
		end

	put_at(x, y: INTEGER_32; drawable: DRAWABLE)
		local
			cur: WORLD_CELL
		do
			cur := top_left
			across 1 |..| x as i
				loop
					if attached cur as c then
						cur := c.right
					end
				end
			across 1 |..| y as i
				loop
					if attached cur as c then
						cur := cur.down
					end
				end
			if attached cur as c then
				c.add_content(drawable)
			end
		end

	cell_at(x, y: INTEGER_32): detachable WORLD_CELL
		local
			cur: WORLD_CELL
		do
			cur := top_left
			across 1 |..| x as i
				loop
					if attached cur as c then
						cur := c.right
					end
				end
			across 1 |..| y as i
				loop
					if attached cur as c then
						cur := cur.down
					end
				end
			Result := cur
		end
end
