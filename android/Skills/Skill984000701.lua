-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984000701 = oo.class(SkillBase)
function Skill984000701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始处理完成后
function Skill984000701:OnAfterRoundBegin(caster, target, data)
	-- 8411
	local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
	-- 984000704
	if SkillJudger:Greater(self, caster, target, true,count11,2) then
	else
		return
	end
	-- 984000701
	self:CallOwnerSkill(SkillEffect[984000701], caster, self.card, data, 984000401)
end
