local conf = {
	["filename"] = 't-图鉴表.xlsx',
	["sheetname"] = '剧情分组',
	["types"] = {
'int','string','string','string','int'
},
	["names"] = {
'id','key','sName','icon','languageID'
},
	["data"] = {
{'1',	'1',	'主线',	'Plot_01',	'6001'},
{'2',	'2',	'支线',	'Plot_01',	'6002'},
{'3',	'3',	'活动',	'Plot_01',	'6000'},
},
}
--cfgCfgArchiveStoryGroup = conf
return conf
