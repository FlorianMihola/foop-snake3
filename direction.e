note
	description: "Summary description for {DIRECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTION

inherit
	ANY redefine is_equal end

create
	make_left,
	make_right,
	make_up,
	make_down,
	make_undefined,
	make_stop

feature {DIRECTION}
	enum: NATURAL_8

	make_left
		do
			enum := 1
		end

	make_right
		do
			enum := 2
		end

	make_up
		do
			enum := 3
		end

	make_down
		do
			enum := 4
		end

	make_stop
		do
			enum := 5
		end

	make_undefined
		do
			enum := 0
		end

feature
	is_equal(other: DIRECTION): BOOLEAN
		do
			Result := (enum = other.enum)
		end

	opposite: DIRECTION
		do
			Result := create {DIRECTION}.make_undefined

			if enum = 1 then
				Result := create {DIRECTION}.make_right
			elseif enum = 2 then
				Result := create {DIRECTION}.make_left
			elseif enum = 3 then
				Result := create {DIRECTION}.make_down
			elseif enum = 4 then
				Result := create {DIRECTION}.make_up
			elseif enum = 5 then
				Result := create {DIRECTION}.make_stop -- stop's opposite is stop itself
			end
		end

	is_left: BOOLEAN
		do
			Result := (enum = 1)
		end

	is_right: BOOLEAN
		do
			Result := (enum = 2)
		end

	is_up: BOOLEAN
		do
			Result := (enum = 3)
		end

	is_down: BOOLEAN
		do
			Result := (enum = 4)
		end

	is_stop: BOOLEAN
		do
			Result := (enum = 5)
		end

end
