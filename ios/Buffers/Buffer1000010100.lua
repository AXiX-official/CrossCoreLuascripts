-- 角色被解除控制后，获得+100%暴击 +100%爆伤buff.持续1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010100 = oo.class(BuffBase)
function Buffer1000010100:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010100:OnCreate(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010100
	self:AddBuff(BufferEffect[1000010100], self.caster, self.card, nil, 1000010102)
	-- 1000010101
	self:AddBuff(BufferEffect[1000010101], self.caster, self.card, nil, 1000010103)
end
