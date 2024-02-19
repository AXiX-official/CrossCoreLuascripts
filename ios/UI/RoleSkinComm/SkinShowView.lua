--皮肤展示界面
local roleItem=nil;
local effect=nil;
local skinDesc=""
 
this.ClickBtn=nil;
function Awake()
    roleItem = RoleTool.AddRole(iconParent, PlayCB, nil, false)		
end

--data:ShopSkinInfo
function OnOpen()
    if data then
        CSAPI.SetGOActive(clicker,false)
        local hasEnter=data:HasEnterTween();
        roleItem.Refresh(data:GetModelID(), LoadImgType.SkinReward,function()
            if roleItem.CheckIn() and CSAPI.IsInternation() then --有反和谐且有入场动画
                roleItem.PlayIn(function()
                    ShowTween2(roleItem.CheckIn())
                end,iconParent);
            else
                PlayShowTween();
            end
        end,hasEnter)
        local cfg=data:GetSetCfg();
        ResUtil.SkinSetIcon:Load(setIcon,cfg.icon.."_w",true);
        local modelCfg=data:GetModelCfg();
        CSAPI.SetText(txt_set,modelCfg.desc);
        CSAPI.SetText(txt_roleName,modelCfg.key);
        CSAPI.SetText(txt_roleNameTips,modelCfg.englishName);
        skinDesc = data:GetSkinDesc()
    end
end

--不播放声音不会触发
function PlayCB(curCfg)
    -- Log(curCfg)
	if(not IsNil(gameObject)) then
		--local str = curCfg.script or ""
        local script = SettingMgr:GetSoundScript(curCfg)  or ""
		CSAPI.SetText(txt_desc, script)	
	end
end

function OnClickAnyway()
    if this.ClickBtn~=nil then
        this.ClickBtn()
    else
        CloseView()
    end
end

function CloseView()
    view:Close();
end

--播放获得动画
function PlayShowTween()
    --展示剪影 --680 从小变大 静止280——>播放特效 
    if roleItem.imgItemLua then
        roleItem.imgItemLua.SetBlack(true);
    elseif roleItem.live2DItemLua then
        roleItem.live2DItemLua.SetBlack(true);
    end
    CSAPI.SetGOActive(tween1,true);
    --播放特效
    FuncUtil:Call(function()
        ShowEffect(ShowTween2); 
    end, nil, 960)
end

function ShowTween2(isL2d)
    --显示角色立绘
    -- if roleItem.imgItemLua then
    -- roleItem.imgItemLua.SetBlack(false);
    -- end
    --显示粒子
    CSAPI.SetGOActive(fc_pifu_OutWhite,false);
    CSAPI.SetGOActive(effectNode,true);
    if isL2d then
        CSAPI.SetGOActive(tween3,true);
    else
        CSAPI.SetGOActive(tween2,true);
    end
    CSAPI.SetGOActive(clicker,true)
    CSAPI.SetText(txt_desc, skinDesc)	
    --播放语音
    -- roleItem.PlayVoice(RoleAudioType.get);
end

function ShowEffect(func)
     -- 自适应Baiping
     local arr = CSAPI.GetMainCanvasSize()
     CSAPI.SetGOActive(fc_pifu_ToWhite,true);
     CSAPI.SetScale(baiping2, arr.x, arr.y, 1)
     FuncUtil:Call(function()
        --显示角色立绘
        if roleItem.imgItemLua then
           roleItem.imgItemLua.SetBlack(false);
        elseif roleItem.live2DItemLua then
            roleItem.live2DItemLua.SetBlack(false);
        end
        CSAPI.SetGOActive(fc_pifu_ToWhite,false);
        CSAPI.SetGOActive(fc_pifu_OutWhite,true);
        CSAPI.SetScale(baiping, arr.x, arr.y, 1)
        --播放第二段段
        if func~=nil then
            -- FuncUtil:Call(func, nil, 300)
            FuncUtil:Call(func, nil, 0)
        end
    end, nil, 350)
end

--------------------------------------------用于奖励弹窗--------------------------------------------
function Init()
    CSAPI.SetGOActive(tween1, false)
    CSAPI.SetGOActive(tween2, false)
    CSAPI.SetGOActive(tween3, false)
    CSAPI.SetGOActive(stars, false)
    CSAPI.SetGOActive(effectNode, false)
    CSAPI.SetGOActive(fc_pifu_OutWhite, false)
    CSAPI.SetGOActive(fc_pifu_ToWhite, false)
    CSAPI.SetGOActive(clicker, false)
    CSAPI.SetGOAlpha(nameObj,0)
    CSAPI.SetGOAlpha(img1,0)
    CSAPI.SetScale(bottom,1,0,1)
    CSAPI.SetRTSize(line1,1,600)
    CSAPI.SetRTSize(line2,1,600)
end