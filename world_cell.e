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
	make(xx, yy, ww, hh: NATURAL_32)
		do
			x := xx
			y := yy
			w := ww
			h := hh

			left  := Void
			right := Void
			up    := Void
			down  := Void

			io.put_natural_32 (xx)
			io.put_string (" ")
			io.put_natural_32 (yy)
			io.put_new_line
		end

	x: NATURAL_32
	y: NATURAL_32
	w: NATURAL_32
	h: NATURAL_32

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
end
