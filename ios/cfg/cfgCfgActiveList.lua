local conf = {
	["filename"] = 'h-活动列表.xlsx',
	["sheetname"] = '活动列表',
	["types"] = {
'int','string','int','int','string','string','json','string','int','string'
},
	["names"] = {
'id','key','group','index','sTime','eTime','leftInfo','path','taskType','moduleInfo'
},
	["data"] = {
{'1001',	'1001',	'1',	'4',	'',	'',	'[{"id":22003,"path":"ActivityList/icon1"}]',	'SignIn/SignInView',	'',	''},
{'1002',	'1002',	'1',	'5',	'',	'',	'[{"id":22004,"path":"ActivityList/icon2"}]',	'SignInContinue/SignInContinue',	'',	''},
{'1003',	'1003',	'2',	'1',	'',	'',	'[{"id":22017,"path":"ActivityList/icon4"}]',	'Activity2/MissionContinue',	'2',	''},
{'1004',	'1004',	'2',	'3',	'',	'',	'[{"id":22022,"path":"ActivityList/icon5"}]',	'Activity3/InvestmentView',	'',	'CrystalInvest'},
{'1005',	'1005',	'2',	'2',	'2024-02-07 10:00:00',	'2024-02-21 03:00:00',	'[{"id":22025,"path":"ActivityList/icon7"}]',	'Activity4/MissionNewYearStage',	'3',	''},
{'1006',	'1006',	'1',	'1',	'2024-02-07 10:00:00',	'2024-02-21 03:00:00',	'[{"id":22026,"path":"ActivityList/icon6"}]',	'SignInContinue2/SignInActivity',	'',	''},
{'1007',	'1007',	'1',	'3',	'2022-11-19 03:00:00',	'2022-11-19 03:00:00',	'[{"id":22029,"path":"ActivityList/icon8"}]',	'SignInContinue3/SignInCommon',	'',	''},
{'1008',	'1008',	'1',	'2',	'2024-04-08 10:00:00',	'2024-04-17 03:00:00',	'[{"id":22030,"path":"ActivityList/icon9"}]',	'SignInContinue4/SignInShadowSpider',	'',	''},
},
}
--cfgCfgActiveList = conf
return conf
