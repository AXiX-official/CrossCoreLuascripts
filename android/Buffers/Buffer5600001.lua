-- 1100080011
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5600001 = oo.class(BuffBase)
function Buffer5600001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5600001:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5600001
	self:AddSkill(BufferEffect[5600001], self.caster, self.card, nil, 5600001)
end
