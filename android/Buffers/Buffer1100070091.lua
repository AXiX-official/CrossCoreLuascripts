-- 1100070091
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070091 = oo.class(BuffBase)
function Buffer1100070091:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070091:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100070091
	self:AddSkill(BufferEffect[1100070091], self.caster, self.card, nil, 1100070091)
end
