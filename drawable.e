note
	description: "Summary description for {DRAWABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DRAWABLE

feature
	draw(x_offset, y_offset: INTEGER_32; surface: GAME_SURFACE)
		deferred
		end

	set_cell(c: detachable WORLD_CELL)
		do
			cell := c
		end

	cell: detachable WORLD_CELL

end
