-- 受到伤害时获得效果命中和效果抵抗20%，最多叠加3层，持续3回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010062 = oo.class(SkillBase)
function Skill1100010062:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100010062:OnAttackOver(caster, target, data)
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
	self:AddBuffCount(SkillEffect[1100010062], caster, self.card, data, 1100010060,1,3)
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
	self:AddBuffCount(SkillEffect[1100010066], caster, target, data, 1100010061,1,3)
end
