-- 冲击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill906100701 = oo.class(SkillBase)
function Skill906100701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill906100701:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 死亡时
function Skill906100701:OnDeath(caster, target, data)
	-- 906100702
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:HitAddBuff(SkillEffect[906100702], caster, target, data, 10000,5006,2)
	end
end
