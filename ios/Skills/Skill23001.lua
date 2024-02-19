-- 寒铁I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23001 = oo.class(SkillBase)
function Skill23001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill23001:OnActionOver(caster, target, data)
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
	-- 23001
	self:AddBuff(SkillEffect[23001], caster, caster, data, 5002,1)
	-- 23011
	self:AddBuff(SkillEffect[23011], caster, caster, data, 5201,1)
	-- 230010
	self:ShowTips(SkillEffect[230010], caster, self.card, data, 2,"钝化",true)
end
