-- 肉鸽乐团阵营回复技能buff2（金色2级别）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020041 = oo.class(SkillBase)
function Skill1100020041:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100020041:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8225
	if SkillJudger:IsCtrlType(self, caster, target, true,11) then
	else
		return
	end
	-- 1100020041
	local targets = SkillFilter:Group(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuffCount(SkillEffect[1100020041], caster, target, data, 1100020041,1,3)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8225
	if SkillJudger:IsCtrlType(self, caster, target, true,11) then
	else
		return
	end
	-- 1100020044
	self:AddNp(SkillEffect[1100020044], caster, self.card, data, -10)
end
