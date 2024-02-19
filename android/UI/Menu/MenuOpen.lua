-- function OnClickMask()
-- 	--特殊类型的(依次弹出)
-- 	local fatherView = data and data:GetFatherView() or nil
-- 	if(fatherView) then
-- 		if(MenuMgr:CheckOpenList(fatherView)) then
-- 			CSAPI.SetGOActive(img, false)
-- 			CSAPI.SetGOActive(bg, false)
-- 			CSAPI.OpenView("MenuOpen", MenuMgr:GetPost(fatherView), nil, nil, true)
-- 			return
-- 		end
-- 	end
-- 	view:Close()
-- 	local str = data:GetID() or ""
-- 	--如果是签到系统开启，则检测一次签到
-- 	if(str == "SignInView") then
-- 		SignInMgr:CheckAll()
-- 	end
-- end
-- 副产品获得的奖励界面
function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")

end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    SetPanel()
end

function SetPanel()
    local datas = MenuMgr:GetWaitDatas()
    items = items or {}
    ItemUtil.AddItems("Popup/MenuOpenItem", items, datas, node,ItemClickCB)
end

function ItemClickCB()
    view:Close()
end

function OnClickMask()
    if not isCanBack then
        return
    end
    fade:Play(1, 0, 167, 0, function()
        view:Close()
    end)
end

function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end

