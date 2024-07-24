-- 战斗开始给敌方全体-10%速度，每场战斗持续5回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010120 = oo.class(BuffBase)
function Buffer1000010120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010120:OnCreate(caster, target)
	-- 1000010120
	self:AddBuffCount(BufferEffect[1000010120], self.caster, self.card, nil, 1000010121,1,1)
end
