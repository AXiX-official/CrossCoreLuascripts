-- 肉鸽虫洞阵营角色施加持续伤害效果时，敌方承受伤害增加1%，最多100层,大招行动后有概率防御下降40%，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100050040 = oo.class(SkillBase)
function Skill1100050040:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill1100050040:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
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
	-- 1100050041
	if SkillJudger:IsCtrlBuffType(self, caster, target, true,1) then
	else
		return
	end
	-- 1100050040
	self:OwnerAddBuffCount(SkillEffect[1100050040], caster, target, data, 1100050040,1,100)
end
-- 行动结束
function Skill1100050040:OnActionOver(caster, target, data)
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
	-- 1100050014
	self:AddBuff(SkillEffect[1100050014], caster, self.card, data, 1100050014)
end
