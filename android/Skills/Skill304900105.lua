-- 赤溟1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304900105 = oo.class(SkillBase)
function Skill304900105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304900105:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 行动结束
function Skill304900105:OnActionOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 304900101
	self:AddBuffCount(SkillEffect[304900101], caster, self.card, data, 304900101,1,10)
end
