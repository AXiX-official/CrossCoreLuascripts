-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2138 = oo.class(BuffBase)
function Buffer2138:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer2138:OnRoundBegin(caster, target)
	self:ImmuneBuffQuality(BufferEffect[6103], self.caster, target or self.owner, nil,2)
end
-- 创建时
function Buffer2138:OnCreate(caster, target)
	self:AddShield(BufferEffect[2118], self.caster, target or self.owner, nil,1,0.116)
end
