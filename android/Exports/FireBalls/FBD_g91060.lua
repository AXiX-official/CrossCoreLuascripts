--FireBall数据
local this = 
{
[-1609092943]={
{delay=1200,time=4000,type=1,hit_type=1,hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Thórdarson_attack_general"}
},
[1349028111]={
time=4000,type=0
},
[-686817241]={
{delay=1400,time=4000,type=1,hit_type=1,hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Thórdarson_attack_skill_01"},
{delay=1600,time=4000,type=1,hit_type=1,hit_creates={-1368377223},hits={0}}
},
[-1368377223]={
effect="cast1_hit02",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1192467788]={
effect="cast1_hit01",time=4000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{delay=7411,time=1000,type=1,hit_type=1,hits={0}},
{delay=7751,time=1000,type=1,hit_type=1,hits={0}},
{delay=8489,time=1000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",time=11500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Thórdarson_attack_skill_03"},
{effect="cast2_hit",time=11500,type=0,pos_ref={ref_type=1,offset_row=1000}}
},
[958292235]={
{delay=2200,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast3_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Thórdarson_attack_skill_04"},
{effect="cast3_hit",time=4000,type=0,pos_ref={ref_type=3,offset_row=-250,lock_col=1}}
},
[-1485114200]={
{delay=9000,time=4000,type=1,hit_type=1,hits={0,100,200}},
{effect="cast4_eff",time=11600,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Thórdarson_attack_skill_02"},
{effect="cast4_hit",delay=9810,time=1690,type=0,pos_ref={ref_type=4,part_index=1}}
},
[-316323548]={
{effect="dead_eff",effect_pack="g92280",time=10000,type=0,pos_ref={ref_type=6}}
},
[-601574123]={
{effect="cast_shield ",time=2000,type=0,pos_ref={ref_type=6}}
}
};

return this;