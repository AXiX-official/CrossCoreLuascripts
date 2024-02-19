-- 同心协力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4101902 = oo.class(SkillBase)
function Skill4101902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4101902:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4101902
	self:SetShareDamage(SkillEffect[4101902], caster, self.card, data, 0.25)
end
-- 伤害后
function Skill4101902:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8480
	local count80 = SkillApi:GetShareDamage(self, caster, target,nil)
	-- 4101911
	local targets = SkillFilter:Teammate(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[4101911], caster, target, data, -math.floor(count80))
	end
	-- 4101906
	self:ShowTips(SkillEffect[4101906], caster, self.card, data, 2,"同心协力",true)
end
-- 行动结束
function Skill4101902:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4101912
	self:AddBuff(SkillEffect[4101912], caster, self.card, data, 4101912)
end
