-- 反击提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102300309 = oo.class(BuffBase)
function Buffer102300309:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer102300309:OnCreate(caster, target)
	-- 102300309
	self:AddAttrPercent(BufferEffect[102300309], self.caster, self.card, nil, "attack",0.45*self.nCount)
end