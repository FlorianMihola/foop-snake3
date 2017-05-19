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
	make(rows, cols, l: NATURAL_32)
		local
			cur_row:  WORLD_CELL
			prev_row: WORLD_CELL
			i: NATURAL_32
		do
			prev_row := Void
			from i := 0
				until i >= rows
				loop
					cur_row := make_row	(0, l * i, l, cols)
					if top_left = Void then
						top_left := cur_row
					end
					if attached prev_row as p then
						glue (p, cur_row)
					end
					prev_row := cur_row
					i := i + 1
				end
		end

	top_left: detachable WORLD_CELL

	make_row(x_offset, y_offset, l, num: NATURAL_32): detachable WORLD_CELL
		local
			first: detachable WORLD_CELL
			cur:              WORLD_CELL
			prev:  detachable WORLD_CELL
			i: NATURAL_32
		do
			prev := Void
			first := Void
			from i := 0
				until i >= num
				loop
					create cur.make (x_offset + l * i, y_offset, l, l)
					if first = Void then
						first := cur
					end
					if attached prev as p then
						cur.set_left (prev)
						p.set_right (cur)
					end
					prev := cur
					i := i + 1
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
end
