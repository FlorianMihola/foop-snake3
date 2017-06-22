note
	description: "Summary description for {POTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POTION

inherit
	DRAWABLE
		redefine
			bite
		end

create
	make

feature
	make(img: ARRAY2[detachable GAME_COLOR]; e: EFFECT; c: INTEGER_32)
		do
			image := img
			effect := e
			countdown := c
		end

	draw(x_offset, y_offset: INTEGER_32; surface: GAME_SURFACE)
		do
			across 1 |..| image.height as y
			loop
				across 1 |..| image.width as x
				loop
					if attached image.item(y.item, x.item) as color then
						surface.pixels.set_pixel (color, y_offset + y.item - 1, x_offset + x.item - 1)
					end
				end
			end
		end

	bite (force: NATURAL_32): EFFECT
		do
			Result := effect
			die
		end

	update: BOOLEAN -- still alive?
		do
			Result := True
			countdown := countdown - 1
			if countdown < 0 then
				die
				Result := False
			end
		end

feature {NONE}
	die
		do
			if attached cell as c then
				c.remove_content (Current)
			end
			countdown := 0
		end

	image: ARRAY2[detachable GAME_COLOR]

	effect: EFFECT

	countdown: INTEGER_32

end
