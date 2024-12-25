-- 狂战III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010312 = oo.class(SkillBase)
function Skill1100010312:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010312:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8138
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.8) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 1100010312
	self:OwnerAddBuffCount(SkillEffect[1100010312], caster, self.card, data, 1100010312,1,10)
end
