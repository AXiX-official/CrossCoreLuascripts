DormRoleActionClick = oo.class(DormRoleActionBase)

local this = DormRoleActionClick


--休闲时间区间
function this:Enter(actionData)
	self.dormAction2 = Dorm_GetClick(self.dormRole.data)
	local actionTime = Dorm_Action_Time(self.dormAction2)
	self.endTime = Time.time + actionTime
	self.isEnter = true
	self.dormRole.RotateImme()--立即转向
	self.dormRole.dormRoleStateMachine:PlayByActionType(self.dormAction2)	--挥手
	--self.dormRole.tool:AddBubble("", self.dormRole.data:GetID(), actionTime, self.dormRole:CheckIsDorm())   --添加聊天气泡,显示换装按钮
end

function this:Update()
	if(not self.isEnter) then
		return
	end
	if(Time.time > self.endTime) then
		self:OnComplete()
	end
end

function this:OnComplete()
	self.isEnter = false
	
	local action, dormAction2 = Dorm_GetActionType(self.dormAction2, self.dormRole)
	self.dormRole.ChangeAction(action, dormAction2)
end

return this 