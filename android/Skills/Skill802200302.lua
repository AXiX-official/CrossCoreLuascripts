-- 脉冲风暴（怪物Ver）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill802200302 = oo.class(SkillBase)
function Skill802200302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill802200302:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 行动结束
function Skill802200302:OnActionOver(caster, target, data)
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
	-- 802200301
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[802200301], caster, target, data, 4002,2)
	end
end
