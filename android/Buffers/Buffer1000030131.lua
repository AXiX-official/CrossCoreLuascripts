-- 当角色身上有【增伤】词条时，增加暴击率+30%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030131 = oo.class(BuffBase)
function Buffer1000030131:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000030131:OnCreate(caster, target)
	-- 1000030131
	if SkillJudger:HasBuff(self, self.caster, target, true,1,1000030010) then
	else
		return
	end
end
