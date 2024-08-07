local conf = {
	["filename"] = 'z-章节表.xlsx',
	["sheetname"] = '普通活动',
	["types"] = {
'int','int','string','int','string','int','int','int','int[]','json','int','int','int','int','int[]','int','int','int','string','string','string','string','json','int[]','string','string','string','string','float','int','int','int','string[]','string[]','string[]','string','string','int'
},
	["names"] = {
'id','key','chapter','type','name','pos','onlyOne','open_tips','conditions','info','index','group','fade','activeId','openTime','dailyEnumID','count','cd','lock_desc','desc','icon','descImg','fallRewards','starRewardID','mName','eName','sBg','bg','bgPosZ','multiId','sOpen','preSection','passDesc','nextOpenDesc','diffPassDesc','descKey','bgm','story'
},
	["data"] = {
{'1001',	'',	'碎星虚影',	'101',	'戈里刻虚影',	'1',	'1',	'',	'4001',	'[{"view":"DungeonTower"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Daiburosu illusion',	'aBg1_2',	'tBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'1002',	'',	'碎星虚影',	'101',	'诺斯虚影',	'1',	'1',	'',	'4002',	'[{"view":"DungeonTower"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'通关[虚影稽查者]后开启',	'',	'',	'',	'',	'',	'',	'Daiburosu illusion',	'aBg1_2',	'tBg2',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'2001',	'',	'拂晓之战',	'102',	'拂晓之战',	'2',	'1',	'',	'4001',	'[{"view":"BattleField"}]',	'',	'3',	'2',	'1',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Daiburosu illusion',	'aBg1_5',	'bBg1',	'11.3',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'3001',	'',	'真假惊魂夜',	'103',	'真假惊魂夜',	'3',	'',	'',	'2009',	'[{"view":"DungeonActivity1","childView": "DungeonPlot","goodsId":10015,"bgm":"TEx_MovieHorrorJazzyVer","taskType":9 }]',	'',	'3',	'1',	'2',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Arachnids In The Twilight',	'aBg1_4',	'dBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'3003',	'',	'迷城蛛影',	'103',	'迷城蛛影',	'4',	'',	'',	'2009',	'[{"view":"DungeonActivity4","childView": "DungeonShadowSpider","goodsId":10016,"bgm":"Event_ArachnidsInTheTwilight","taskType":9 }]',	'',	'3',	'2',	'4',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Tarantula Shadow',	'aBg1_7',	'dBg1',	'',	'4',	'',	'',	'',	'',	'',	'',	'',	'20200'},
{'3004',	'',	'绮境笺宴',	'103',	'绮境笺宴',	'4',	'',	'',	'2009',	'[{"view":"DungeonActivity5","childView": "DungeonFeast","goodsId":10101,"bgm":"Event_FairytaleFeastInvitation","taskType":9 }]',	'',	'3',	'2',	'4',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Fairytale Feast Invitation',	'aBg1_9',	'dBg1',	'',	'4',	'',	'',	'',	'',	'',	'',	'',	'20400'},
{'4001',	'',	'拟真演训',	'104',	'拟真演训',	'5',	'',	'',	'2009',	'[{"view":"DungeonActivity2"}]',	'',	'3',	'2',	'3',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Pseudo Training',	'aBg1_3',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'4002',	'',	'拟真演训',	'104',	'拟真演训',	'5',	'',	'',	'2009',	'[{"view":"DungeonActivity2"}]',	'',	'3',	'2',	'6',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Pseudo Training',	'aBg1_3',	'dBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'4003',	'',	'拟真演训',	'104',	'拟真演训',	'5',	'',	'',	'2009',	'[{"view":"DungeonActivity2"}]',	'',	'3',	'2',	'9',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Pseudo Training',	'aBg1_3',	'dBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'7001',	'',	'异构空间',	'105',	'异构空间',	'1',	'1',	'',	'4001',	'[{"view":"TowerView"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Isomeric space',	'aBg1_10',	'tBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'7002',	'',	'异构空间',	'105',	'异构空间（深潜）',	'1',	'1',	'',	'4001',	'[{"view":"TowerView"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Isomeric space',	'aBg1_10',	'tBg2',	'',	'',	'',	'',	'',	'',	'',	'c_img_4_1|队员≤3',	'',	''},
{'8001',	'',	'雷霆试炼',	'104',	'雷霆试炼',	'6',	'',	'',	'2009',	'[{"view":"DungeonTaoFa"}]',	'',	'3',	'1',	'12',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Thunder Trial',	'aBg1_12',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'9001',	'',	'溯源探查',	'107',	'波拉克斯',	'7',	'1',	'',	'2009',	'[{"view":"TotalBattle","rankId":51012,"bgm":"Event_TheTwelveHouseMainTheme1"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'Pollux_Page',	'',	'',	'',	'',	'Daiburosu illusion',	'aBg1_13',	'tBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'9002',	'',	'溯源探查',	'107',	'卡斯托',	'7',	'1',	'',	'2009',	'[{"view":"TotalBattle","rankId":51013,"bgm":"Event_TheTwelveHouseMainTheme1"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'Castor_Page',	'',	'',	'',	'',	'Daiburosu illusion',	'aBg1_13',	'tBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'9003',	'',	'溯源探查',	'107',	'双子座',	'7',	'1',	'',	'2009',	'[{"view":"TotalBattle","rankId":51014,"bgm":"Event_TheTwelveHouseMainTheme1"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'Gemini_Page',	'',	'',	'',	'',	'Daiburosu illusion',	'aBg1_13',	'tBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'11001',	'',	'乱序演习',	'108',	'乱序演习',	'8',	'',	'',	'4001',	'[{"view":"RogueView"}]',	'',	'3',	'1',	'',	'1,1,1,1,1,1,1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'Disorderly Exercise',	'aBg1_11',	'tBg1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
},
}
--cfgSection3 = conf
return conf
