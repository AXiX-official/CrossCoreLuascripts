local this=
{
mapid=10201,born_group=101,
groups=
{
[101]={10102,10104},
[100]={10503,10701},
[102]={10903},
[103]={10601},
[104]={10803,10604},
[105]={10705}
},
monsters=
{
{id=403011,born_group=100,wave=1},
{id=403011,born_group=100,wave=1},
{id=403012,born_pos=10802,wave=1},
{id=403013,born_pos=10904,wave=2},
{id=403014,born_group=102,wave=2}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=105,wave=1,rate=100,nPropID=2,float_content="HP+30%",use_sound="ui_buff_attack",name="耐久补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}}
},
}
return this;