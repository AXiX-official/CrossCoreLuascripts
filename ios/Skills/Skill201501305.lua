-- 缭乱幻想（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201501305 = oo.class(SkillBase)
function Skill201501305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201501305:DoSkill(caster, target, data)
	-- 11084
	self.order = self.order + 1
	local targets = SkillFilter:Different(self, caster, target, 4,6)
	for i,target in ipairs(targets) do
		-- 11085
		self:DamageLight(SkillEffect[11085], caster, target, data, 1,1)
		-- 11086
		self:AddOrder(SkillEffect[11086], caster, target, data, nil)
	end
	-- 201501305
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[201501305], caster, target, data, 6000,3501)
end