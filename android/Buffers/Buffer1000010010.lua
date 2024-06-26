-- 我方全体+5%速度（可叠加）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010010 = oo.class(BuffBase)
function Buffer1000010010:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010010:OnCreate(caster, target)
	-- 1000010010
	self:AddBuffCount(BufferEffect[1000010010], self.caster, self.card, nil, 1000010011,1,5)
end
