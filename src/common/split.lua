-- split.lua
-- Coltrane Willsey
-- 2022-03-07 [23:24]

function split(str, sep)
	if not (sep) then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(str,"([^"..sep.."]+)") do
		table.insert(t,str)
	end
	return t
end

return split