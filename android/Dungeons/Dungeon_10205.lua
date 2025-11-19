local this=
{
mapid=10205,born_group=100,
groups=
{
[100]={10102,10201},
[101]={10404},
[102]={10703},
[103]={10401,10503,10506}
},
monsters=
{
{id=403051,born_group=103,wave=1},
{id=403052,born_group=103,wave=1},
{id=403052,born_group=103,wave=1},
{id=403053,born_pos=10805,wave=2},
{id=403054,born_group=102,wave=2}
},
props=
{
{born_group=101,wave=2,rate=100,nPropID=1,name="货箱",name_id=70010,icon="MapProps_001",desc="装着各种随机素材的箱子。",desc_id=71010,res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}}
},
mists={
{round=2,view=1},
{round=10,view=0}
}
}
return this;