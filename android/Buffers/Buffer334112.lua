-- 不显示
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334112 = oo.class(BuffBase)
function Buffer334112:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer334112:OnBefourHurt(caster, target)
	-- 334112
	self:AddTempAttr(BufferEffect[334112], self.caster, self.card, nil, "damage",0.10)
end
