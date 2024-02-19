local conf = {
	["filename"] = 'f-防沉迷.xlsx',
	["sheetname"] = '账号限制',
	["types"] = {
'int','string','table#17','int','string','int','int','bool','float','float','float','int','int','int[]','int','string','string','string','string','string'
},
	["names"] = {
'id','key','infos','index','name','ageLimitA','ageLimitB','registerLimit','workdayTime','holidayTime','sumTime','oncePayLimit','monthPayLimit','canLoginTimeRange','resetDays','regLoginTipsId','workLoginTipsId','weekendLoginTipsId','holiLoginTipsId','canNotPayTipsId'
},
	["data"] = {
{'1',	'1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'1',	'1',	'',	'1',	'成人',	'18',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'1',	'1',	'',	'2',	'未成年人',	'0',	'7',	'',	'0',	'',	'',	'0',	'0',	'20,21',	'',	'accTypeNoticePlr5',	'accTypeNoticePlr2',	'accTypeNoticePlr3',	'accTypeNoticePlr6',	'accTypeNoticePlr4'},
{'1',	'1',	'',	'3',	'未成年人',	'8',	'15',	'',	'0',	'',	'',	'5000',	'20000',	'20,21',	'',	'accTypeNoticePlr1',	'accTypeNoticePlr2',	'accTypeNoticePlr3',	'accTypeNoticePlr6',	''},
{'1',	'1',	'',	'4',	'未成年人',	'16',	'17',	'',	'0',	'',	'',	'10000',	'40000',	'20,21',	'',	'accTypeNoticePlr7',	'accTypeNoticePlr2',	'accTypeNoticePlr3',	'accTypeNoticePlr6',	''},
{'2',	'2',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'2',	'2',	'',	'1',	'游客',	'',	'',	'',	'',	'',	'1',	'0',	'0',	'',	'15',	'accTypeNoticeGuest',	'accTypeNoticeGuest',	'',	'accTypeNoticeGuest',	'accTypeCanNotPay'},
},
}
--cfgCfgAccTypeLimit = conf
return conf
