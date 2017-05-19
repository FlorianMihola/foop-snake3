note
	description: "Summary description for {WORLD_CELL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WORLD_CELL

create
	make

feature {NONE}
	make(xx, yy, ww, hh: INTEGER_32)
		do
			x := xx
			y := yy
			w := ww
			h := hh

			left  := Void
			right := Void
			up    := Void
			down  := Void

			create contents.make

--			io.put_natural_32 (xx)
--			io.put_string (" ")
--			io.put_natural_32 (yy)
--			io.put_new_line
		end

	x: INTEGER_32
	y: INTEGER_32
	w: INTEGER_32
	h: INTEGER_32

	contents: LINKED_LIST [DRAWABLE]

feature
	left:  detachable WORLD_CELL
	right: detachable WORLD_CELL
	up:    detachable WORLD_CELL
	down:  detachable WORLD_CELL

	set_left(l: WORLD_CELL)
		do
			left := l
		end

	set_right(r: WORLD_CELL)
		do
			right := r
		end

	set_up(u: WORLD_CELL)
		do
			up := u
		end

	set_down(d: WORLD_CELL)
		do
			down := d
		end

	add_content(content: DRAWABLE)
		do
			io.put_string("add content")
			io.put_new_line
			content.set_cell(Current)
			contents.extend (content)
		end

	remove_content(content: DRAWABLE)
		do
			contents.start
			contents.prune (content)
		end

	draw(surface: GAME_SURFACE)
		do
--			surface.draw_rectangle (create {GAME_COLOR}.make_rgb (255, 255, 255), x+1, y+1, w-2, h-2)
			across contents as content
				loop
					content.item.draw (x, y, surface)
				end
		end
end