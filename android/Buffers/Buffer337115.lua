-- 337115_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337115 = oo.class(BuffBase)
function Buffer337115:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337115:OnCreate(caster, target)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337115
	self:AddAttr(BufferEffect[337115], self.caster, target or self.owner, nil,"speed",20*self.nCount)
	-- 8765
	local c765 = SkillApi:GetTeamHP(self, self.caster, target or self.owner,3)
	-- 337125
	self:AddAttr(BufferEffect[337125], self.caster, target or self.owner, nil,"attack",-200)
end
