note
	description: "Summary description for {ENDLESS_WORLD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENDLESS_WORLD

inherit
	WORLD

create
	make

feature
	make(rows, cols, l: INTEGER_32)
		local
			cur_row:   WORLD_CELL
			prev_row:  WORLD_CELL
			top_right: WORLD_CELL
		do
			create bg_color.make_rgb (0, 0, 0)
			create dirties.make

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

			glue(prev_row, top_left)

			top_right := top_left
			across 0 |..| (cols - 2)  as i
			loop
				if attached top_right as tr then
					top_right := tr.right
				end
			end

			if attached top_right as tr then
				if attached top_left as tl then
					print("glueing cols%N")
					glue_cols(tr, tl)
				end
			end
		end

end
