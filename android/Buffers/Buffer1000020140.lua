-- 我方全体+10%防御力（1级）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020140 = oo.class(BuffBase)
function Buffer1000020140:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020140:OnCreate(caster, target)
	-- 1000020140
	self:AddAttrPercent(BufferEffect[1000020140], self.caster, self.card, nil, "defense",0.1)
end
