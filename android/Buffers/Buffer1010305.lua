-- 充能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1010305 = oo.class(BuffBase)
function Buffer1010305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer1010305:OnActionBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1010305
	self:AddNp(BufferEffect[1010305], self.caster, self.card, nil, 2)
end
