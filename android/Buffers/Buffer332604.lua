-- 蠢动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332604 = oo.class(BuffBase)
function Buffer332604:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer332604:OnBefourHurt(caster, target)
	-- 332604
	self:AddAttr(BufferEffect[332604], self.caster, self.card, nil, "bedamage",-0.08*self.nCount)
end
-- 行动结束
function Buffer332604:OnActionOver(caster, target)
	-- 332614
	self:AddProgress(BufferEffect[332614], self.caster, self.card, nil, 160*self.nCount)
end
