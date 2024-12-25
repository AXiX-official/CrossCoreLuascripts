-- 肉鸽乐团阵营开局行动提前（蓝色2级别）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020061 = oo.class(SkillBase)
function Skill1100020061:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020061:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8231
	if SkillJudger:IsCasterMech(self, caster, self.card, true,2) then
	else
		return
	end
	-- 1100020061
	self:AddProgress(SkillEffect[1100020061], caster, caster, data, 300)
end
