--FireBall数据
local this = 
{
[1120628288]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={8000,8160,8320,8480,8740,8900,9200,9500}},
{effect="cast2_eff",time=11000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="60301_cast_02"}
},
[2124325257]={
time=2000,type=0
},
[-686817241]={
{delay=2450,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=450,range2=450,hz=30,decay_value=0.35},hit_creates={-646510353},hits={0}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6,offset_row=100},cue_sheet="fight/effect/seventeen.acb",cue_name="60301_cast_01"},
{effect="cast1_hit",time=3300,type=0,pos_ref={ref_type=10,offset_row=100}}
},
[-646510353]={
time=2000,type=0
},
[-1609092943]={
{delay=1400,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=250,range2=100,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=2300,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="60301_cast_00"}
},
[1349028111]={
time=2000,type=0
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
},
[-316323548]={
{time=2800,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_52",cue_feature=1},
{delay=1400,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=50,range2=300,hz=40,decay_value=0.6},hits={0}}
}
};

return this;