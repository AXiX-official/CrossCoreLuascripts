-- 提升机动、命中和同步率值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23402 = oo.class(BuffBase)
function Buffer23402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer23402:OnCreate(caster, target)
	-- 23402
	self:AddAttr(BufferEffect[23402], self.caster, self.card, nil, "speed",20)
	-- 23412
	self:AddAttr(BufferEffect[23412], self.caster, self.card, nil, "hit",0.2)
	-- 23422
	self:AddSp(BufferEffect[23422], self.caster, self.card, nil, 20)
end
