note
	description: "Summary description for {SNAKE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SNAKE

create
	make

feature
	make(l: INTEGER_32; num: NATURAL_32; col: GAME_COLOR)
		do
			create head.make (l, col, Current)
			create effects.make
			create name.make_empty
			head.grow ((num - 1).as_integer_32)
			health := 50
		end

	do_move(direction: DIRECTION)
		local
			prev_cell: WORLD_CELL
		do
			prev_cell := head.cell
			head.move (direction)
		end

	set_cell(head_cell: WORLD_CELL; direction: DIRECTION)
		do
			head_cell.add_content (head)
		end

	status: STRING -- TODO: Replace STRINGs with something safer
		do
			Result := head.status
		end

	set_controller(control: CONTROLLER)
		do
			controller := control
		end

	move
		do
			if attached controller as c then
				c.step
				if not c.direction.is_stop then
					do_move (c.direction)
				end
			end
		end

	update
		local
			reverts: LINKED_LIST[EFFECT]
		do
			effects.step

			reverts := effects.due
			from reverts.start
			until reverts.exhausted
			loop
--				io.put_string ("reverting ")
--				print(reverts.item)
--				io.put_new_line
				reverts.item.revert (Current)
				reverts.forth
			end
			head.update
		end

	bite (force: NATURAL_32)
		do
			health := health - force.as_integer_32
			io.put_string (name)
			io.put_string ("'s health is now ")
			io.put_integer_32 (health)
			io.put_new_line
		end

	controller: detachable CONTROLLER

	grow (growth: INTEGER_32)
		do
			head.grow (growth)
		end

	heal (h: INTEGER_32)
		do
			health := health + h
		end

	set_name(n: STRING)
		do
			name := n
		end

	name: STRING

	add_effect(effect: EFFECT)
		do
			effects.add (effect)
		end

feature {AVOIDING_LEFT_CONTROLLER}
	head: SNAKE_HEAD

feature {NONE}
	health: INTEGER_32

	effects: EFFECTS_QUEUE
end
