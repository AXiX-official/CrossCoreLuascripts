-- 乌斯怀亚2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304800204 = oo.class(SkillBase)
function Skill304800204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304800204:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 回合开始时
function Skill304800204:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8415
	local count15 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 8896
	if SkillJudger:Greater(self, caster, target, true,count15,0) then
	else
		return
	end
	-- 4304824
	if self:Rand(9000) then
		self:DelBuffQuality(SkillEffect[4304824], caster, self.card, data, 2,1)
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 4304801
		self:OwnerAddBuffCount(SkillEffect[4304801], caster, self.card, data, 304800101,1,8)
	end
end
