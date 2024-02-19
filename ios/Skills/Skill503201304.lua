-- 哈托莉3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill503201304 = oo.class(SkillBase)
function Skill503201304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill503201304:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 攻击结束
function Skill503201304:OnAttackOver(caster, target, data)
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
	-- 503201303
	self:HitAddBuff(SkillEffect[503201303], caster, target, data, 5000,3004)
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
	-- 503201304
	self:AddBuff(SkillEffect[503201304], caster, target, data, 1001,2)
	-- 503201305
	self:AddBuff(SkillEffect[503201305], caster, target, data, 1001,2)
end
