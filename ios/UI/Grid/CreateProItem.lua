-- RewardInfo2 的某 index

local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName)
end
function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(txtName)
        needToCheckMove = false
    end
end

function Refresh(cfg)
    local cardCfg = Cfgs.CardData:GetByID(cfg.id)
    cfgID = cardCfg.id

    -- bg
    LoadFrame(cardCfg.quality)
    -- icon
    local modelCfg = Cfgs.character:GetByID(cardCfg.model)
    LoadIcon(modelCfg.icon)
    -- pickup
    CSAPI.SetGOActive(pickup, cfg.desc ~= nil)
    -- name
    needToCheckMove = false
    CSAPI.SetText(txtName, cardCfg.name)
    needToCheckMove = true
    -- imgStar
    ResUtil.CardBorder:Load(imgStar, "img_101_0" .. cardCfg.quality)
end

-- 加载框
function LoadFrame(lvQuality)
    lvQuality = lvQuality or 1
    local frame = "img_01_0" .. lvQuality
    ResUtil.CardBorder:Load(bg, frame)
end

-- 加载图标
function LoadIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.RoleCard:Load(icon, iconName .. "")
    end
end

function OnClick()
    local cardData = RoleMgr:GetMaxFakeData(cfgID)
    CSAPI.OpenView("RoleInfo", cardData)
end
