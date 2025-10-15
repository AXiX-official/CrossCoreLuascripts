local conf = {
	["filename"] = 'z-章节表.xlsx',
	["sheetname"] = '主线',
	["types"] = {
'int','int','string','int','string','int','int','int','int[]','json','int','int','int','bool','int','int','int[]','int','int','int','string','string','string','string','string','json','int[]','string','string','string','int','string[]','float','json','int','int','int','int','string[]','string[]','string[]','string','string','int'
},
	["names"] = {
'id','key','chapter','type','name','pos','onlyOne','open_tips','conditions','info','index','group','fade','isShowPassTeam','activeId','turnNum','openTime','dailyEnumID','count','cd','lock_desc','hardLock_desc','desc','icon','descImg','fallRewards','starRewardID','mName','eName','sBg','bgType','bg','bgPosZ','bgInfo','multiId','multiId','sOpen','preSection','passDesc','nextOpenDesc','diffPassDesc','descKey','bgm','story'
},
	["data"] = {
{'1',	'',	'序章',	'',	'碎星前哨',	'',	'',	'',	'',	'[{"bgm":"Env_Prologue"}]',	'1',	'1',	'',	'1',	'',	'',	'',	'',	'',	'',	'',	'完成序章后开启',	'',	'chapter_00',	'Main_00',	'',	'101,201',	'漂流板块-前哨',	'Avanpost',	'bg1',	'1',	'dBg1',	'15.2',	'',	'',	'',	'',	'',	'漂流板块 收束解放,序章【碎星前哨】任务完成',	'戈里刻板块 投送就绪,第一章【意识桎梏】任务开启',	'<color=#ff7781>漂流板块 收束解放</color>,序章【碎星前哨】困难任务完成',	'',	'',	''},
{'2',	'',	'第一章',	'',	'意识桎梏',	'',	'',	'',	'',	'[{"bgm":"Env_Chapter1","shopId": 5001}]',	'2',	'1',	'',	'1',	'',	'',	'',	'',	'',	'',	'完成<color=#FFC142>序章</color>后开启',	'完成<color=#FFC142>序章困难</color>和<color=#FFC142>第一章</color>后开启',	'',	'chapter_01',	'Main_01',	'',	'102,202',	'雪域绝壁-戈里刻',	'Psychic Shackles',	'bg2',	'1',	'dBg2',	'16.9',	'',	'',	'',	'',	'1',	'戈里刻版块 收束解放,第一章【意识桎梏】任务完成',	'诺斯板块 投送就绪,第二章【终焉奇点】任务开启',	'<color=#ff7781>戈里刻版块 收束解放</color>,第一章【意识桎梏】困难任务完成',	'',	'',	''},
{'3',	'',	'第二章',	'',	'终焉奇点',	'',	'',	'',	'',	'[{"bgm":"Env_Chapter2","shopId": 5001}]',	'3',	'1',	'',	'1',	'',	'',	'',	'',	'',	'',	'完成<color=#FFC142>第一章</color>后开启',	'完成<color=#FFC142>第一章困难</color>和<color=#FFC142>第二章</color>后开启',	'',	'chapter_02',	'Main_02',	'',	'103,203',	'密林岩谷-诺斯',	'Missing',	'bg3',	'1',	'dBg3',	'15.2',	'',	'',	'',	'',	'2',	'诺斯版块 收束解放,第二章【终焉奇点】任务完成',	'',	'<color=#ff7781>诺斯版块 收束解放</color>,第二章【终焉奇点】困难任务完成',	'',	'',	''},
{'4',	'',	'第三章',	'',	'重生之梦',	'',	'',	'',	'3214',	'[{"bgm":"Env_Chapter3","shopId": 5001}]',	'4',	'1',	'',	'1',	'',	'',	'',	'',	'',	'',	'完成<color=#FFC142>第二章2-14 坍缩态(困难)</color>',	'完成<color=#FFC142>第二章困难</color>和<color=#FFC142>第三章</color>后开启',	'',	'chapter_02',	'Main_02',	'',	'104,204',	'地下城市-尼克罗',	'Missing',	'bg4',	'1',	'dBg4',	'17.3',	'',	'',	'',	'',	'3',	'尼克罗版块 收束解放,第三章【重生之梦】任务完成',	'天阶原板块 投送就绪,第三章【妄念绘景】任务开启',	'<color=#ff7781>尼克罗版块 收束解放</color>,第三章【重生之梦】困难任务完成',	'',	'',	''},
{'5',	'',	'第四章',	'',	'妄念绘景',	'',	'',	'',	'',	'[{"bgm":"Env_Chapter4","shopId": 5001}]',	'5',	'1',	'',	'1',	'',	'',	'',	'',	'',	'',	'完成<color=#FFC142>第三章</color>后开启',	'完成<color=#FFC142>第三章困难</color>和<color=#FFC142>第四章</color>后开启',	'',	'chapter_02',	'Main_02',	'',	'105,205',	'幽美之地-天阶原',	'Missing',	'bg5',	'1',	'dBg5',	'28',	'',	'',	'',	'1',	'4',	'天阶原版块 收束解放,第四章【妄念绘景】任务完成',	'',	'<color=#ff7781>天阶原版块 收束解放</color>,第四章【妄念绘景】困难任务完成',	'',	'',	''},
{'6',	'',	'第五章',	'',	'渊默变奏',	'',	'',	'',	'',	'[{"bgm":"Env_Chapter5","shopId": 5001}]',	'6',	'1',	'',	'1',	'',	'',	'',	'',	'',	'',	'完成<color=#FFC142>第四章困难</color>后开启',	'完成<color=#FFC142>第四章困难</color>和<color=#FFC142>第五章</color>后开启',	'',	'chapter_02',	'Main_02',	'',	'106,206',	'地球总部-帕科萨',	'Missing',	'bg6',	'2',	'dBg6,dBg7,dBg8,dBg2,dBg1',	'17',	'{"width":5760,"point1":"1000","point2":"3100"}',	'',	'',	'1',	'5',	'地球总部  空间门关闭,第五章【渊默变奏】任务完成',	'',	'<color=#ff7781>地球总部  空间门关闭</color>,第五章【渊默变奏】困难任务完成',	'',	'',	''},
},
}
--cfgSection1 = conf
return conf
