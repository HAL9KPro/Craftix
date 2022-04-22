--Standard API Functions

function StdRunAsTerminateless (string func) --Prevents the termination of a certain part of code
	function terminateCatch ()
		while true do
			local event = os.pullEventRaw();
			if event == "terminate" then else end
		end
	end

	parallel.waitForAny(terminateCatch, func);

end