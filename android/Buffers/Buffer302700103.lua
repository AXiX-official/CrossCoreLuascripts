-- 恐惧
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer302700103 = oo.class(BuffBase)
function Buffer302700103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer302700103:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 302700103
	self:AddAttr(BufferEffect[302700103], self.caster, target or self.owner, nil,"crit",0.07*self.nCount)
end
