-- 每驱散一个控制效果，增加10点能量值。持续x场战斗
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010060 = oo.class(BuffBase)
function Buffer1000010060:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 驱散buff时
function Buffer1000010060:OnDelBuff(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010060
	self:AddNp(BufferEffect[1000010060], self.caster, self.card, nil, 10)
end
