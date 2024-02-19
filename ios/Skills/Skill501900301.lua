-- 多重轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill501900301 = oo.class(SkillBase)
function Skill501900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill501900301:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 行动结束
function Skill501900301:OnActionOver(caster, target, data)
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
	-- 501900301
	self:HitAddBuff(SkillEffect[501900301], caster, target, data, 6000,3008)
end
