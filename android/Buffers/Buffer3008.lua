-- 拘束力场
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3008 = oo.class(BuffBase)
function Buffer3008:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3008:OnCreate(caster, target)
	-- 3008
	self:Cage(BufferEffect[3008], self.caster, target or self.owner, nil,1,0.05)
end
-- 回合结束时
function Buffer3008:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 3018
	self:AttackCage(BufferEffect[3018], self.caster, target or self.owner, nil,1.2)
end
