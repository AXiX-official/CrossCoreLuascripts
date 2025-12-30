-- 寒铁II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23002 = oo.class(SkillBase)
function Skill23002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill23002:OnActionOver(caster, target, data)
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
	-- 23002
	self:AddBuff(SkillEffect[23002], caster, caster, data, 5004,1)
	-- 23012
	self:AddBuff(SkillEffect[23012], caster, caster, data, 5202,1)
	-- 230010
	self:ShowTips(SkillEffect[230010], caster, self.card, data, 2,"钝化",true,230010)
end
