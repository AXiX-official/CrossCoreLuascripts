-- 不显示
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334114 = oo.class(BuffBase)
function Buffer334114:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer334114:OnBefourHurt(caster, target)
	-- 334114
	self:AddTempAttr(BufferEffect[334114], self.caster, self.card, nil, "damage",0.20)
end
