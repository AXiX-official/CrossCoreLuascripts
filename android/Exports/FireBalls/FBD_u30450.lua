--FireBall数据
local this = 
{
[1310282141]={
{time=11000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="30450_cast_02"},
{time=11000,type=1,hit_type=1,hits={4800,5200,5500,5900,6200,9970}},
{effect="cast2_eff",time=11500,type=0,pos_ref={ref_type=6}}
},
[-686817241]={
{time=3271,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="30450_cast_01"},
{delay=1700,time=3500,type=3,hits={0}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}},
{effect="cast1_buff",time=3500,type=0,pos_ref={ref_type=15}}
},
[-1609092943]={
{time=2000,type=0,cue_sheet="fight/effect/Eighteen.acb",cue_name="30450_cast_00"},
{time=3500,type=1,hit_type=0,camera_shake={time=150,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hit_creates={-1190450118},hits={1050}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{time=3500,type=1,hit_type=0,camera_shake={time=150,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hit_creates={1349028111},hits={850}}
},
[1349028111]={
effect="cast0_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1190450118]={
effect="cast0_hit",time=3500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;