--FireBall数据
local this = 
{
[-865403415]={
{time=20600,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60330_call"},
{effect="call",time=21100,type=0,pos_ref={ref_type=6}}
},
[-686817241]={
{time=2500,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60330_cast_01"},
{delay=1500,time=4000,type=3,hits={0}},
{effect="cast1_buff",time=2200,type=0,pos_ref={ref_type=15}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=15700,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60330_cast_02"},
{effect="cast2_eff",time=16000,type=0,pos_ref={ref_type=6}},
{time=15000,type=1,hit_type=1,hits={8100,8400,8700,14100}}
},
[-1609092943]={
{time=2200,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60330_cast_00"},
{delay=950,time=4000,type=1,hit_type=1,camera_shake={time=330,shake_dir=1,range=150,range2=40,hz=50,decay_value=0.35},hits={0}},
{effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=1}},
{delay=1300,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=350,range2=300,hz=30,decay_value=0.3},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;