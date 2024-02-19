local conf = {
	["filename"] = 's-声音.xlsx',
	["sheetname"] = '多人插图音效',
	["types"] = {
'int','string','string','string'
},
	["names"] = {
'id','key','cue_sheet','cue_name'
},
	["data"] = {
{'10001',	'short_click',	'plot_effect/plot_effect.acb',	'short_click'},
{'10002',	'short_alert_loop',	'plot_effect/plot_effect.acb',	'short_alert_loop'},
},
}
--cfgPictureSound = conf
return conf
