--FireBall数据
local this = 
{
[-601574123]={
{time=2000,type=0}
},
[-686817241]={
{effect="cast1_hit",time=6000,type=0,pos_ref={ref_type=1,offset_row=-250,lock_row=1}},
{effect="cast1_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Ymir_attack_skill_02"},
{time=7000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=200,range1=100,range2=100,hz=30,decay_value=0.3},hits={1650}}
},
[1310282141]={
{delay=2650,time=7000,type=1,hit_type=1,is_fake=1,fake_damage=1,hits={0}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Ymir_attack_skill_03"},
{delay=2450,time=7000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=200,range1=100,range2=200,hz=30,decay_value=0.6},hits={0}}
},
[958292235]={
{effect="cast3_eff1",time=10848,type=0,pos_ref={ref_type=1,offset_row=-1150},cue_sheet="fight/effect/twelfth.acb",cue_name="Ymir_attack_skill_04"},
{effect="cast3_eff2",time=10848,type=0,pos_ref={ref_type=1}},
{delay=10200,time=4000,type=1,hit_type=1,hits={0}},
{delay=8300,time=4000,type=1,hit_type=1,hits={0}},
{delay=9000,time=4000,type=1,hit_type=1,hits={0}}
},
[-1485114200]={
{delay=11000,time=12000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=200,hz=200,decay_value=0.25},hits={0}},
{effect="cast4_eff",time=12000,type=0,pos_ref={ref_type=10,offset_row=1000},cue_sheet="fight/effect/twelfth.acb",cue_name="Ymir_attack_skill_05"},
{effect="cast4_hit",time=12000,type=0,pos_ref={ref_type=10,offset_row=550}}
},
[-1609092943]={
{effect="cast0_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/twelfth.acb",cue_name="Ymir_attack_skill_01"},
{effect="cast0_hit",delay=1000,time=2000,type=0,pos_ref={ref_type=0,lock_col=1}},
{delay=900,time=1200,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=500,range1=200,range2=200,hz=30,decay_value=0.3},hits={0}}
},
[-316323548]={
{effect="dead_eff",time=6000,type=0,pos_ref={ref_type=6,offset_row=50},cue_sheet="fight/effect/nineth.acb",cue_name="Drasoul_Die"}
},
[-1328923786]={
{effect="win_eff",time=4000,type=0,pos_ref={ref_type=6}}
}
};

return this;