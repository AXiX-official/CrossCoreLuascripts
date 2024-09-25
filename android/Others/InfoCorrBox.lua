local inpName = nil
local playerName = ""

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Player_EditName,OnNameChange)

    inpName = ComUtil.GetCom(inputName, "InputField");
    CSAPI.AddInputFieldChange(inputName, InputChange)
end

function InputChange(_str)
	_str = StringUtil:FilterChar(_str)
	local str = StringUtil:SetStringByLen(_str, 7)
	inpName.text = str
end

function OnNameChange()
    view:Close()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    SetCount()
end

function SetCount()
    local cfg = Cfgs.ItemInfo:GetByID(25001)
    if cfg then
        CSAPI.SetText(txtName,cfg.name.."：")
        CSAPI.SetText(txtNum,BagMgr:GetCount(cfg.id).."")
    end
end

function OnClickOK()
	local cfg = Cfgs.ItemInfo:GetByID(25001)
	if cfg then
		local count = BagMgr:GetCount(cfg.id)
		if count and count <= 0 then
			LanguageMgr:ShowTips(30003)
			return
		end
	end

    playerName = inpName.text
	if playerName == nil or playerName == "" then
		Tips.ShowTips(LanguageMgr:GetByID(16005));
		return
	end
	if IsEmoji(playerName) then
		Tips.ShowTips(LanguageMgr:GetByID(16064));
		return
	end
    local b = MsgParser:CheckContain(playerName)
	if(b) then
		LanguageMgr:ShowTips(9003)
		return
	end
	local dialogData = {}
	dialogData.content = LanguageMgr:GetTips(30004)
	dialogData.okCallBack = function()
		EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="name_change_check",time=1500,
		timeOutCallBack=function ()
			-- Tips.ShowTips("检查姓名超时,请点击重试！")
			LanguageMgr:ShowTips(6016)
		end});

		PlayerProto:PlrNameCheckUse({name = playerName},function(proto)
			EventMgr.Dispatch(EventType.Net_Msg_Getted,"name_change_check");
			if proto and not proto.isUse then
				PlayerProto:ChangePlrName(playerName, 25001)
			else
				Tips.ShowTips(LanguageMgr:GetByID(16076));
			end
		end)
	end
	CSAPI.OpenView("Dialog",dialogData)
end

function IsEmoji(_str)
	local len = StringUtil:Utf8Len(_str)
	for i = 1, len do
		local str = StringUtil:Utf8Sub(_str, i, i)
		local byteLen = string.len(str)--编码占多少字节
		if byteLen > 3 then--超过三个字节的必须是emoji字符啊
			return true
		end
		
		if byteLen == 3 then
			if string.find(str, "[\226][\132-\173]") or string.find(str, "[\227][\128\138]") then
				return true--过滤部分三个字节表示的emoji字符，可能是早期的符号，用的还是三字节，坑。。。这里不保证完全正确，可能会过滤部分中文字。。。
			end
		end
		
		if byteLen == 1 then
			local ox = string.byte(str)
			if(33 <= ox and 47 >= ox) or(58 <= ox and 64 >= ox) or(91 <= ox and 96 >= ox) or(123 <= ox and 126 >= ox) or(str == "　") then
				return true--过滤ASCII字符中的部分标点，这里排除了空格，用编码来过滤有很好的扩展性，如果是标点可以直接用%p匹配。
			end
		end
	end
	return false
end

function OnClickCancel()
    view:Close()
end