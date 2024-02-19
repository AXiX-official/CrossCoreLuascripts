local conf = {
	["filename"] = 'd-登录初始化.xlsx',
	["sheetname"] = '表',
	["types"] = {
'int','string','string','string[]','string[]','string[]','string[]','string[]'
},
	["names"] = {
'id','key','first_scene_key','base_abs','auto_load_abs','persistent_abs','auto_create_res','auto_open_views'
},
	["data"] = {
{'1',	'',	'Login',	'AssetBundles,shader_base,shader,common_tex,prefabs,prefabs_uis,prefabs_actions,prefabs_mvs,font_1,prefabs_uis_click',	'prefabs_uis_common,prefabs_uis_guide,prefabs_uis_top2,prefabs_uis_plot,prefabs_uis_goods,prefabs_uis_grid,prefabs_uis_team,prefabs_uis_formation,prefabs_uis_rolecard,prefabs_effects_camera_effs,prefabs_effects_overload,prefabs_effects_common,prefabs_effects_common_hit,prefabs_maptransfers,prefabs_mvs,textures_uis_icons_goods,prefabs_uis_role,prefabs_uis_fightloading,prefabs_uis_popup,prefabs_uis_rolelittlecard,prefabs_uis_skill,prefabs_effects_plot',	'prefabs_uis_loading,prefabs_uis_tips,prefabs_uis_fight,prefabs_uis_battle,prefabs_uis_menu,prefabs_scenes_skillscene,textures_uis_icons_cardfight,textures_uis_icons_skill,textures_uis_icons_roleskillgrid,textures_uis_icons_buff',	'GameRoot,LuaEvent,LuaListeners',	'TipsParent,NetWait'},
},
}
--cfglauncher = conf
return conf
