--FireBall数据
local this = 
{
[-865403415]={
{effect="summon_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Noctilucent.acb",cue_name="Noctilucent_40",cue_feature=1},
{delay=300,time=10000,type=0,cue_sheet="fight/effect/eleventh.acb",cue_name="Noctilucent_summon"}
},
[1310282141]={
{delay=672,time=14000,type=0,cue_sheet="cv/Noctilucent.acb",cue_name="Noctilucent_11",cue_feature=1},
{effect="cast2_hit",delay=11000,time=3000,type=0,pos_ref={ref_type=1}},
{delay=5828,time=14000,type=0,cue_sheet="cv/Noctilucent.acb",cue_name="Noctilucent_12",cue_feature=1},
{delay=12000,time=5000,type=1,hit_type=0,hits={0,300,600,900}},
{delay=8825,time=14000,type=0,cue_sheet="cv/Noctilucent.acb",cue_name="Noctilucent_12_b",cue_feature=1},
{effect="cast2_eff",time=14000,type=0,pos_ref={ref_type=1,offset_row=-250},cue_sheet="fight/effect/eleventh.acb",cue_name="Noctilucent_attack_skill_02"}
},
[-686817241]={
{delay=1350,time=1000,type=3,hits={0,10}},
{time=3000,type=0,cue_sheet="cv/Noctilucent.acb",cue_name="Noctilucent_10",cue_feature=1},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Noctilucent_attack_skill_01"}
},
[-1609092943]={
{delay=1850,time=2000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=500,range1=150,range2=25,hz=30,decay_value=0.3},hit_creates={-1190450118},hits={0}},
{effect="cast0_eff",time=2500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/eleventh.acb",cue_name="Noctilucent_attack_general",path_target={ref_type=1}},
{time=2500,type=0,cue_sheet="cv/Noctilucent.acb",cue_name="Noctilucent_09",cue_feature=1},
{delay=1600,time=2000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=220,range1=100,range2=25,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}}
},
[661633433]={
effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}
},
[-1190450118]={
effect="cast0_hit2",time=2000,type=0,pos_ref={ref_type=1}
},
[-1328923786]={
{effect="win_eff",time=4000,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{delay=800,time=4000,type=0,cue_sheet="fight/effect/eleventh.acb",cue_name="Noctilucent_enter"},
{effect="enter_eff",time=4000,type=0,pos_ref={ref_type=6}}
}
};

return this;