-- 运势
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704300301 = oo.class(BuffBase)
function Buffer704300301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 暴击伤害前(OnBefourHurt之前)
function Buffer704300301:OnBefourCritHurt(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 704300301
	self:AddTempAttr(BufferEffect[704300301], self.caster, self.caster, nil, "crit",-0.15)
end
