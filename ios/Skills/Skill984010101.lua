-- 双子宫-波拉克斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984010101 = oo.class(SkillBase)
function Skill984010101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984010101:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 伤害前
function Skill984010101:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8086
	if SkillJudger:CasterPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 984010102
	self:AddTempAttr(SkillEffect[984010102], caster, self.card, data, "damage",1)
end
