-- 参数生成
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500102 = oo.class(SkillBase)
function Skill4500102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4500102:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500122
	self:AddSp(SkillEffect[4500122], caster, self.card, data, 10)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500102
	local targets = SkillFilter:Group(self, caster, target, 3,5)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4500102], caster, target, data, 4500102)
	end
	-- 4500106
	self:ShowTips(SkillEffect[4500106], caster, self.card, data, 2,"参数生成",true,4500106)
end
