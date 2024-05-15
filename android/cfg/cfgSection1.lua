local conf = {
	["filename"] = 'z-章节表.xlsx',
	["sheetname"] = '主线',
	["types"] = {
'int','int','string','int','string','int','int','int[]','json','int','int','int','int','int','int[]','int','int','int','string','string','string','string','json','int[]','string','string','string','string','float','int','int','int','string[]','string[]','string[]','string','string','int'
},
	["names"] = {
'id','key','chapter','type','name','pos','open_tips','conditions','info','index','group','fade','activeId','turnNum','openTime','dailyEnumID','count','cd','lock_desc','desc','icon','descImg','fallRewards','starRewardID','mName','eName','sBg','bg','bgPosZ','multiId','sOpen','preSection','passDesc','nextOpenDesc','diffPassDesc','descKey','bgm','story'
},
	["data"] = {
{'1',	'',	'序章',	'',	'碎星前哨',	'',	'',	'',	'',	'1',	'1',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'chapter_00',	'Main_00',	'',	'101,201',	'漂流板块-前哨',	'Avanpost',	'bg1',	'dBg1',	'15.2',	'',	'',	'',	'漂流板块 收束解放,序章【碎星前哨】任务完成',	'戈里刻板块 投送就绪,第一章【意识桎梏】任务开启',	'<color=#ff7781>漂流板块 收束解放</color>,序章【碎星前哨】困难任务完成',	'',	'Env_Prologue',	''},
{'2',	'',	'第一章',	'',	'意识桎梏',	'',	'',	'',	'',	'2',	'1',	'',	'',	'',	'',	'',	'',	'',	'完成<color=#FFC142>序章</color>后开启',	'',	'chapter_01',	'Main_01',	'',	'102,202',	'雪域绝壁-戈里刻',	'Psychic Shackles',	'bg2',	'dBg2',	'16.9',	'',	'',	'1',	'戈里刻版块 收束解放,第一章【意识桎梏】任务完成',	'诺斯板块 投送就绪,第二章【终焉奇点】任务开启',	'<color=#ff7781>戈里刻版块 收束解放</color>,第一章【意识桎梏】困难任务完成',	'',	'Env_Chapter1',	''},
{'3',	'',	'第二章',	'',	'终焉奇点',	'',	'',	'',	'',	'3',	'1',	'',	'',	'',	'',	'',	'',	'',	'完成<color=#FFC142>第一章</color>开启',	'',	'chapter_02',	'Main_02',	'',	'103,203',	'密林岩谷-诺斯',	'Missing',	'bg3',	'dBg3',	'15.2',	'',	'',	'2',	'诺斯版块 收束解放,第二章【终焉奇点】任务完成',	'',	'<color=#ff7781>诺斯版块 收束解放</color>,第二章【终焉奇点】困难任务完成',	'',	'Env_Chapter2',	''},
},
}
--cfgSection1 = conf
return conf
