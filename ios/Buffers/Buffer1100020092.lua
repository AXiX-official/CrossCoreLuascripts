-- 开局我方速度提高40%，持续3回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020092 = oo.class(BuffBase)
function Buffer1100020092:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020092:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100020092
	self:AddAttrPercent(BufferEffect[1100020092], self.caster, target or self.owner, nil,"speed",0.4)
end
