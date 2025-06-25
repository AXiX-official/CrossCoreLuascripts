-- 重力压制
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911900201 = oo.class(SkillBase)
function Skill911900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911900201:DoSkill(caster, target, data)
	-- 12207
	self.order = self.order + 1
	local targets = SkillFilter:Different(self, caster, target, 4,3)
	for i,target in ipairs(targets) do
		-- 12208
		local targets = SkillFilter:Row(self, caster, target, 2)
		for i,target in ipairs(targets) do
			self:DamageLight(SkillEffect[12208], caster, target, data, 1,1)
		end
		-- 12209
		self:AddOrder(SkillEffect[12209], caster, target, data, nil)
		-- 8331
		self:AddValue(SkillEffect[8331], caster, target, data, "suaijian",1)
	end
end
