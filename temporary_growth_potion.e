note
	description: "Summary description for {TEMPORARY_GROWTH_POTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPORARY_GROWTH_POTION

inherit
	DRAWABLE
		redefine
			bite
		end

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
			surface.draw_rectangle (color, x_offset + 2, y_offset, l - 4, l)
			surface.draw_rectangle (color, x_offset, y_offset + 2, l, l - 4)
		end

	bite (force: NATURAL_32): EFFECT
		do
			Result := create {TEMPORARY_GROWTH_EFFECT}.make(30, (40 * 10).as_natural_32)
			if attached cell as c then
				c.remove_content (Current)
			end
		end

feature {NONE}
	l: INTEGER_32

	color: GAME_COLOR
end
