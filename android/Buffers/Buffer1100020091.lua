-- 开局我方速度提高30%，持续3回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020091 = oo.class(BuffBase)
function Buffer1100020091:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020091:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100020091
	self:AddAttrPercent(BufferEffect[1100020091], self.caster, target or self.owner, nil,"speed",0.3)
end
