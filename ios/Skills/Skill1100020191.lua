-- 开局时全体虫洞角色行动提前30%（白色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020191 = oo.class(SkillBase)
function Skill1100020191:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020191:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 1100020191
	self:AddProgress(SkillEffect[1100020191], caster, caster, data, 300)
end
