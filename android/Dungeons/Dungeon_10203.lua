local this=
{
mapid=10203,born_group=100,
groups=
{
[100]={10101,10301},
[101]={10206},
[102]={10211,10706},
[103]={10104,10108,10305,10408},
[104]={10307},
[105]={10104,10108,10204,10208,10304,10308,10405,10406,10407},
[106]={10103,10109,10203,10209,10303,10309,10505,10506,10507}
},
monsters=
{
{id=403031,born_pos=10104,wave=1},
{id=403032,born_pos=10408,wave=1},
{id=403032,born_pos=10305,wave=2},
{id=403033,born_pos=10108,wave=2},
{id=403034,born_group=102,wave=2}
},
props=
{
{born_group=101,wave=1,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=104,wave=2,rate=100,nPropID=2,float_content="耐久+30% ",float_content_id=72020,name="生命补给",name_id=70020,icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",desc_id=71020,res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10101,wave=1,rate=100,nPropID=3,icon="图标名称",desc="第三章虚影落石",nStep=1,state=4,type=38,param={0.1},attackType=1,damage=0.2,ranges={105,106}}
},
}
return this;