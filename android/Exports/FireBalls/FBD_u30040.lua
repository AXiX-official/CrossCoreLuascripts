--FireBall数据
local this = 
{
[930703811]={
effect="cast1_hit3",time=6000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-686817241]={
{delay=2000,time=6000,type=1,hit_type=1,camera_shake={time=200,shake_dir=1,range=250,range2=250,hz=60,decay_value=0.5},hit_creates={1192467788},hits={0}},
{effect="cast1_eff",effect_no_flip=1,time=6000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Canis.acb",cue_name="Canis_10",cue_feature=1,path_target={ref_type=5,offset_row=350,lock_row=1}},
{delay=1200,time=6000,type=1,hit_type=1,is_fake=1,hit_creates={930703811},hits={0}},
{delay=2439,time=6000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=250,range2=250,hz=60,decay_value=0.5},hit_creates={-1368377223},hits={0}}
},
[1192467788]={
effect="cast1_hit",time=6000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1368377223]={
effect="cast1_hit2",time=6000,type=0,pos_ref={ref_type=4,part_index=0}
},
[1310282141]={
{delay=5700,time=3000,type=1,hit_type=1,hits={0}},
{effect="cast2_hit",delay=5000,time=1500,type=0,pos_ref={ref_type=3}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Canis.acb",cue_name="Canis_11",cue_feature=1}
},
[-1609092943]={
{delay=1000,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=250,range2=250,hz=30,decay_value=0.5},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Canis.acb",cue_name="Canis_09",cue_feature=1,path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;