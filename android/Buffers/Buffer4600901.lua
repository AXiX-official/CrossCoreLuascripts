-- 慈悲者标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4600901 = oo.class(BuffBase)
function Buffer4600901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4600901:OnBefourHurt(caster, target)
	-- 4600513
	self:AddTempAttr(BufferEffect[4600513], self.caster, self.card, nil, "damage",0.15*self.nCount)
end
