-- 解除控制后，该单位下次攻击时增加30%伤害,持续1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010070 = oo.class(BuffBase)
function Buffer1000010070:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 驱散buff时
function Buffer1000010070:OnDelBuff(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8256
	if SkillJudger:IsCtrlBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010070
	self:AddBuffCount(BufferEffect[1000010070], self.caster, target or self.owner, nil,1000010071,1,1)
end
