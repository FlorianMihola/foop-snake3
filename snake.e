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
			health := 15
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
			if health > 0 then
				if attached controller as c then
					c.step
					if not c.direction.is_stop then
						head.move(c.direction)
					end
				end
			end
		end

	update
		local
			reverts: LINKED_LIST[EFFECT]
		do
			if health > 0 then
				effects.step

				reverts := effects.due
				from reverts.start
				until reverts.exhausted
				loop
					reverts.item.revert (Current)
					reverts.forth
				end

				if head.touches_other then
					if not touching then
						(create {SPEED_UP_EFFECT}.make).affect(Current)
						(create {HEALTH_EFFECT}.make (3)).affect(Current)
					end
					touching := True
				elseif touching then
					(create {SLOWING_EFFECT}.make).affect(Current)
					touching := False
				end

				head.update
			end
		end

	bite (force: NATURAL_32)
		local
			damage: INTEGER_32
		do
			damage := force.as_integer_32 - head.successors.as_integer_32
			if damage < 0 then
				damage := 0
			end
			damage := damage + 10

			heal(-damage)
		end

	controller: detachable CONTROLLER

	grow (growth: INTEGER_32)
		do
			head.grow (growth)
		end

	heal (h: INTEGER_32)
		do
			health := health + h
			if health <= 0 then
				die
			else
				io.put_string (name)
				io.put_string ("'s health is now ")
				io.put_integer_32 (health)
				io.put_new_line
			end
		end

	die
		do
			io.put_string (name)
			io.put_string (" died.")
			io.put_new_line
			head.die
			health := 0
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

	score: INTEGER_32
		do
			if health > 0 then
				Result := (head.successors + 1).as_integer_32
			else
				Result := -1
			end
		end

feature {AVOIDING_LEFT_CONTROLLER}
	head: SNAKE_HEAD

feature {NONE}
	health: INTEGER_32

	effects: EFFECTS_QUEUE

	touching: BOOLEAN
end
