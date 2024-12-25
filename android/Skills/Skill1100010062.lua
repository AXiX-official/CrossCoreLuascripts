-- 受到攻击后叠加命中和抵抗3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010062 = oo.class(SkillBase)
function Skill1100010062:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100010062:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010062
	self:AddAttr(SkillEffect[1100010062], caster, target, data, "hit",0.2)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010066
	self:AddAttr(SkillEffect[1100010066], caster, target, data, "resist",0.2)
end
