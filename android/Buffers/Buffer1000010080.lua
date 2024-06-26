-- 战斗开始时+50np，同时提供一层【加速】
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010080 = oo.class(BuffBase)
function Buffer1000010080:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer1000010080:OnStart(caster, target)
	do
		-- 1000010080
		self:AddNp(BufferEffect[1000010080], self.caster, self.card, nil, 50)
	end
end
