--本地保存数据索引  有新值需要在SettingMgr的InitLocalCfg后赋初始值保存
--获取游戏音频大小
s_isSetting = "s_isSetting" --是否已设置过

s_audio_scale = {
	music = "music",       --音乐
	sound = "sound",       --音效
	dubbing = "dubbing",     --配音
}

s_audio_value = {music = 100, sound = 100, dubbing = 100} --默认大小

--质量key  数值：123=低中高
s_quality_key = "s_quality_key_imgquality"        --画质   
s_quality_value = 2 --默认等级  

--屏幕适应 0-100 
s_screen_scale_key = "s_screen_scale_key"
s_screen_scale_default = 100  --Iphonex 默认为0

--帧数开关 1:60帧  2:30帧
s_toggle_zs_key = "s_toggle_zs_key"
s_toggle_zs_default = 2

--描边开关 1：开  2：关
s_toggle_mb_key = "s_toggle_mb_key"
s_toggle_mb_default = 2

--锯齿 1：开  2：关
s_toggle_jc_key = "s_toggle_jc_key"
s_toggle_jc_default = 2 

s_mobie_lv_key = "s_mobie_lv_key"       
s_mobie_score_key = "s_mobie_score_key"        --画质  
s_mobie_middle = 115  --中机型最低分
s_mobie_height = 150 --高机型最低分

s_music_cache_key = "14016"

--战斗动画开关 1:一日一次 2:开 3:关
s_fight_action_key = "s_fight_action_key"
s_fight_action_default = 2

--战斗技能简要描述 1：开  2：关
s_fight_simple_key = "s_fight_simple_key"
s_fight_simple_default = 2

s_language_key = "s_language_key"
s_language_key_default = 0  --日：0  中：1 

--直播 1：开  2：关
s_other_live_key = "s_other_live_key"
s_other_live_default = 2

--芯片自动上锁 1：开  2：关
s_other_equipLock_key = "s_other_equipLock_key"
s_other_equipLock_default = 1