--FireBall数据
local this = 
{
[1079508512]={
{time=4500,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60320_change"},
{effect="change",time=4000,type=0,pos_ref={ref_type=6}}
},
[-686817241]={
{time=3500,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60320_cast_01"},
{time=4000,type=3,hits={800}},
{time=3500,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_15",cue_feature=1},
{effect="cast1_buff",delay=800,time=3000,type=0,pos_ref={ref_type=13}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=14500,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60320_cast_02"},
{time=14500,type=1,hit_type=1,hits={11000,11500,12200,13000}},
{delay=6700,time=7300,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_17",cue_feature=1},
{effect="cast2_hit",delay=12500,time=2000,type=0,pos_ref={ref_type=3,offset_row=-250}},
{delay=990,time=13510,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_16",cue_feature=1},
{effect="cast2_eff",time=14500,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{time=3300,type=0,cue_sheet="fight/effect/Eighteen.acb ",cue_name="60320_cast_00"},
{delay=1900,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=300,range2=300,hz=50,decay_value=0.6},hits={0}},
{time=3500,type=0,cue_sheet="cv/Dainslef.acb",cue_name="Dainslef_09",cue_feature=1},
{effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",delay=1000,time=3500,type=0,pos_ref={ref_type=1}}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6,offset_row=-250}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6,offset_row=-250}}
}
};

return this;