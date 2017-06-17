note
	description: "Summary description for {MIRROR_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MIRROR_CONTROLLER

inherit
	CONTROLLER

create
	make

feature {NONE}
	controller: CONTROLLER

feature
	make(control: CONTROLLER)
		do
			controller := control
		end

	direction: DIRECTION
		do
			Result := controller.direction.opposite
		end
end
