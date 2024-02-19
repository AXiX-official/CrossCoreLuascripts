-- 交叉火力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101200304 = oo.class(SkillBase)
function Skill101200304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101200304:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 伤害后
function Skill101200304:OnAfterHurt(caster, target, data)
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
	-- 101200302
	self:HitAddBuff(SkillEffect[101200302], caster, target, data, 2000,3004)
end
