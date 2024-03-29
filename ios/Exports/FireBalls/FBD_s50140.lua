--FireBall数据
local this = 
{
[-865403415]={
{effect="call_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Wasp.acb",cue_name="Wasp_39",cue_feature=1},
{time=10000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="warlock_summon"}
},
[-686817241]={
{time=3800,type=3,cue_sheet="fight/effect/thrid.acb",cue_name="Wasp_attack_skill_01",hit_creates={1192467788},hits={2000}},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6,offset_row=-50,offset_height=-100},cue_sheet="cv/Wasp.acb",cue_name="Wasp_05",cue_feature=1}
},
[1192467788]={
effect="cast1_hit",delay=500,time=3000,type=0,pos_ref={ref_type=4,part_index=0}
},
[1310282141]={
{effect="cast2_eff",time=3200,type=0,pos_ref={ref_type=6,offset_height=80},cue_sheet="cv/Wasp.acb",cue_name="Wasp_11",cue_feature=1},
{effect="cast2_eff2",time=5000,type=0,pos_ref={ref_type=1}},
{effect="cast2_hit",delay=3175,time=4000,type=0,pos_ref={ref_type=1}},
{delay=3175,time=10000,type=1,hit_type=0,camera_shake={time=150,shake_dir=1,range=200,range1=200,range2=200,hz=30,decay_value=0.4},hits={0,220,450}},
{delay=4500,time=6000,type=1,cue_sheet="fight/effect/explosion_.acb",cue_name="Explode_Texture_02",hit_type=1,camera_shake={time=1200,shake_dir=1,range=500,range1=200,range2=500,hz=30,decay_value=0.3,vibrate=1},hit_creates={-520473558},hits={0}},
{time=6000,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Wasp_attack_skill_02"}
},
[-520473558]={
effect="cast2_hit2",time=10000,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",time=1800,type=0,pos_ref={ref_type=6,offset_height=115},cue_sheet="cv/Wasp.acb",cue_name="Wasp_09",cue_feature=1},
{delay=800,time=3100,type=1,hit_type=0,hit_delay_coeff_dis=18,hit_dis_offset=200,destroy_eff_when_hit=1,camera_shake={time=350,shake_dir=1,range=500,range2=25,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}},
{time=1800,type=0,cue_sheet="fight/effect/thrid.acb",cue_name="Wasp_attack_general"}
},
[1349028111]={
effect="qc_shoot_medium_hit",effect_pack="common_hit",time=3000,type=0,pos_ref={ref_type=4,offset_height=20,part_index=0},cue_sheet="fight/effect/explosion_.acb",cue_name="OnHit_05"
},
[-1183793042]={
{time=3000,type=0}
},
[-1328923786]={
{time=3000,type=0}
}
};

return this;