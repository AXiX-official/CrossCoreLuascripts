-- 运势
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020144 = oo.class(BuffBase)
function Buffer1100020144:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合结束时
function Buffer1100020144:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 6122
	self:ExtraRound(BufferEffect[6122], self.caster, self.card, nil, nil)
end
