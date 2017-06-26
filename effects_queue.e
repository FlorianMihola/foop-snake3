note
	description: "Summary description for {EFFECTS_QUEUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EFFECTS_QUEUE

create
	make

feature
	make
		do
			create data.make
		end

	add(effect: EFFECT)
		local
			d: NATURAL_32
			found: BOOLEAN
		do
			d := effect.duration
			found := False

			from data.start
			until (found or data.exhausted)
			loop
				if d < data.item.frames then
					data.put_left ([effect, d])
					found := True
				end
				data.forth
			end

			if not found then
				data.put_left([effect, d])
			end
		end

	list
		do
			if data.count > 0 then
				from data.start
				until data.exhausted
				loop
					io.put_integer_32 (data.index)
					io.put_string (" ")
					io.put_natural_32 (data.item.frames)
					io.put_new_line

					data.forth
				end
			end
		end

	step
		do
			from data.start
			until data.exhausted
			loop
				data.put ([data.item.effect, data.item.frames - 1])
				data.forth
			end
		end

	due: LINKED_LIST[EFFECT]
		local
			effects: LINKED_LIST[EFFECT]
		do
			create effects.make

			if data.count > 0 then
				from data.start
				until data.exhausted or data.item.frames > 0
				loop
					effects.put_right (data.item.effect)
					effects.forth

					data.remove
				end
			end

			effects.start
			Result := effects
		end

feature {NONE}
	data: LINKED_LIST[TUPLE[effect: EFFECT; frames: NATURAL_32]]

end
