local this=
{
mapid=12905,born_group=100,
groups=
{
[100]={10102,10104},
[101]={10302},
[102]={10603},
[103]={10304},
[104]={10402},
[105]={10404},
[106]={10403}
},
monsters=
{
{id=604053,born_pos=10603,wave=1},
{id=604051,born_pos=10302,wave=1},
{id=604051,born_pos=10304,wave=1},
{id=604052,born_pos=10501,wave=1},
{id=604052,born_pos=10505,wave=1}
},
props=
{
{born_pos=10401,wave=1,rate=100,nPropID=1,float_content="NP+50",use_sound="ui_buff_attack",name="NP补给",icon="MapProps_003",desc="基地投送的作战补给，获得后队伍NP+50。",res="GridProps/buff/Buff_NP",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=34,param={0.1},nNp=50},
{born_pos=10405,wave=1,rate=100,nPropID=2,float_content="HP+50%",use_sound="ui_buff_attack",name="耐久补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体耐久+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}}
},
}
return this;