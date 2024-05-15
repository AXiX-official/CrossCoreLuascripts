-- 参数生成
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304303 = oo.class(SkillBase)
function Skill4304303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4304303:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500123
	self:AddSp(SkillEffect[4500123], caster, self.card, data, 15)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304303
	local targets = SkillFilter:Group(self, caster, target, 3,3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4304303], caster, target, data, 4304303)
	end
	-- 4304306
	self:ShowTips(SkillEffect[4304306], caster, self.card, data, 2,"楪雩",true,4304306)
end
