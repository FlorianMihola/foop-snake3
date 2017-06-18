note
	description: "Summary description for {MIRROR_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MIRROR_CONTROLLER

inherit
	WRAPPING_CONTROLLER
		redefine
			unpack
		end

create
	make

feature
	make(control: CONTROLLER)
		do
			controller := control
			first := controller.direction
		end

	direction: DIRECTION
		do
			Result := controller.direction.opposite
			if attached first as f then
				if f.is_equal (controller.direction) then
					Result := f
				else
					first := Void
				end
			end
		end

	unpack: CONTROLLER
		do
			controller.force(direction) -- for some reason neither direction nor direction.opposite seem to work
			Result := controller
		end

feature {NONE}
	first: detachable DIRECTION

end
