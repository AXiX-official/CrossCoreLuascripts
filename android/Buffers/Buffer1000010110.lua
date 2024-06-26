-- 战斗开始时，我方全体+100%速度，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010110 = oo.class(BuffBase)
function Buffer1000010110:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer1000010110:OnStart(caster, target)
	do
		-- 1000010110
		self:AddBuffCount(BufferEffect[1000010110], self.caster, self.card, nil, 1000010111,1,1)
	end
end
