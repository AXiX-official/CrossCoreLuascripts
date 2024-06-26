-- 降低目标5%*层数的速度，持续5回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010131 = oo.class(BuffBase)
function Buffer1000010131:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010131:OnCreate(caster, target)
	-- 1000010131
	self:AddAttrPercent(BufferEffect[1000010131], self.caster, target or self.owner, nil,"speed",-0.05*self.nCount)
end
-- 攻击结束
function Buffer1000010131:OnAttackOver(caster, target)
	-- 8202
	if SkillJudger:IsNormal(self, self.caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010140
	self:AddBuffCount(BufferEffect[1000010140], self.caster, self.card, nil, 1000010141,1,5)
end
