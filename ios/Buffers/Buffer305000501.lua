-- 305000501_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000501 = oo.class(BuffBase)
function Buffer305000501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer305000501:OnActionOver(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8414
	local c14 = SkillApi:GetBeDamage(self, self.caster, target or self.owner,3)
	-- 1010
	self:AddValue(BufferEffect[1010], self.caster, self.card, nil, "dmg1",c14)
end
-- 创建时
function Buffer305000501:OnCreate(caster, target)
	-- 305000501
	self:DamagePhysics(BufferEffect[305000501], self.caster, self.card, nil, 8,1)
end
