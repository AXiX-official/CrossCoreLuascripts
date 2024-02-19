-- 虫洞轰击（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400701305 = oo.class(SkillBase)
function Skill400701305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400701305:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
-- 攻击结束
function Skill400701305:OnAttackOver(caster, target, data)
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
	-- 400701303
	self:HitAddBuff(SkillEffect[400701303], caster, target, data, 10000,3009,3)
end
