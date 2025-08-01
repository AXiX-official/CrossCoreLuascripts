local this=
{
mapid=121003,born_group=100,
groups=
{
[100]={10104,10106},
[101]={10605,10304,10306},
[104]={10705},
[105]={10502},
[102]={10805},
[103]={10706},
[107]={10704},
[109]={10501},
[110]={10509},
[111]={10502,10503,10504,10505},
[112]={10508,10507,10506,10505},
[106]={10208,10202}
},
monsters=
{
{id=605031,born_pos=10304,wave=1},
{id=605032,born_pos=10306,wave=1},
{id=605033,born_pos=10607,wave=1},
{id=605035,born_pos=10603,wave=1},
{id=605034,born_group=102,wave=1}
},
props=
{
{born_group=107,wave=2,rate=100,nPropID=1,float_content="耐久+30%",use_sound="ui_buff_attack",name="耐久补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_group=103,wave=3,rate=100,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10008}}
},
}
return this;