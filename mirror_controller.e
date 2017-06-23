note
	description: "Summary description for {MIRROR_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MIRROR_CONTROLLER

inherit
	WRAPPING_CONTROLLER

create
	make

feature
	make(control: CONTROLLER)
		do
			controller := control
		end

	direction: DIRECTION
		do
			Result := controller.direction.opposite
		end

invariant
	opposite: direction.is_stop or direction.opposite.is_equal (controller.direction)

end
