note
	description: "Summary description for {SNAKE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SNAKE

create
	make

feature
	make(l: INTEGER_32; num: NATURAL_32)
		do
			create head.make (l)
			create segments.make
			across 1 |..| num.as_integer_32 as i
				loop
					segments.extend (create {BODY_SEGMENT}.make (l))
				end
		end


	move(direction: DIRECTION)
		local
			cur_cell: WORLD_CELL
			prev_cell: WORLD_CELL
		do
			prev_cell := head.cell
			head.move (direction)
			across segments as i
				loop
					cur_cell := i.item.cell
					i.item.move (prev_cell)
					prev_cell := cur_cell
				end
		end

	set_cell(head_cell: WORLD_CELL)
		local
			cur_cell: WORLD_CELL
			cur_segment: BODY_SEGMENT
		do
			head_cell.add_content (head)
			cur_cell := head_cell
			across segments as i
				loop
					cur_segment := i.item
					if attached cur_cell.down as down then
						cur_cell := down
						cur_cell.add_content (cur_segment)
					end
				end
		end
feature {NONE}
	head: SNAKE_HEAD

	segments: LINKED_LIST [BODY_SEGMENT]
end
