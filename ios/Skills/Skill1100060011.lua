-- 灭刃阵营角色使用普攻后，暴击伤害2%，最多100层，普攻行动后有概率使攻击力下降20%,持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100060011 = oo.class(SkillBase)
function Skill1100060011:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100060011:OnActionOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 1100060012
	self:OwnerAddBuffCount(SkillEffect[1100060012], caster, self.card, data, 1100060012,1,100)
end
-- 行动结束2
function Skill1100060011:OnActionOver2(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 1100060013
	self:AddBuff(SkillEffect[1100060013], caster, self.card, data, 1100060013)
end
