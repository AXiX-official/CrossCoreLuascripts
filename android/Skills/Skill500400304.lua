-- 破碎轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500400304 = oo.class(SkillBase)
function Skill500400304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500400304:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 攻击结束
function Skill500400304:OnAttackOver(caster, target, data)
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
	-- 500400304
	self:HitAddBuff(SkillEffect[500400304], caster, target, data, 3500,3009,2)
end
-- 伤害前
function Skill500400304:OnBefourHurt(caster, target, data)
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
	-- 8627
	local count627 = SkillApi:BuffCount(self, caster, target,2,4,4500402)
	-- 500400314
	self:AddTempAttr(SkillEffect[500400314], caster, self.card, data, "damage",0.35*count627)
end
