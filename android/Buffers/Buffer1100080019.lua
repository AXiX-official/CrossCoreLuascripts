-- 1100080019
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100080019 = oo.class(BuffBase)
function Buffer1100080019:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100080019:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100080019
	self:AddSkill(BufferEffect[1100080019], self.caster, self.card, nil, 907800603)
end
