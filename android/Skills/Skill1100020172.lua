-- 开局时全体不朽角色行动提前50%（白色)
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020172 = oo.class(SkillBase)
function Skill1100020172:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020172:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 1100020172
	self:AddProgress(SkillEffect[1100020172], caster, caster, data, 500)
end
