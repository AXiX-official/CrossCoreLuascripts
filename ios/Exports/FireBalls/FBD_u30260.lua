--FireBall数据
local this = 
{
[1310282141]={
{delay=6850,time=4000,type=1,hit_type=1,hit_creates={-520473558},hits={0,220}},
{delay=8950,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",time=11000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Tyrant_attack_skill_02"}
},
[-520473558]={
time=4000,type=0
},
[1192467788]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Tyrant_attack_skill_01"},
{delay=770,time=3000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=220,range1=160,hz=250,decay_value=0.3},hit_creates={1192467788},hits={0}}
},
[-1609092943]={
{effect="cast0_eff",time=2500,type=0,pos_ref={ref_type=6}},
{time=2000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Tyrant_attack_general"},
{delay=930,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,range1=200,range2=200,hz=200,decay_value=0.6},hits={0}}
},
[958292235]={
{effect="cast3_eff",time=2500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Tyrant_buffskill"},
{delay=650,time=2000,type=1,hit_type=0,is_fake=1,fake_damage=1,hits={0}},
{delay=650,time=2000,type=4,hit_creates={1776661962},hits={0}}
},
[1776661962]={
effect="cast3_hit",time=2000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;