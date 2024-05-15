local conf = {
	["filename"] = 'j-剧情表.xlsx',
	["sheetname"] = '好感剧情',
	["types"] = {
'int','string','string','int','int[]','string[]','float','int','int','int[]','int','int','string','string','json','int','int','int','int[]','int[]','int[]','string','json','string','int[]','int[]','int','int[]','int','int','int','json','json','int','int','int','int','int','int','int','json','int'
},
	["names"] = {
'id','key','content','isLastContent','animList','imgContent','imgDelay','imgChangeType','isHideBox','talkRoleID','showIcon','isLeader','talk','talk_en','roleInfos','header_left','header_center','header_right','emoji_left','emoji_center','emoji_right','soundFile','effSoundInfos','bgm','options','nextId','nextType','mask','effectID','grayEffect','useGradient','shakeInfos','cameraInfo','starBlur','endBlur','blurTime','clearRoles','forceAutoTime','isCenter','blink','video','record_id'
},
	["data"] = {
{'3000001',	'',	'冈底斯，如果我没猜错，现在是上班时间吧？',	'',	'',	'Bg_9010.jpg',	'0.5',	'1',	'',	'100000',	'1',	'',	'%s',	'',	'[{"id":1018001,"pos":2,"enter":2,"delay":0.5}]',	'',	'',	'',	'',	'',	'',	'',	'',	'Plot_Mysterious',	'',	'3000002',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'1',	'',	''},
{'3000002',	'',	'是总队长啊，请问有什么事吗？',	'',	'',	'',	'',	'',	'',	'1018001',	'1',	'',	'冈底斯',	'KAILAS',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'3000003',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''},
},
}
--cfgTalkInfo2 = conf
return conf
