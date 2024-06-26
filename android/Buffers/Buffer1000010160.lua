-- 角色解除控制效果时，为自身提供+30点机动，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010160 = oo.class(BuffBase)
function Buffer1000010160:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 驱散buff时
function Buffer1000010160:OnDelBuff(caster, target)
	-- 8256
	if SkillJudger:IsCtrlBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010160
	self:AddBuffCount(BufferEffect[1000010160], self.caster, self.card, nil, 4206,1)
end
