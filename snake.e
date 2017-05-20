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
	make(l: INTEGER_32; num: NATURAL_32; col: GAME_COLOR)
		do
			create head.make (l, col)
			create segments.make
			across 1 |..| num.as_integer_32 as i
				loop
					segments.extend (create {BODY_SEGMENT}.make (l, col))
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

	set_cell(head_cell: WORLD_CELL; direction: DIRECTION)
		local
			cur_cell: WORLD_CELL
			cur_segment: BODY_SEGMENT
		do
			head_cell.add_content (head)
			cur_cell := head_cell
			across segments as i
				loop
					cur_segment := i.item
					if direction.is_left then
						if attached cur_cell.left as left then
							cur_cell := left
							cur_cell.add_content (cur_segment)
						end
					elseif direction.is_right then
						if attached cur_cell.right as right then
							cur_cell := right
							cur_cell.add_content (cur_segment)
						end
					elseif direction.is_up then
						if attached cur_cell.up as up then
							cur_cell := up
							cur_cell.add_content (cur_segment)
						end
					elseif direction.is_down then
						if attached cur_cell.down as down then
							cur_cell := down
							cur_cell.add_content (cur_segment)
						end
					end
				end
		end

	status: STRING -- TODO: Replace STRINGs with something safer
		do
			Result := head.status
		end

feature {NONE}
	head: SNAKE_HEAD

	segments: LINKED_LIST [BODY_SEGMENT]
end
