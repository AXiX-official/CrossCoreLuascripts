-- 能级：易伤Ⅰ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040101 = oo.class(BuffBase)
function Buffer1000040101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000040101:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010160
	self:AddBuff(BufferEffect[1000010160], self.caster, self.card, nil, 1000010161,2)
end
