-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100211 = oo.class(SkillBase)
function Skill912100211:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill912100211:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 912103001
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912103001], caster, self.card, data, 912102001)
	-- 912102200
	self.order = self.order + 1
	self:SetInvincible(SkillEffect[912102200], caster, target, data, 4,2,300000,10)
	-- 912102210
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912102210], caster, self.card, data, 912102210)
end
