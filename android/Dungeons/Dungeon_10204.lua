local this=
{
mapid=10204,born_group=101,
groups=
{
[101]={10102,10104},
[100]={10602,10303},
[102]={10803},
[103]={10508},
[104]={10503,10605},
[105]={10601}
},
monsters=
{
{id=403041,born_pos=10303,wave=1},
{id=403042,born_pos=10602,wave=1},
{id=403042,born_pos=10801,wave=1},
{id=403043,born_pos=10506,wave=1},
{id=403044,born_group=102,wave=1}
},
props=
{
{born_group=105,wave=1,rate=100,nPropID=1,float_content="HP+30%",use_sound="ui_buff_attack",name="耐久补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_group=103,wave=1,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}}
},
mists={
{round=2,view=1},
{round=10,view=0}
}
}
return this;