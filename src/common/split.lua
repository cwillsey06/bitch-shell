-- split.lua
-- Coltrane Willsey
-- 2022-03-07 [23:24]

return function(str, sep)
	if not (sep) then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(str,"([^"..sep.."]+)") do
		table.insert(t,str)
	end
	return t
end