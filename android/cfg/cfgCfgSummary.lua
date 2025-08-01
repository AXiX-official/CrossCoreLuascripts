local conf = {
	["filename"] = 'h_汇总界面表.xlsx',
	["sheetname"] = '汇总内容表',
	["types"] = {
'int','string','int','table#11','int','string','string','int','string','string','int','string','int','int','int'
},
	["names"] = {
'id','key','type','infos','index','name','desc','jumpId','sTime','eTime','iconType','icon','activity','commodity','isHideEnd'
},
	["data"] = {
{'2',	'2',	'2',	'',	'',	'周年狂欢',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'2',	'2',	'',	'',	'1',	'庆典签到',	'',	'180014',	'2025/7/30 12:00:00',	'2025/8/20 03:00:00',	'1',	'icon_01_01',	'',	'',	''},
{'2',	'2',	'',	'',	'2',	'每日免费单抽',	'',	'61046',	'2025/7/30 12:00:00',	'2025/8/6 03:00:00',	'1',	'icon_01_02',	'',	'',	''},
{'2',	'2',	'',	'',	'3',	'协同作战',	'',	'310001',	'2025/7/30 12:00:00',	'2025/9/1 03:00:00',	'1',	'icon_01_03',	'',	'',	''},
{'2',	'2',	'',	'',	'4',	'庆典活动',	'',	'350002',	'2025/8/6 12:00:00',	'2025/9/3 03:00:00',	'1',	'icon_01_04',	'',	'',	''},
{'2',	'2',	'',	'',	'5',	'赤溟专属',	'',	'350003',	'2025/8/6 12:00:00',	'2025/9/3 03:00:00',	'1',	'icon_01_05',	'',	'',	''},
{'2',	'2',	'',	'',	'6',	'惠享返礼',	'',	'350004',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'1',	'icon_01_06',	'',	'',	''},
{'2',	'2',	'',	'',	'7',	'庆典时装',	'',	'140008',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'1',	'icon_01_07',	'',	'',	''},
{'2',	'2',	'',	'',	'8',	'庆典画册',	'',	'140019',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'1',	'icon_01_08',	'',	'',	''},
{'2',	'2',	'',	'',	'9',	'奇趣扭蛋',	'',	'340001',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'1',	'icon_01_10',	'',	'',	''},
{'3',	'3',	'2',	'',	'',	'庆典福利',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'3',	'3',	'',	'',	'1',	'庆典签到',	'',	'180014',	'2025/7/30 12:00:00',	'2025/8/20 03:00:00',	'2',	'icon_02_01',	'',	'',	''},
{'3',	'3',	'',	'',	'2',	'每日免费单抽',	'',	'61046',	'2025/7/30 12:00:00',	'2025/8/6 03:00:00',	'2',	'icon_02_02',	'',	'',	''},
{'3',	'3',	'',	'',	'3',	'协同作战',	'',	'310001',	'2025/7/30 12:00:00',	'2025/9/1 03:00:00',	'2',	'icon_02_03',	'',	'',	''},
{'4',	'4',	'2',	'',	'',	'庆典活动',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'4',	'4',	'',	'',	'1',	'主线·第五章',	'渊默变奏',	'30002',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'2',	'icon_03_01',	'',	'',	''},
{'4',	'4',	'',	'',	'2',	'周年狂欢',	'',	'370001',	'2025/8/6 12:00:00',	'2025/8/15 03:00:00',	'2',	'icon_03_02',	'',	'',	''},
{'4',	'4',	'',	'',	'3',	'周年狂欢',	'',	'13161',	'2025/8/20 12:00:00',	'2025/9/3 03:00:00',	'2',	'icon_03_03',	'',	'',	''},
{'4',	'4',	'',	'',	'4',	'周年狂欢',	'',	'13039',	'2025/8/13 12:00:00',	'2025/9/3 03:00:00',	'2',	'icon_03_04',	'',	'',	''},
{'5',	'5',	'2',	'',	'',	'庆典画册',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'5',	'5',	'',	'',	'1',	'庆典画册',	'',	'140019',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'2',	'icon_01_02',	'',	'',	''},
{'6',	'6',	'2',	'',	'',	'庆典时装',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'6',	'6',	'',	'',	'1',	'庆典时装',	'您的错过与新的渴望，这次一并奉上！',	'140008',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'2',	'icon_01_01',	'',	'',	''},
{'7',	'7',	'2',	'',	'',	'赤溟专属',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'7',	'7',	'',	'',	'1',	'翻转课堂',	'',	'140008',	'2025/8/6 12:00:00',	'2025/9/3 03:00:00',	'2',	'icon_02_01',	'',	'30035',	''},
{'7',	'7',	'',	'',	'2',	'海研丽影',	'',	'61022',	'2025/8/6 12:00:00',	'2025/9/3 03:00:00',	'2',	'icon_02_02',	'',	'',	''},
{'7',	'7',	'',	'',	'3',	'赤溟有礼',	'',	'180015',	'2024/8/6 12:00:00',	'2025/8/12 03:00:00',	'2',	'icon_02_03',	'',	'',	''},
{'8',	'8',	'2',	'',	'',	'奇趣扭蛋',	'',	'',	'',	'',	'',	'',	'',	'',	''},
{'8',	'8',	'',	'',	'1',	'奇趣扭蛋',	'',	'340001',	'2025/7/30 12:00:00',	'2025/9/3 03:00:00',	'1',	'icon_01_01',	'',	'',	''},
},
}
--cfgCfgSummary = conf
return conf
