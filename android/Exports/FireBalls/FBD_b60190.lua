--FireBall数据
local this = 
{
[958292235]={
{delay=3750,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="grenade_exploImpac_1",hit_type=1,hits={0}},
{delay=6400,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="grenade_exploImpac_2",hit_type=1,hits={0}},
{delay=3800,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="grenade_exploImpac_2",hit_type=1,hits={0}},
{effect="cast2_eff2",time=4400,type=0,pos_ref={ref_type=10}},
{delay=500,time=7000,type=0,cue_sheet="cv/Fragarach.acb",cue_name="Fragarach_12",cue_feature=1},
{effect="cast2_hit",delay=4500,time=3300,type=0,pos_ref={ref_type=3}},
{time=7000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="fragarach_attack_skill_02"},
{delay=6150,time=7000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_01",hit_type=1,hit_creates={-1993319212},hits={0}}
},
[-1993319212]={
effect="cast2_hit2",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{time=5000,type=0,cue_sheet="cv/Fragarach.acb",cue_name="Fragarach_11",cue_feature=1},
{effect="qc_xuli_red",effect_pack="common_hit",delay=500,time=5000,type=0,pos_ref={ref_type=6,offset_row=-15,offset_height=-55}},
{time=5000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="fragarach_attack_skill_02_pre"}
},
[-686817241]={
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thrid.acb",cue_name="fragarach_attack_skill_01"},
{time=4000,type=3,hit_creates={1192467788},hits={800}},
{time=4000,type=0,cue_sheet="cv/Fragarach.acb",cue_name="Fragarach_10",cue_feature=1}
},
[1192467788]={
effect="cast1_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1609092943]={
{delay=500,time=2000,type=0,cue_sheet="cv/Fragarach.acb",cue_name="Fragarach_09",cue_feature=1},
{delay=1000,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=300,shake_dir=1,range=500,range2=500,hz=30,decay_value=0.3},hit_creates={1459965206},hits={0}},
{time=2000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="fragarach_attack_general"},
{delay=900,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=80,shake_dir=1,range=500,range2=500,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6}},
{delay=800,time=2000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05",hit_type=0,camera_shake={time=80,shake_dir=1,range=500,range2=500,hz=30,decay_value=0.3},hits={0}}
},
[1459965206]={
effect="qc_common_medium_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;