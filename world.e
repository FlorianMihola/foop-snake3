note
	description: "Summary description for {WORLD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WORLD

feature {NONE}
	top_left: detachable WORLD_CELL

	bg_color: GAME_COLOR

	dirties: LINKED_SET[WORLD_CELL]

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
					create cur.make (Current, x_offset + l * i.item, y_offset, l, l)
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

	-- TODO: secure against infinite loops
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

	glue_cols(left, right: WORLD_CELL)
		local
			cur_l:   detachable WORLD_CELL
			cur_r:   detachable WORLD_CELL
			first_l: WORLD_CELL
			first_r: WORLD_CELL
		do
			first_l := left
			first_r := right
			from cur_l := left
				 cur_r := right
			until cur_l = Void or cur_r = Void or first_l.up = cur_l or first_r.up = cur_r
			loop
				cur_l.set_right(cur_r)
				cur_r.set_left(cur_l)
				cur_l := cur_l.down
				cur_r := cur_r.down
			end
		end

feature
	draw(surface: GAME_SURFACE)
		local
			linear: LINEAR[WORLD_CELL]
		do
			linear := dirties.linear_representation
			from linear.start
			until linear.exhausted
			loop
				linear.item.draw (surface)
				linear.forth
			end

			dirties.wipe_out
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
						cur := c.down
					end
				end
			Result := cur
		end

feature {WORLD_CELL}
	add_dirty (cell: WORLD_CELL)
		do
			dirties.put(cell)
		end

end
