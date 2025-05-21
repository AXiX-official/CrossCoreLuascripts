-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704200202 = oo.class(SkillBase)
function Skill704200202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704200202:DoSkill(caster, target, data)
	-- 704200212
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704200212], caster, target, data, 704200212)
end
-- 行动结束
function Skill704200202:OnActionOver(caster, target, data)
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
	-- 704200202
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[704200202], caster, target, data, 704200202)
	end
end
-- 行动结束2
function Skill704200202:OnActionOver2(caster, target, data)
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
	-- 704200222
	self:AddSp(SkillEffect[704200222], caster, self.card, data, 15)
end
