note
	description: "Summary description for {BODY_SEGMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BODY_SEGMENT

inherit
	DRAWABLE

create
	make

feature
	make(ll: INTEGER_32; col: GAME_COLOR)
		do
			l := ll
			color := col
		end

	draw(x_offset, y_offset: INTEGER_32; surface: GAME_SURFACE)
		do
			surface.draw_rectangle (color, x_offset + 3, y_offset + 3, l - 6, l - 6)
		end

	move(new_cell: detachable WORLD_CELL)
		do
			if attached cell as c then
				c.remove_content (Current)
			end
			if attached new_cell as nc then
				nc.add_content (Current)
			end
		end

feature {NONE}
	l: INTEGER_32

	color: GAME_COLOR
end
