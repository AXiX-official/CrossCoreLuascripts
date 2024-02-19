local conf = {
	["filename"] = 'g-关卡表.xlsx',
	["sheetname"] = '其他入口',
	["types"] = {
'int','int','string','int','int[]','int','int','int','int','string','string','string','string','string','string','string'
},
	["names"] = {
'id','key','name','group','openTime','count','cd','angle_x','angle_y','lock_desc','icon','descImg','oName','eName','nameImg','jumpParam'
},
	["data"] = {
{'1',	'',	'镜像竞技',	'3',	'',	'',	'',	'',	'',	'',	'chapter_51',	'',	'INSTANT',	'CONFRONTATION',	'p_title_001',	'1'},
{'2',	'',	'实时作战',	'3',	'',	'',	'',	'',	'',	'',	'chapter_52',	'',	'BATTLE',	'BATTLE?SIMULATION',	'p_title_002',	'2'},
},
}
--cfgSectionOther = conf
return conf
