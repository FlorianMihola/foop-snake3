note
	description: "Summary description for {SNAKE_PART}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SNAKE_PART

inherit
	DRAWABLE
		redefine
			is_snake,
			snake
		end

feature
	successors: NATURAL_32
		do
			if attached successor as s then
				Result := 1 + s.successors
			else
				Result := 0
			end
		end

	is_snake: BOOLEAN
		do
			Result := True
		end

	die
		do
			if attached successor as s then
				s.die
				successor := Void
			end
			if attached cell as c then
				c.remove_content (Current)
			end
		end

	touches_other: BOOLEAN
		do
			Result := False

			if attached cell as c then
				if attached c.up as u then
					across u.other_content (Current) as other
					loop
						if other.item.is_snake and other.item.snake /= snake then
							Result := True
						end
					end
				end
				if attached c.down as d then
					across d.other_content (Current) as other
					loop
						if other.item.is_snake and other.item.snake /= snake then
							Result := True
						end
					end
				end
				if attached c.left as le then
					across le.other_content (Current) as other
					loop
						if other.item.is_snake and other.item.snake /= snake then
							Result := True
						end
					end
				end
				if attached c.right as r then
					across r.other_content (Current) as other
					loop
						if other.item.is_snake and other.item.snake /= snake then
							Result := True
						end
					end
				end
			end

			if not Result and attached successor as s then
				Result := s.touches_other
			end
		end

feature {NONE}
	l: INTEGER_32

	color: GAME_COLOR

	successor: detachable BODY_SEGMENT

	grow_by: INTEGER_32

feature
	snake: SNAKE

invariant
	grow_by_zero_if_successor: not (successor /= Void and grow_by > 0)

end
