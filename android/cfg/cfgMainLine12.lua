local conf = {
	["filename"] = 'g-关卡表.xlsx',
	["sheetname"] = '关卡配置表-十二星宫',
	["types"] = {
'int','int','string','string','int','int','string','int','bool','int','int','int[]','int[]','int','int[]','int[]','int','int','json','json','int','int','int','json','int','int','int','int','int','int','int','int','int[]','int[]','int[]','int[]','int[]','int[]','int[]','int[]','int','int[]','int[]','int[]','int[]','int[]','json','json','int[]','int[]','int[]','json','json','string','json','string','int','int','int[]','string','string','string','int','int'
},
	["names"] = {
'id','key','name','chapterID','group','type','bgm','sub_type','bSingle','nGroupID','LockLevel','preChapterID','lasChapterID','teamNum','arrForceTeam','arrNPC','modUpCnt','modUpOpenId','modUpResetCost','modUpCost','nResetType','nResetValue','modUpResetType','cost','enterCostHot','winCostHot','gold','exp','plrExp','reward','eliteReward','bossReward','fixedReward','randomReward','littleReward','mRewardPrev','rRewardPrev','bRewardPrev','wave3','wave4','eliteLimit','wave1','wave2','aFreshRule','weight','disorderly','fisrtPassReward','fisrt3StarReward','star1','star2','star3','jWinCon','jLostCon','introduce','useItems','lvTips','itemPreview','storyID','enemyPreview','previewLv','checkImage','map','starIx','hp'
},
	["data"] = {
{'30101',	'30101',	'波拉克斯',	'简单',	'9001',	'11',	'Map_Prologue',	'',	'',	'21010101',	'1',	'',	'30102',	'1',	'',	'',	'-1',	'1030101',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31601',	'31601',	'31601',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101111',	'50',	'bg5',	'map_test',	'',	'146829'},
{'30102',	'30102',	'波拉克斯',	'普通',	'9001',	'11',	'Map_Prologue',	'',	'',	'21010102',	'1',	'30101',	'30103',	'1',	'',	'',	'-1',	'1030102',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31602',	'31602',	'31602',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101121',	'80',	'bg5',	'map_test',	'',	'306790'},
{'30103',	'30103',	'波拉克斯',	'困难',	'9001',	'11',	'Map_Prologue',	'',	'',	'21010103',	'1',	'30102',	'30104',	'1',	'',	'',	'-1',	'1030103',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31603',	'31603',	'31603',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101131',	'100',	'bg5',	'map_test',	'',	'579969'},
{'30104',	'30104',	'波拉克斯',	'地狱',	'9001',	'11',	'Map_Prologue',	'',	'',	'21010104',	'1',	'30103',	'',	'1',	'',	'',	'-1',	'1030104',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31604',	'31604',	'31604',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101141',	'120',	'bg5',	'map_test',	'',	'829500'},
{'30105',	'30105',	'卡斯托',	'简单',	'9002',	'11',	'Map_Prologue',	'',	'',	'21010201',	'1',	'',	'30106',	'1',	'',	'',	'-1',	'1030105',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31605',	'31605',	'31605',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101211',	'50',	'bg5',	'map_test',	'',	'162997'},
{'30106',	'30106',	'卡斯托',	'普通',	'9002',	'11',	'Map_Prologue',	'',	'',	'21010202',	'1',	'30105',	'30107',	'1',	'',	'',	'-1',	'1030106',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31606',	'31606',	'31606',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101221',	'80',	'bg5',	'map_test',	'',	'293536'},
{'30107',	'30107',	'卡斯托',	'困难',	'9002',	'11',	'Map_Prologue',	'',	'',	'21010203',	'1',	'30106',	'30108',	'1',	'',	'',	'-1',	'1030107',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31607',	'31607',	'31607',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101231',	'100',	'bg5',	'map_test',	'',	'554895'},
{'30108',	'30108',	'卡斯托',	'地狱',	'9002',	'11',	'Map_Prologue',	'',	'',	'21010204',	'1',	'30107',	'',	'1',	'',	'',	'-1',	'1030108',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31608',	'31608',	'31608',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101241',	'120',	'bg5',	'map_test',	'',	'787992'},
{'30109',	'30109',	'双子座',	'简单',	'9003',	'11',	'Map_Prologue',	'',	'',	'21010301',	'1',	'',	'30110',	'1',	'',	'',	'-1',	'1030109',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31609',	'31609',	'31609',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101311',	'60',	'bg5',	'map_test',	'',	'166252'},
{'30110',	'30110',	'双子座',	'普通',	'9003',	'11',	'Map_Prologue',	'',	'',	'21010302',	'1',	'30109',	'30111',	'1',	'',	'',	'-1',	'1030110',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31610',	'31610',	'31610',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101321',	'80',	'bg5',	'map_test',	'',	'293536'},
{'30111',	'30111',	'双子座',	'困难',	'9003',	'11',	'Map_Prologue',	'',	'',	'21010303',	'1',	'30110',	'30112',	'1',	'',	'',	'-1',	'1030111',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31611',	'31611',	'31611',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101331',	'100',	'bg5',	'map_test',	'',	'476172'},
{'30112',	'30112',	'双子座',	'地狱',	'9003',	'11',	'Map_Prologue',	'',	'',	'21010304',	'1',	'30111',	'',	'1',	'',	'',	'-1',	'1030112',	'',	'',	'1',	'1',	'',	'[[12009,1,2]]',	'0',	'0',	'0',	'0',	'0',	'31612',	'31612',	'31612',	'10102',	'',	'',	'',	'',	'',	'',	'',	'0',	'',	'',	'1',	'',	'',	'[[10102,120,2]]',	'',	'1,1',	'2,1',	'3,1',	'[1]',	'[[3,99]]',	'1、危险等级会在解锁地狱难度后全部开放，总队长可在此验证自己的战力\n2、危险等级越高，怪物战力越强',	'',	'24000',	'',	'',	'110101341',	'130',	'bg5',	'map_test',	'',	'911647'},
},
}
--cfgMainLine12 = conf
return conf