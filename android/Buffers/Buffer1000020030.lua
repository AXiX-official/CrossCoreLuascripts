-- 身上有护盾时增伤20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020030 = oo.class(BuffBase)
function Buffer1000020030:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击开始
function Buffer1000020030:OnAttackBegin(caster, target)
	-- 8738
	local c134 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,4,3)
	-- 1000020199
	if SkillJudger:Greater(self, self.caster, self.card, true,c134,0) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020030
	self:AddAttrPercent(BufferEffect[1000020030], self.caster, self.card, nil, "damage",0.67)
end
