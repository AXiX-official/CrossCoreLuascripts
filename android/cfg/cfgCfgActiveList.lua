local conf = {
	["filename"] = 'h-活动列表.xlsx',
	["sheetname"] = '活动列表',
	["types"] = {
'int','string','int','string','string','json','string','int','int','string'
},
	["names"] = {
'id','key','index','sTime','eTime','leftInfo','path','taskType','group','moduleInfo'
},
	["data"] = {
{'1001',	'1001',	'2',	'',	'',	'[{"id":22003,"path":"ActivityList/icon1"}]',	'SignIn/SignInView',	'',	'1',	''},
{'1002',	'1002',	'3',	'',	'',	'[{"id":22004,"path":"ActivityList/icon2"}]',	'SignInContinue/SignInContinue',	'',	'1',	''},
{'1003',	'1003',	'1',	'',	'',	'[{"id":22017,"path":"ActivityList/icon4"}]',	'Activity2/MissionContinue',	'2',	'2',	''},
{'1004',	'1004',	'3',	'',	'',	'[{"id":22022,"path":"ActivityList/icon5"}]',	'Activity3/InvestmentView',	'',	'2',	'CrystalInvest'},
{'1005',	'1005',	'2',	'2024-02-07 10:00:00',	'2024-02-21 03:00:00',	'[{"id":22025,"path":"ActivityList/icon7"}]',	'Activity4/MissionNewYearStage',	'3',	'2',	''},
{'1006',	'1006',	'1',	'2024-02-07 10:00:00',	'2024-02-21 03:00:00',	'[{"id":22026,"path":"ActivityList/icon6"}]',	'SignInContinue2/SignInActivity',	'',	'1',	''},
},
}
--cfgCfgActiveList = conf
return conf
