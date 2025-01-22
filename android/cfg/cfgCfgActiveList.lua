local conf = {
	["filename"] = 'h-活动列表.xlsx',
	["sheetname"] = '活动列表',
	["types"] = {
'int','string','int','int','int','int','string','string','string','json','string','int','json','string','int[]','int','int'
},
	["names"] = {
'id','key','type','specType','group','index','sTime','eTime','cTime','leftInfo','path','taskType','info','moduleInfo','time','timeType','bIsShow'
},
	["data"] = {
{'1001',	'1001',	'1001',	'',	'1',	'401',	'',	'',	'',	'[{"id":22003,"path":"ActivityList/icon1"}]',	'SignIn/SignInView',	'',	'',	'',	'',	'',	'1'},
{'1002',	'1002',	'1002',	'2',	'1',	'301',	'',	'',	'',	'[{"id":22004,"path":"ActivityList/icon2"}]',	'SignInContinue/SignInContinue',	'',	'',	'',	'',	'',	''},
{'1003',	'1003',	'1003',	'',	'1',	'201',	'',	'',	'',	'[{"id":22017,"path":"ActivityList/icon4"}]',	'Activity2/MissionContinue',	'2',	'[{"taskType":2}]',	'',	'',	'',	'1'},
{'1004',	'1004',	'1004',	'',	'2',	'3',	'',	'',	'',	'[{"id":22022,"path":"ActivityList/icon5"}]',	'Activity3/InvestmentView',	'',	'[{"moduleInfo":"CrystalInvest"}]',	'CrystalInvest',	'2002',	'',	''},
{'1005',	'1005',	'1005',	'',	'1',	'202',	'2024-02-07 10:00:00',	'2025-02-19 03:00:00',	'',	'[{"id":22025,"path":"ActivityList/icon7"}]',	'Activity4/MissionNewYearStage',	'3',	'',	'',	'',	'',	'1'},
{'1006',	'1006',	'1006',	'2',	'1',	'302',	'2024-02-07 10:00:00',	'2024-02-21 03:00:00',	'',	'[{"id":22026,"path":"ActivityList/icon6"}]',	'SignInContinue2/SignInActivity',	'',	'',	'',	'',	'',	''},
{'1007',	'1007',	'1007',	'2',	'1',	'302',	'2022-11-19 03:00:00',	'2022-11-19 03:00:00',	'',	'[{"id":22029,"path":"ActivityList/icon8"}]',	'SignInContinue3/SignInCommon',	'',	'',	'',	'',	'',	''},
{'1008',	'1008',	'1008',	'2',	'1',	'302',	'2024-04-08 10:00:00',	'2024-04-17 03:00:00',	'',	'[{"id":22030,"path":"ActivityList/icon9"}]',	'SignInContinue4/SignInShadowSpider',	'',	'',	'',	'',	'',	''},
{'1009',	'1009',	'1009',	'',	'1',	'204',	'2024-06-19 03:00:00',	'2025-01-22 03:00:00',	'',	'[{"id":22032,"path":"ActivityList/icon10"}]',	'Activity5/DropAddView',	'',	'[{"cfg":"CfgDupDropMulti","id":4}]',	'',	'',	'',	''},
{'1010',	'1010',	'1010',	'',	'3',	'4',	'2024-12-11 10:00:00',	'2024-12-25 03:00:00',	'',	'[{"id":22045,"path":"ActivityList/icon11"}]',	'Activity6/ExchangeView',	'',	'[{"shopId":2001,"goodId":10401}]',	'',	'',	'',	''},
{'1013',	'1013',	'1013',	'2',	'1',	'305',	'2024-07-24 03:00:00',	'2024-08-14 03:00:00',	'',	'[{"id":22060,"path":"ActivityList/icon8"}]',	'SignInContinue5/SignInGold',	'',	'',	'',	'',	'',	''},
{'1011',	'1011',	'1011',	'',	'2',	'4',	'2024-07-24 03:00:00',	'2024-08-28 03:00:00',	'',	'[{"id":22054,"path":"ActivityList/icon11"}]',	'AccuCharge/AccuCharge',	'',	'',	'',	'',	'',	''},
{'1012',	'1012',	'1012',	'',	'4',	'205',	'2024-12-25 03:00:00',	'2025-01-20 03:00:00',	'',	'[{"id":22084,"path":"ActivityList/icon15"}]',	'Collaboration/CollaborationMain',	'',	'',	'',	'',	'',	''},
{'1014',	'1014',	'1014',	'2',	'1',	'305',	'2024-09-13 12:00:00',	'2024-09-23 03:00:00',	'',	'[{"id":22061,"path":"ActivityList/icon12"}]',	'SignInContinue6/SignInZhongQiu',	'',	'',	'',	'',	'',	''},
{'1015',	'1015',	'1015',	'1',	'1',	'306',	'2024-02-10 00:00:00',	'2024-02-10 00:00:00',	'',	'[{"id":22062,"path":"ActivityList/icon8"}]',	'SignInContinue7/SignInGift',	'',	'{"signInId":5001,"PaySignTime":15}',	'',	'',	'',	''},
{'1016',	'1016',	'1016',	'2',	'1',	'305',	'2024-09-30 12:00:00',	'2024-10-10 03:00:00',	'',	'[{"id":22063,"path":"ActivityList/icon13"}]',	'SignInContinue8/SignInNational',	'',	'',	'',	'',	'',	''},
{'1017',	'1017',	'1017',	'',	'2',	'203',	'2024-08-25 10:00:00',	'2024-10-16 03:00:00',	'',	'[{"id":67001,"path":"ActivityList/icon14"}]',	'Gacha/GachaMain',	'',	'[{"cfgId":1003,"jumpId":140014}]',	'',	'',	'',	'1'},
{'1018',	'1018',	'1018',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'{"NoticeId":7,"start":0,"finish":48,"mailId":40003}',	'',	'2002',	'',	'1'},
{'1019',	'1019',	'1019',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'{"NoticeId":8,"start":48,"finish":-1}',	'',	'2002',	'',	'1'},
{'1020',	'1020',	'1020',	'',	'',	'',	'2024-2-11 00:00:00',	'2024-12-11 10:00:00',	'',	'',	'',	'',	'{"NoticeId":1,"mailId":40003}',	'',	'',	'',	''},
{'1021',	'1021',	'1021',	'',	'',	'',	'2024-02-10 00:00:00',	'2025-01-04 23:59:59',	'',	'',	'',	'',	'{"passDupId":1001,"freeCnt":1}',	'',	'',	'',	''},
{'1023',	'1023',	'1023',	'',	'2',	'7',	'2024-12-25 00:00:00',	'2025-01-22 03:00:00',	'',	'[{"id":22089,"path":"ActivityList/icon11"}]',	'AccuCharge/AccuChargeT',	'',	'{"mailId":40003}',	'',	'',	'',	''},
{'1024',	'1024',	'1024',	'2',	'1',	'302',	'2024-1-25 12:00:00',	'2025-01-04 03:00:00',	'',	'[{"id":22090,"path":"ActivityList/icon3"}]',	'SignInContinue11/SignInAnniversary3',	'',	'',	'',	'',	'',	'1'},
{'1025',	'1025',	'1025',	'2',	'1',	'302',	'2024-1-25 12:00:00',	'2025-01-12 03:00:00',	'',	'[{"id":22091,"path":"ActivityList/icon2"}]',	'SignInContinue9/SignInAnniversary1',	'',	'',	'',	'',	'',	'1'},
{'1026',	'1026',	'1026',	'2',	'1',	'302',	'2024-1-25 12:00:00',	'2025-01-08 03:00:00',	'',	'[{"id":22092,"path":"ActivityList/icon3"}]',	'SignInContinue10/SignInAnniversary2',	'',	'',	'',	'',	'',	'1'},
{'1027',	'1027',	'1027',	'2',	'1',	'302',	'2024-1-25 12:00:00',	'2025-01-22 03:00:00',	'',	'[{"id":22093,"path":"ActivityList/icon3"}]',	'SignInContinue12/SignInAnniversary4',	'',	'',	'',	'',	'',	'1'},
{'1028',	'1028',	'1028',	'2',	'1',	'303',	'2025-1-27 03:00:00',	'2025-02-06 23:59:59',	'',	'[{"id":22026,"path":"ActivityList/icon6"}]',	'SignInContinue2/SignInActivity',	'',	'',	'',	'',	'',	''},
},
}
--cfgCfgActiveList = conf
return conf
