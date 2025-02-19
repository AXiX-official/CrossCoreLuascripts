-- 狮子座普通形态被动3狩猎标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984200803 = oo.class(BuffBase)
function Buffer984200803:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984200803:OnCreate(caster, target)
	-- 984200803
	self:AddAttr(BufferEffect[984200803], self.caster, target or self.owner, nil,"attack",1*self.nCount)
end
