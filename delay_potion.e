note
	description: "Summary description for {DELAY_POTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DELAY_POTION

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
			surface.draw_rectangle (color, x_offset + 3, y_offset, l - 6, l)
		end

	bite (force: NATURAL_32): EFFECT
		do
			Result := create {DELAY_EFFECT}.make((40 * 5).as_natural_32)
			if attached cell as c then
				c.remove_content (Current)
			end
		end

feature {NONE}
	l: INTEGER_32

	color: GAME_COLOR
end
