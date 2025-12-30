-- 瑞泽卦象
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100700101 = oo.class(BuffBase)
function Buffer100700101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer100700101:OnCreate(caster, target)
	-- 8776
	local c776 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41007)
	-- 100700101
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[100700101], self.caster, target, nil, "defense",10*self.nCount*math.floor(c776/2+1))
	end
end
