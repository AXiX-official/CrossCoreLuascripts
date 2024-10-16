local conf = {
	["filename"] = 's-宿舍.xlsx',
	["sheetname"] = '宿舍分区',
	["types"] = {
'int','string','string','table#6','int','string','json','int','int','bool'
},
	["names"] = {
'id','key','sName','infos','index','roomName','costs','maxLv','defaultTheme','onlyShow'
},
	["data"] = {
{'1',	'',	'1F',	'',	'',	' 1-1',	'',	'',	'',	''},
{'1',	'',	'',	'',	'1',	' 1-1',	'',	'1',	'4001',	''},
{'2',	'',	'2F',	'',	'',	' 2-1',	'',	'',	'',	''},
{'2',	'',	'',	'',	'1',	' 2-1',	'',	'1',	'',	'1'},
},
}
--cfgCfgDorm = conf
return conf
