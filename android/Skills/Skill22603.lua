-- 冰冻III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22603 = oo.class(SkillBase)
function Skill22603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill22603:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8207
	if SkillJudger:IsCtrlType(self, caster, target, true,4) then
	else
		return
	end
	-- 22603
	self:AddBuff(SkillEffect[22603], caster, self.card, data, 22603)
	-- 226010
	self:ShowTips(SkillEffect[226010], caster, self.card, data, 2,"冰冻",true,226010)
end
