--FireBall数据
local this = 
{
[-390021739]={
{time=6000,type=0,cue_sheet="fight/effect/thirteen.acb",cue_name="Osiris_attack_skill_05_2"}
},
[-686817241]={
{effect="cast1_eff",time=10000,type=0,pos_ref={ref_type=6}},
{delay=1200,time=10000,type=1,hit_type=1,camera_shake={time=100,shake_dir=1,range=200,range2=200,hz=80,decay_value=0.6},hits={0,400,600,800}},
{effect="cast1_hit",time=10000,type=0,pos_ref={ref_type=3,offset_row=-250}}
},
[1310282141]={
{effect="cast2_eff",time=10000,type=0,pos_ref={ref_type=6}}
},
[958292235]={
{effect="cast3_hit",time=10000,type=0,pos_ref={ref_type=3,offset_row=-250,lock_col=1}},
{effect="cast3_eff",time=10000,type=0,pos_ref={ref_type=6}},
{time=10000,type=1,hit_type=0,camera_shake={time=50,shake_dir=1,range=200,range2=200,hz=80,decay_value=0.6},hits={1080,1140,1200,1500,1600,1700}}
},
[-1485114200]={
{effect="cast4_hit",time=13000,type=0,pos_ref={ref_type=0,offset_row=-100}},
{effect="cast4_eff",time=14000,type=0,pos_ref={ref_type=6}},
{delay=11000,time=10000,type=1,hit_type=0,hits={0,200,400}}
},
[-1609092943]={
{time=10000,type=1,hit_type=1,camera_shake={time=360,shake_dir=1,range=150,range2=150,hz=60,decay_value=0.6},hits={1000,1100}},
{effect="cast0_eff",time=10000,type=0,pos_ref={ref_type=6}},
{time=10000,type=1,hit_type=1,camera_shake={time=360,shake_dir=1,range=150,range2=150,hz=80,decay_value=0.6},hits={100,400}},
{effect="cast0_hit",time=10000,type=0,pos_ref={ref_type=0,offset_row=-200}}
}
};

return this;