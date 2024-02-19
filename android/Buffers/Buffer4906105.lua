-- 狂暴状态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4906105 = oo.class(BuffBase)
function Buffer4906105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4906105:OnCreate(caster, target)
	-- 4010
	self:AddAttrPercent(BufferEffect[4010], self.caster, target or self.owner, nil,"attack",0.50)
	-- 4110
	self:AddAttrPercent(BufferEffect[4110], self.caster, target or self.owner, nil,"defense",0.5)
	-- 4210
	self:AddAttr(BufferEffect[4210], self.caster, target or self.owner, nil,"speed",50)
end
