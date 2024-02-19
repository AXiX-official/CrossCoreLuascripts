--皮肤信息子物体

--data:this.data
local modelCfg=nil
function Refresh(_data,_elseData)
    this.data=_data;
    this.elseData=_elseData;
    -- this.data=ShopCommFunc.GetSkinInfo(_data);
    if this.data then
        modelCfg=this.data:GetModelCfg();
        ResUtil.CardIcon:Load(icon,modelCfg.Card_head,true);
        SetName(this.data:GetRoleName());
        SetSName(this.data:GetSkinName());
        SetL2dTag(this.data:HasL2D());
        SetAnimaTag(this.data:HasEnterTween());
        SetModelTag(this.data:HasModel());
        local comm=ShopCommFunc.GetSkinCommodity(this.data:GetModelID());
        if comm then
            SetSPPriceTag(comm:HasDiscountTag());
        else
            SetSPPriceTag();
        end
        SetSPTag(this.data:HasSpecial());
        local cfg=this.data:GetSetCfg();
        SetSIcon(cfg.icon);
        local getType,getTips=this.data:GetWayInfo();
        SetGetTag(getType,getTips);
        if this.elseData then
            local rInfo=RoleSkinMgr:GetRoleSkinInfo(modelCfg.role_id,modelCfg.id)
            if this.elseData.flag and rInfo then
                local isHas=rInfo:CheckCanUse()
                SetHas(isHas);
                CSAPI.SetImgColor(setIcon,255,255,255,isHas and 255 or 50);
            else
                SetHas(true);--隐藏未持有的标签
            end
        else
            SetHas(true);--隐藏未持有的标签
        end
    else
        LogError("未找到对应的模型Id");
    end
    
end

function SetSIcon(iconName)
    CSAPI.SetGOActive(setIcon,iconName~=nil);
    if iconName then
        ResUtil.SkinSetIcon:Load(setIcon,iconName.."_w",true);
    end
end

function SetSName(str)
    CSAPI.SetText(txt_set,str or "");
end

function SetName(str)
    CSAPI.SetText(txt_name,str or "");
end

function SetHas(isHas)
    CSAPI.SetGOActive(hasObj,not isHas);
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode,val);
end

function SetGetTag(getType,getTips)
   if getType==SkinGetType.Store then
        local isBtnShow=false
        if modelCfg and modelCfg.shopId then
            local commodity=ShopMgr:GetFixedCommodity(modelCfg.shopId);
            local canBuy=commodity:GetNowTimeCanBuy()
            CSAPI.SetGOActive(buyTag,canBuy==true);
        end
        CSAPI.SetGOActive(getTag,false);
    elseif getType==SkinGetType.Archive then
        CSAPI.SetGOActive(buyTag,false);
        CSAPI.SetGOActive(getTag,true);
        ResUtil.Tag:Load(getTag,"img9_03_06",false);
        CSAPI.SetText(txt_getTag,getTips);
    elseif getType==SkinGetType.Other then
        CSAPI.SetGOActive(buyTag,false);
        CSAPI.SetGOActive(getTag,true);
        ResUtil.Tag:Load(getTag,"img9_03_05",false);
        CSAPI.SetText(txt_getTag,getTips);
    else
        CSAPI.SetGOActive(buyTag,false);
        CSAPI.SetGOActive(getTag,false);
    end
end


function SetL2dTag(isShow)
    --CSAPI.SetGOActive(l2dTag,isShow==true); --和谐隐藏
end

function SetAnimaTag(isShow)
    --CSAPI.SetGOActive(animaTag,isShow==true);
end

function SetModelTag(isShow)
    --CSAPI.SetGOActive(modelTag,isShow==true);
end

function SetSPPriceTag(isShow)
    --CSAPI.SetGOActive(spPriceTag,isShow==true);
end

function SetSPTag(isShow)
    --CSAPI.SetGOActive(spTag,isShow==true);
end


function SetClickCB(cb)
    this.cb=cb;
end

function OnClickSelf()
    if this.cb then
        this.cb(this);
    end
end

function SetIndex(index)
    this.index=index;
end

function GetIndex()
    return this.index;
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(selectObj,isSelect);
    CSAPI.SetGOActive(border,not isSelect);
    SetAlpha(isSelect and 1 or 0.5);
end

function OnClickBuy()

end

function SetSibling(index)
    index=index or 0;
    if index==-1 then
        transform:SetAsLastSibling();
    else
        transform:SetSiblingIndex(index);
    end
end

--根据X轴距离设置大小
function SetScale(s)
    CSAPI.SetScale(alphaNode,s,s,s);
end

function GetPos()
    local pos={100000,100000,0};
    local x,y,z=CSAPI.GetPos(alphaNode);
    pos={x,y,z}
    return pos;
end