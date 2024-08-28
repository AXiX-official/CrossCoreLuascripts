--特殊勘探道具展示物体
local data=nil;
local girds={};
local click=nil;
local action=nil;
local action2=nil;
function Awake()
    action=ComUtil.GetCom(enterTween,"ActionMoveByCurve");
    action2=ComUtil.GetCom(enterTween2,"ActionMoveByCurve");
end

--_d:CfgExtraExploration
function Refresh(_d,state,upExp)
    data=_d
    if data then
        --设置代币数量
        if _d.isInfinite then
            CSAPI.SetText(txtNum,tostring(upExp));
        else
            CSAPI.SetText(txtNum,tostring(_d.exp));
        end
        local list=GridUtil.GetGridObjectDatas2(_d.reward);
        local cb=state==2 and OnClickItem or GridClickFunc.OpenInfoSmiple;
        -- ItemUtil.AddItems("Grid/GridItem", girds, list, layout, cb, 1)
        for i=1,3 do
            CSAPI.SetGOActive(this["over"..i],i<=#list);
            CSAPI.SetGOActive(this["node"..i],i<=#list);
            if i>#girds then
                ResUtil:CreateUIGOAsync("Grid/GridItem", this["node"..i],function(go)
                    local lua=ComUtil.GetLuaTable(go);
                    lua.Refresh(list[i]);
                    lua.SetClickCB(cb);
                    table.insert(girds,lua);
                    UIUtil:SetRedPoint2("Common/Red2", this["node"..i], state==2, 80, 80, 0, 1.44)
                end)
            else
                if i<=#list then
                    girds[i].Refresh(list[i]);
                    girds[i].SetClickCB(cb);
                    UIUtil:SetRedPoint2("Common/Red2", this["node"..i], state==2, 80, 80, 0, 1.44)
                end
            end
        end
        --初始化物品信息和领取状况
        if data.tag then
            CSAPI.LoadImg(top,"UIs/SpecialExploration/img_09_01.png",true,nil,true);
            CSAPI.LoadImg(root,"UIs/SpecialExploration/img_07_02.png",true,nil,true);
        else
            CSAPI.LoadImg(top,"UIs/SpecialExploration/img_08_01.png",true,nil,true);
            CSAPI.LoadImg(root,"UIs/SpecialExploration/img_08_02.png",true,nil,true);
        end
    end
    CSAPI.SetGOActive(lockObj,state==1);
    CSAPI.SetGOActive(redObj,state==2);
    CSAPI.SetGOActive(mask,state==3);
end

function SetEnterTween(startPos,delayTime,isLast)
    if action and action2 and startPos then
        action.delay=delayTime or 0;
        action:SetStartPos(startPos[1],startPos[2] or 0,startPos[3] or 0);
        local x=CSAPI.GetAnchor(tweenNode);
        action:Play();
        if isLast then
            action2:Play(function ()
                EventMgr.Dispatch(EventType.SpecialExploration_Tween_Over);
            end);
        else
            action2:Play();
        end
    end
end

function SetPos(startPos)
    CSAPI.SetAnchor(tweenNode,startPos[1] or 0,startPos[2] or 0);
end

--发送领取协议
function OnClickItem()
    if click then
        click(data);
    end
end

function SetClickCB(_click)
    click=_click;
end