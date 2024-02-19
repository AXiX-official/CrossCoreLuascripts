local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '心理咨询室等级',
	["types"] = {
'int','string','int','int','json','int','int','int','int','int[]','int','int[]','int','string'
},
	["names"] = {
'id','key','centerlvl','upTime','upCosts','roleLimit','powerVal','maxHp','armorType','tiredVal','dailyRewardCnt','roleExpVal','dailyRoleExpLimit','effect'
},
	["data"] = {
{'1',	'1',	'1',	'1',	'[[60101,100,2],[10001,100,2]]',	'5',	'0',	'',	'',	'',	'5',	'30,1',	'10',	''},
},
}
--cfgCfgPhyRoomLvl = conf
return conf
