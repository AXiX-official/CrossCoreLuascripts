local conf = {
	["filename"] = 's-宿舍.xlsx',
	["sheetname"] = '舒适度效果',
	["types"] = {
'int','string','string','int'
},
	["names"] = {
'id','key','desc','num'
},
	["data"] = {
{'0',	'0',	'无效果',	''},
{'100',	'100',	'房间内角色疲劳恢复速度+20%',	'20'},
{'200',	'200',	'房间内角色疲劳恢复速度+50%',	'50'},
{'300',	'300',	'房间内角色疲劳恢复速度+100%',	'100'},
},
}
--cfgCfgComfortLv = conf
return conf
