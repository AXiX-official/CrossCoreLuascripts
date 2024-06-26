--FireBall数据
local this = 
{
[958292235]={
{effect="qc_buff_eff",effect_pack="common_hit",time=3500,type=0,pos_ref={ref_type=6}},
{delay=800,time=1500,type=3,hits={0}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{delay=6500,time=11000,type=1,hit_type=1,hit_creates={2124325257},hits={0,880,980,2300}},
{effect="cast2_eff",time=11000,type=0,pos_ref={ref_type=6}}
},
[2124325257]={
time=11000,type=0
},
[-686817241]={
{delay=1700,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=20,decay_value=0.6},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6}}
},
[1192467788]={
time=4000,type=0
},
[-1609092943]={
{delay=600,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=20,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=4500,type=0,pos_ref={ref_type=6}}
},
[1349028111]={
time=2000,type=0
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;