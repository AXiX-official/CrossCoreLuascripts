require "DormRoleActionBase"

local this = {}


--申请一个行为
function this:Apply(actionType, dormRole)
	if(actionType==nil) then 
		return nil 
	end 
	if(self.faClasses == nil) then
		local arr = {}
		for i, v in pairs(DormRoleActionType) do
			arr[v] = require(v)
		end
		self.faClasses = arr
	end
	local targetClass = self.faClasses[actionType]
	local fa = oo.class(targetClass)
	fa:SetType(actionType)
	if(dormRole) then
		fa:SetData(dormRole)
	end
	return fa
end

return this 