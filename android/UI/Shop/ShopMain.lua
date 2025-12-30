local cfg=nil;
function Awake()
    --读取表中的配置初始化图片
    cfg=Cfgs.CfgShopReCommend:GetByID(1);
    if cfg then
        --读取皮肤立绘
        local pos, scale, imgName = RoleTool.GetImgPosScale(cfg.skinID, LoadImgType.Shop);
        if(pos) then
            ResUtil.ImgCharacter:Load(roleImg, imgName);
            ResUtil.ImgCharacter:SetPos(roleImg,pos);
            ResUtil.ImgCharacter:SetScale(roleImg, scale);
        end
        --读取商品图片
        ResUtil.ShopImg:Load(order1,cfg.order1Img);
        ResUtil.ShopImg:Load(order2,cfg.order2Img);
    end
end

--点击查看详情
function OnClickDetails()
    if cfg and cfg.sJumpID then
        JumpMgr:Jump(cfg.sJumpID);
    end
end

function OnClickOrder1()
    if cfg and cfg.oJumpID1 then
        JumpMgr:Jump(cfg.oJumpID1);
    end
end

function OnClickOrder2()
    if cfg and cfg.oJumpID2 then
        JumpMgr:Jump(cfg.oJumpID2);
    end
end