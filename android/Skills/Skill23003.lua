-- 寒铁III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23003 = oo.class(SkillBase)
function Skill23003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill23003:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 23003
	self:AddBuff(SkillEffect[23003], caster, caster, data, 5006,1)
	-- 23013
	self:AddBuff(SkillEffect[23013], caster, caster, data, 5203,1)
	-- 230010
	self:ShowTips(SkillEffect[230010], caster, self.card, data, 2,"钝化",true)
end
