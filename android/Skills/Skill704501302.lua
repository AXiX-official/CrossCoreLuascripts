-- 朝晖技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704501302 = oo.class(SkillBase)
function Skill704501302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704501302:DoSkill(caster, target, data)
	-- 11301
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[11301], caster, target, data, 0.2,5)
	end
	-- 11302
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11302], caster, target, data, 0.5,3)
end
