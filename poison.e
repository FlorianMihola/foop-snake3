note
	description: "Summary description for {POISON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POISON

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
			surface.draw_rectangle (color, x_offset, y_offset + 3, l, l - 6)
		end

	bite (force: NATURAL_32): EFFECT
		do
			Result := create {HEALTH_EFFECT}.make(-10)
			if attached cell as c then
				c.remove_content (Current)
			end
		end

feature {NONE}
	l: INTEGER_32

	color: GAME_COLOR
end
