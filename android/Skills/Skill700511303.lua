-- 冥界之门（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700511303 = oo.class(SkillBase)
function Skill700511303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700511303:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
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
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8189
	if SkillJudger:Greater(self, caster, target, true,count20,count67) then
	else
		return
	end
	-- 700511301
	if self:Rand(2000) then
		self:tFunc_700511301_700511302(caster, target, data)
		self:tFunc_700511301_700511303(caster, target, data)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 700510207
	self.order = self.order + 1
	self:RemoveDead(SkillEffect[700510207], caster, target, data, nil)
end
function Skill700511303:tFunc_700511301_700511302(caster, target, data)
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 700511302
	self.order = self.order + 1
	self:AddHp(SkillEffect[700511302], caster, target, data, -count67,1)
end
function Skill700511303:tFunc_700511301_700511303(caster, target, data)
	-- 700511303
	self.order = self.order + 1
	self:BeatAgain(SkillEffect[700511303], caster, target, data, nil)
end
