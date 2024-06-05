local conf = {
	["filename"] = 'z-章节表.xlsx',
	["sheetname"] = '角色剧情活动',
	["types"] = {
'int','int','string','int','string','int','int','int[]','json','int','int','int','int','int','string','string[]','int[]','int','int','int','string','string','string','string','json','int[]','string','string','string','string','float','int','int','int','string[]','string[]','string[]','string','string','int'
},
	["names"] = {
'id','key','chapter','type','name','pos','open_tips','conditions','info','index','group','fade','activeId','turnNum','turnImg','turnIcon','openTime','dailyEnumID','count','cd','lock_desc','desc','icon','descImg','fallRewards','starRewardID','mName','eName','sBg','bg','bgPosZ','multiId','sOpen','preSection','passDesc','nextOpenDesc','diffPassDesc','descKey','bgm','story'
},
	["data"] = {
{'5001',	'',	'迷躇樊笼',	'103',	'迷躇樊笼',	'4',	'',	'2009',	'[{"view":"DungeonActivity3","childView": "DungeonRole","goodsId":10201,"bgm":"Sys_Hesitant_Cage","taskType":9 }]',	'1',	'3',	'2',	'5',	'4',	'bg_5001',	'icon1',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Fairytale Feast Invitation',	'aBg1_6',	'dBg1',	'',	'4',	'',	'',	'',	'',	'',	'',	'',	'20100'},
{'5002',	'',	'焕然心生',	'103',	'焕然心生',	'4',	'',	'2009',	'[{"view":"DungeonActivity6","childView": "DungeonRole","goodsId":10201,"bgm":"Sys_Lobby","taskType":9 }]',	'1',	'3',	'2',	'8',	'4',	'bg_5002',	'icon2',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Refreshed Heartbeat',	'aBg1_8',	'dBg1',	'',	'4',	'',	'',	'',	'',	'',	'',	'',	'20300'},
},
}
--cfgSection5 = conf
return conf
