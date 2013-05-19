-- originally(?) posted by Pengoros on lotro.com forums:
-- safely add a callback without overwriting any existing ones
function AddCallback(object, event, callback)
	if (object[event] == nil) then
		object[event] = callback;
	elseif (type(object[event]) == "table") then
		table.insert(object[event], callback);
	else
		object[event] = {object[event], callback};
	end
end

-- safely remove a callback without clobbering any extras
function RemoveCallback(object, event, callback)
	if (object[event] == callback) then
		object[event] = nil;
	elseif (type(object[event]) == "table") then
		for key, val in pairs(object[event]) do
			if (val == callback) then
				table.remove(object[event], key);
				break;
			end
		end
		-- remove table if empty
		if (next(object[event]) == nil) then
			object[event] = nil;
		end
	end
end

-- safetly execute a callback whether it be an array of functions or a single one
function ExecuteCallback(object, event, args)
    if (type(object[event]) == "function") then
        object[event](object, args);
    elseif (type(object[event]) == "table") then
		for key, val in pairs(object[event]) do
			if (type(val) == "function") then
				val(object, args);
			end
		end
	end
end
