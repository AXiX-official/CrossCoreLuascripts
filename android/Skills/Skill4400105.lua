-- 破袭战
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400105 = oo.class(SkillBase)
function Skill4400105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4400105:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400105
	self:OwnerAddBuffCount(SkillEffect[4400105], caster, self.card, data, 4400105,1,5)
	-- 4400106
	self:ShowTips(SkillEffect[4400106], caster, self.card, data, 2,"破袭战",true,4400106)
end
