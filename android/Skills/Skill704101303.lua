-- 鸣刀技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704101303 = oo.class(SkillBase)
function Skill704101303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704101303:DoSkill(caster, target, data)
	-- 11125
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11125], caster, target, data, 0.2,5)
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8152
	if SkillJudger:Greater(self, caster, self.card, true,count18,60) then
	else
		return
	end
	-- 11126
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11126], caster, target, data, 0.2,1)
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8170
	if SkillJudger:Greater(self, caster, self.card, true,count18,80) then
	else
		return
	end
	-- 11127
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11127], caster, target, data, 0.2,1)
end
