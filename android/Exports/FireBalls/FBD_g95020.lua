--FireBall数据
local this = 
{
[-686817241]={
{time=2100,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95020_cast_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}},
{time=3500,type=3,hits={1442}}
},
[1310282141]={
{delay=1000,time=4000,type=1,hit_type=1,camera_shake={time=150,shake_dir=1,range=150,range2=150,hz=30,decay_value=0.6},hits={0,300,600,900}},
{time=3000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95020_cast_03"},
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6}}
},
[958292235]={
{effect="cast3_hit",time=11000,type=0,pos_ref={ref_type=10,offset_row=250}},
{time=10800,type=1,hit_type=1,hits={3500,7700,8000,8300,9000,10364}},
{time=10800,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95020_cast_04"},
{effect="cast3_eff",time=11000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{delay=1000,time=4000,type=1,hit_type=1,camera_shake={time=150,shake_dir=1,range=300,range2=300,hz=10,decay_value=0.6},hit_creates={1349028111},hits={0,300}},
{time=3200,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="95020_cast_00"},
{effect="cast0_eff",time=3200,type=0,pos_ref={ref_type=6}}
},
[1349028111]={
time=4000,type=0
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;