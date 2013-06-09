
function convSave(obj)
	if type(obj) == "number" then
		local text = "n:" .. tostring(obj);
		return string.gsub(text, ",", ".");
	elseif type(obj) == "string" then
		return "s:" .. obj;
	elseif type(obj) == "boolean" then
		return obj;
	elseif type(obj) == "table" then
		local newt = {};
		for k, v in pairs(obj) do
			if type(k) ~= "number" and type(k) ~= "string" then
				-- unsupported keys
			else
				newt[convSave(k)] = convSave(v);
			end
		end
		return newt;
	end
end

function convLoad(obj)
	if type(obj) == "string" then
		obj_id = string.sub(obj, 1, 2);
		if obj_id == "n:" then
			-- need to run it through interpreter, since tonumber() may only accept ","
			local readnum = loadstring("return " .. string.sub(obj, 3));
			return readnum and readnum();
		elseif obj_id == "s:" then
			return string.sub(obj, 3)
		end
	elseif type(obj) == "boolean" then
		return obj;
	elseif type(obj) == "table" then
		local newt = {}
		for k, v in pairs(obj) do
			local key = convLoad(k);
			if key ~= nil then
				newt[key] = convLoad(v);
			end
		end
		return newt;
	end
end
