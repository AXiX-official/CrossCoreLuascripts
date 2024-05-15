-- 皇室荣耀
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4100101 = oo.class(SkillBase)
function Skill4100101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4100101:OnActionOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4100101
	self:OwnerAddBuffCount(SkillEffect[4100101], caster, self.card, data, 4100101,1,4)
	-- 4100106
	self:ShowTips(SkillEffect[4100106], caster, self.card, data, 2,"荣耀之心",true,4100106)
end
-- 入场时
function Skill4100101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4100109
	self:CallSkillEx(SkillEffect[4100109], caster, self.card, data, 100100203)
end
