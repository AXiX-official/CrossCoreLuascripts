-- SP昆仑2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000204 = oo.class(SkillBase)
function Skill305000204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000204:DoSkill(caster, target, data)
	-- 305000204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000204], caster, target, data, 305000204)
end
-- 行动结束2
function Skill305000204:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8724
	local count724 = SkillApi:BuffCount(self, caster, target,2,4,305000201)
	-- 8938
	if SkillJudger:Greater(self, caster, self.card, true,count724,0) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 305000221
	self:BeatBack(SkillEffect[305000221], caster, self.card, data, nil,30500)
end
