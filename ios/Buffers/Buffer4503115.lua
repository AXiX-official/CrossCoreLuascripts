-- 命中强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4503115 = oo.class(BuffBase)
function Buffer4503115:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4503115:OnCreate(caster, target)
	-- 4505
	self:AddAttr(BufferEffect[4505], self.caster, target or self.owner, nil,"hit",0.25)
end
