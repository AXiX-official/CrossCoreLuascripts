local this = {};
local ss={}

function this:CheckHasSpecial(str)
    local str2 = StringUtil:FilterChar2(str)
    return #str2 ~= #str
end


return this;