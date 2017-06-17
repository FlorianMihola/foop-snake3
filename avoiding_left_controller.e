note
	description: "Summary description for {AVOIDING_LEFT_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AVOIDING_LEFT_CONTROLLER

inherit
	CONTROLLER

create
	make

feature {NONE}
	player: SNAKE
	dir: DIRECTION

feature
	make(p: SNAKE; start_dir: DIRECTION)
		do
			player := p
			dir := start_dir
		end

	direction: DIRECTION
		do
			if attached player.head.cell as c then
				if dir.is_up then
					if attached c.up as up then
						if not up.empty then
							dir := create {DIRECTION}.make_left
						end
					else
						dir := create {DIRECTION}.make_left
					end
				elseif dir.is_down then
					if attached c.down as down then
						if not down.empty then
							dir := create {DIRECTION}.make_right
						end
					else
						dir := create {DIRECTION}.make_right
					end
				elseif dir.is_left then
					if attached c.left as left then
						if not left.empty then
							dir := create {DIRECTION}.make_down
						end
					else
						dir := create {DIRECTION}.make_down
					end
				elseif dir.is_right then
					if attached c.right as right then
						if not right.empty then
							dir := create {DIRECTION}.make_up
						end
					else
						dir := create {DIRECTION}.make_up
					end
				end
			end

			if attached dir as d then
				Result := d
			else
				Result := create {DIRECTION}.make_undefined
			end
		end

end
