-- 攻击弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer500100301 = oo.class(BuffBase)
function Buffer500100301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer500100301:OnCreate(caster, target)
	-- 5004
	self:AddAttrPercent(BufferEffect[5004], self.caster, target or self.owner, nil,"attack",-0.2)
end
