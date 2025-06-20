--FireBall数据
local this = 
{
[-390021739]={
{time=6000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Osiris_attack_skill_05_2"},
{time=6000,type=0,cue_sheet="cv/Osiris.acb",cue_name="Osiris_06",cue_feature=1}
},
[-686817241]={
{time=5000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hit_creates={1192467788},hits={1254,1634}},
{effect="cast1_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Soulless_attack_skill_01"}
},
[1192467788]={
time=5000,type=0
},
[1310282141]={
{effect="cast2_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Soulless_attack_skill_02"}
},
[958292235]={
{time=5000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=200,range2=200,hz=10,decay_value=0.6},hit_creates={1776661962},hits={2300}},
{effect="cast3_eff",time=6000,path_index=300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Soulless_attack_skill_03",path_target={ref_type=1}}
},
[1776661962]={
time=5000,type=0
},
[-1485114200]={
{time=13000,type=1,hit_type=1,hits={10500,10800,11000,12500}},
{time=13000,type=1,hit_type=0,hit_creates={226809859},hits={3500,3800,4000,4200}},
{effect="cast4_eff",time=20000,type=0,pos_ref={ref_type=10,offset_row=150},cue_sheet="fight/effect/seventeen.acb",cue_name="Soulless_attack_skill_04"}
},
[226809859]={
time=5000,type=0
},
[-1609092943]={
{time=5000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=200,range2=200,hz=50,decay_value=0.6},hit_creates={1349028111},hits={1145}},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Soulless_attack_general",path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-316323548]={
{effect="deadLarge_common_eff",effect_pack="common",delay=2000,time=6000,type=0,pos_ref={ref_type=6}},
{time=6000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Censor_Die"}
},
[-1183793042]={
{effect="enter",time=5000,type=0,pos_ref={ref_type=6}}
}
};

return this;