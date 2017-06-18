note
	description: "Summary description for {EFFECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EFFECT

feature
	affect (snake: SNAKE)
		deferred
		end

	revert (snake: SNAKE)
		do
		end

	duration: NATURAL_32
		do
			Result := 0 -- means 'do not revert'
		end
end
