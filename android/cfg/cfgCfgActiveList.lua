local conf = {
	["filename"] = 'h-活动列表.xlsx',
	["sheetname"] = '活动列表',
	["types"] = {
'int','string','int','int','int','string','string','json','string','int','json','string','int[]'
},
	["names"] = {
'id','key','type','group','index','sTime','eTime','leftInfo','path','taskType','info','moduleInfo','time'
},
	["data"] = {
{'1001',	'1001',	'',	'1',	'4',	'',	'',	'[{"id":22003,"path":"ActivityList/icon1"}]',	'SignIn/SignInView',	'',	'',	'',	''},
{'1002',	'1002',	'2',	'1',	'5',	'',	'',	'[{"id":22004,"path":"ActivityList/icon2"}]',	'SignInContinue/SignInContinue',	'',	'',	'',	''},
{'1003',	'1003',	'',	'2',	'1',	'',	'',	'[{"id":22017,"path":"ActivityList/icon4"}]',	'Activity2/MissionContinue',	'2',	'[{"taskType":2}]',	'',	''},
{'1004',	'1004',	'',	'2',	'3',	'',	'',	'[{"id":22022,"path":"ActivityList/icon5"}]',	'Activity3/InvestmentView',	'',	'[{"moduleInfo":"CrystalInvest"}]',	'CrystalInvest',	'2002'},
{'1005',	'1005',	'',	'2',	'2',	'2024-02-07 10:00:00',	'2024-02-21 03:00:00',	'[{"id":22025,"path":"ActivityList/icon7"}]',	'Activity4/MissionNewYearStage',	'3',	'',	'',	''},
{'1006',	'1006',	'2',	'1',	'1',	'2024-02-07 10:00:00',	'2024-02-21 03:00:00',	'[{"id":22026,"path":"ActivityList/icon6"}]',	'SignInContinue2/SignInActivity',	'',	'',	'',	''},
{'1007',	'1007',	'2',	'1',	'3',	'2022-11-19 03:00:00',	'2022-11-19 03:00:00',	'[{"id":22029,"path":"ActivityList/icon8"}]',	'SignInContinue3/SignInCommon',	'',	'',	'',	''},
{'1008',	'1008',	'2',	'1',	'2',	'2024-04-08 10:00:00',	'2024-04-17 03:00:00',	'[{"id":22030,"path":"ActivityList/icon9"}]',	'SignInContinue4/SignInShadowSpider',	'',	'',	'',	''},
{'1009',	'1009',	'',	'2',	'4',	'2024-06-19 03:00:00',	'2024-06-26 03:00:00',	'[{"id":22032,"path":"ActivityList/icon10"}]',	'Activity5/DropAddView',	'',	'[{"cfg":"CfgDupDropMulti","id":4}]',	'',	''},
{'1013',	'1013',	'2',	'1',	'6',	'2024-07-24 03:00:00',	'2024-08-14 03:00:00',	'[{"id":22060,"path":"ActivityList/icon8"}]',	'SignInContinue5/SignInGold',	'',	'',	'',	''},
{'1011',	'1011',	'',	'2',	'4',	'2024-07-24 03:00:00',	'2024-08-28 03:00:00',	'[{"id":22054,"path":"ActivityList/icon11"}]',	'AccuCharge/AccuCharge',	'',	'',	'',	''},
{'1014',	'1014',	'2',	'1',	'5',	'2024-09-13 12:00:00',	'2024-09-23 03:00:00',	'[{"id":22061,"path":"ActivityList/icon12"}]',	'SignInContinue6/SignInZhongQiu',	'',	'',	'',	''},
{'1015',	'1015',	'1',	'1',	'5',	'2024-02-10 00:00:00',	'2024-02-10 00:00:00',	'[{"id":22062,"path":"ActivityList/icon8"}]',	'SignInContinue7/SignInGift',	'',	'{"signInId":5001,"PaySignTime":15}',	'',	''},
{'1016',	'1016',	'2',	'1',	'6',	'2024-09-30 12:00:00',	'2024-10-10 03:00:00',	'[{"id":22063,"path":"ActivityList/icon13"}]',	'SignInContinue8/SignInNational',	'',	'',	'',	''},
{'1017',	'1017',	'',	'2',	'1',	'2024-08-25 10:00:00',	'2024-10-16 03:00:00',	'[{"id":67001,"path":"ActivityList/icon14"}]',	'Gacha/GachaMain',	'',	'[{"cfgId":1003,"jumpId":140014}]',	'',	''},
},
}
--cfgCfgActiveList = conf
return conf
