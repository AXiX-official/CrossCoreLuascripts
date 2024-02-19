-- 反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932800601 = oo.class(SkillBase)
function Skill932800601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill932800601:OnAttackOver(caster, target, data)
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
	-- 932800601
	self:AddBuffCount(SkillEffect[932800601], caster, self.card, data, 932800601,1,5)
end
-- 行动结束2
function Skill932800601:OnActionOver2(caster, target, data)
	-- 8661
	local count661 = SkillApi:GetCount(self, caster, target,3,932800601)
	-- 8868
	if SkillJudger:Greater(self, caster, target, true,count661,4) then
	else
		return
	end
	-- 932800602
	self:DelBuffQuality(SkillEffect[932800602], caster, self.card, data, 2,5)
	-- 932800603
	self:DelBufferForce(SkillEffect[932800603], caster, self.card, data, 932800601)
	-- 932800604
	self:CallOwnerSkill(SkillEffect[932800604], caster, self.card, data, 932800201)
end
