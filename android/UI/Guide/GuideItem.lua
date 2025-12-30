--引导界面

function Set(cfg)
    currCfg = cfg;
    local isCommonCtrl = not cfg.custom_ctrl;
   
    EventMgr.Dispatch(EventType.Input_Event_State,isCommonCtrl,true);	
    CSAPI.SetGOActive(btn,not isCommonCtrl);

    local btnFindState = not isCommonCtrl and cfg.btn_check and true or false;
    CSAPI.SetGOActive(btnFind,btnFindState);

    if(cfg.mask_alpha)then
        local canvasGroup = ComUtil.GetCom(mask, "CanvasGroup");
        canvasGroup.alpha = cfg.mask_alpha * 0.01;
    end

    CSAPI.SetGOActive(frame,not cfg.no_click_frame);
    CSAPI.SetGOActive(aniFrame,cfg.name and (not cfg.no_ani_frame) and true or false);

    FuncUtil:Call(CSAPI.SetGOActive,nil,100,clickMask,false);

    if(cfg.hand_angle)then
        CSAPI.SetAngle(frame,0,0,cfg.hand_angle);
    end
    --CSAPI.SetAngle(frame,0,0,180);
end

function SetPos(go)
    
end

function OnClick()
    if(currCfg)then
        GuideMgr:ApplyBehaviour(currCfg);
        currCfg = nil;
    end
end

function OnClickFindBtn()
    if(currCfg)then          
        if(GuideMgr:ApplyCallBtn(currCfg))then
            currCfg = nil;
        end
    end
end


function SetShowState(state)
    CSAPI.SetGOActive(showNode,state);
end