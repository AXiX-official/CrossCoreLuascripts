-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102100304 = oo.class(SkillBase)
function Skill102100304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102100304:DoSkill(caster, target, data)
	-- 11121
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11121], caster, target, data, 0.2,4)
	-- 11122
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11122], caster, target, data, 0.4,1)
end
-- 行动结束
function Skill102100304:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8463
	local count63 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 102100302
	self:RandAddBuff(SkillEffect[102100302], caster, self.card, data, 700+count63,6113,2)
end
