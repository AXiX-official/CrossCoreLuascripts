-- 剑脊4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337402 = oo.class(SkillBase)
function Skill337402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill337402:OnRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 337407
	local count407 = SkillApi:BuffCount(self, caster, target,1,3,3005)
	-- 337406
	if SkillJudger:Greater(self, caster, target, true,count407,0) then
	else
		return
	end
	-- 337402
	self:OwnerAddBuff(SkillEffect[337402], caster, caster, data, 337402)
end
