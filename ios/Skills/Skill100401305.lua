-- 弧光壁垒（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100401305 = oo.class(SkillBase)
function Skill100401305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100401305:DoSkill(caster, target, data)
	-- 100400311
	self.order = self.order + 1
	self:AddLightShieldCount(SkillEffect[100400311], caster, target, data, 2309,4,10)
end
-- 伤害后
function Skill100401305:OnAfterHurt(caster, target, data)
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
	-- 8421
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	-- 8441
	local count41 = SkillApi:BuffCount(self, caster, target,2,1,15)
	-- 8124
	if SkillJudger:Greater(self, caster, self.card, true,count41,0) then
	else
		return
	end
	-- 100400306
	self:AddHp(SkillEffect[100400306], caster, caster, data, -count21*0.30)
end
