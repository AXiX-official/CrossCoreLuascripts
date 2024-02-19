local conf = {
	["filename"] = 'g-怪物表.xlsx',
	["sheetname"] = 'AI行为树',
	["types"] = {
'int','string','string','int[]','int[]','json','text'
},
	["names"] = {
'id','key','type','decorator','sub','AICtlParm','ToDo'
},
	["data"] = {
{'1001',	'',	'AICtlDuplicate',	'',	'',	'',	''},
{'1002',	'',	'AIComposite',	'',	'',	'',	''},
{'1003',	'',	'AISelector',	'',	'',	'',	''},
{'1004',	'',	'AISequence',	'',	'',	'',	''},
{'1005',	'',	'AITask',	'',	'',	'',	''},
{'1006',	'',	'AIDecorator',	'',	'',	'',	''},
{'1007',	'',	'AICtlDuplicate',	'2001',	'2002',	'',	''},
{'1008',	'',	'AICtlDuplicate',	'2001',	'2003',	'{"ptDest":1035}',	''},
{'1009',	'',	'AICtlDuplicate',	'2001',	'2004',	'{"ptDestList":[1035,1043]}',	''},
{'1101',	'',	'AICtlDuplicate',	'2011',	'2014',	'',	[[self.oOwner.nAIMoveStep = self.oOwner.nAIMoveStep or 0
self.oOwner.nAIMoveStep = self.oOwner.nAIMoveStep + 1
LogDebugEx("1111111111---",self.oOwner.nAIMoveStep)
AIController.ToDo(self)]]},
{'1102',	'',	'AICtlDuplicate',	'2021',	'2002',	'',	''},
{'2001',	'',	'AIDecorator',	'',	'',	'',	[[if self.oOwner.nStep then
 local mod = (self.oAIController.oDuplicate.nStep - self.oOwner.nIntervaloff) % self.oOwner.nInterval
 if mod == 0 then
  return true
 end
end]]},
{'2002',	'',	'AITask',	'',	'',	'',	[[-- 自己在战斗中
if self.oOwner.state == eDungeonCharState.Fighting then return true end
-- 判断是否有追击对象
local attacker = self.oAIController.oDuplicate:SearchPlayer(self.oOwner)
if not attacker then return true end
self.oAIController.oDuplicate:AIFollow(self.oOwner, attacker)
return true]]},
{'2003',	'',	'AITask',	'',	'',	'',	[[-- 自己在战斗中
if self.oOwner.state == eDungeonCharState.Fighting then return true end
if not self.oAIController.ptDest then return true end
-- 移动到指定点
self.oAIController.oDuplicate:AIMoveToPos(self.oOwner, self.oAIController.ptDest)
return true]]},
{'2004',	'',	'AITask',	'',	'',	'',	[[-- 自己在战斗中
if self.oOwner.state == eDungeonCharState.Fighting then return true end
if not self.oAIController.ptDestList then return true end
-- 移动到指定点
self.oAIController.oDuplicate:AIMoveToPosList(self.oOwner, self.oAIController.ptDestList)
return true]]},
{'2011',	'',	'AIDecorator',	'',	'',	'',	[[if self.oOwner.nStep then
 local mod = (self.oOwner.nAIMoveStep) % self.oOwner.nInterval
LogDebugEx("22222222---",self.oOwner.nStep, self.oOwner.nAIMoveStep,mod)
 if mod == 0 then
  return true
 end
end]]},
{'2012',	'',	'AITask',	'',	'',	'',	[[-- 自己在战斗中
LogDebugEx("4444444---",self.oOwner.nAIMoveStep)
if self.oOwner.state == eDungeonCharState.Fighting then return true end
-- 判断是否有追击对象
local attacker = self.oAIController.oDuplicate:SearchAreaPlayer(self.oOwner, self.oAIController.nSearchRadius)
if not attacker then return end
self.oAIController.oDuplicate:AIFollow(self.oOwner, attacker)
return true]]},
{'2013',	'',	'AITask',	'',	'',	'',	[[self.oOwner.nAIMoveStep = 0
LogDebugEx("3333333333---",self.oOwner.nAIMoveStep)]]},
{'2014',	'',	'AISequence',	'',	'2012,2013',	'',	''},
{'2021',	'',	'AIDecorator',	'',	'',	'',	[[-- 判断有对象触发追击
local attacker = self.oAIController.oDuplicate:SearchAreaPlayer(self.oOwner, self.oAIController.nSearchRadius)
if attacker and not self.oOwner.bAIStart then 
  self.oOwner.bAIStart = true
  self.oOwner.nIntervaloff = self.oAIController.oDuplicate.nStep
  --self.nIntervaloff = self.oAIController.oDuplicate.nStep % self.oOwner.nInterval
  --if self.oOwner.nIntervaloff ~= 0 then
  -- self.oOwner.nIntervaloff = self.oOwner.nInterval - self.oOwner.nIntervaloff
  --end
end

if self.oOwner.nStep and self.oOwner.bAIStart then
 local mod = (self.oAIController.oDuplicate.nStep + self.oOwner.nIntervaloff) % self.oOwner.nInterval
 if mod == 0 then
  return true
 end
end]]},
},
}
--cfgAIBehaviorTree = conf
return conf
