function Awake()
	SetItem(s_audio_scale.music, item1)
	SetItem(s_audio_scale.sound, item2)
	SetItem(s_audio_scale.dubbing, item3)
	
	fade1 = ComUtil.GetCom(item1Fade,"ActionFade")
	fade2 = ComUtil.GetCom(item2Fade,"ActionFade")
	fade3 = ComUtil.GetCom(item3Fade,"ActionFade")
end

function OnEnable()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.BGM_Set,SetMusic)
end

function Refresh(type)
	if type then
		if type == SettingEnterType.Login or type == SettingEnterType.FightMenu then
			CSAPI.SetGOActive(node2,false)
		end
	else
		CSAPI.SetGOActive(node2,true)
		SetMusic()
	end
end

function OnDisable()
	eventMgr:ClearListener()
end

function SetItem(key, item)
	local go = ResUtil:CreateUIGO("Setting/SettingSliderItem2", item.transform)
	tab = ComUtil.GetLuaTable(go)
	tab.Init(key)
end

function SetFade(isOpen,callback)
	if not isOpen then
		fade1.delayValue = 1
		fade2.delayValue = 1
		fade3.delayValue = 1

		fade1:Play(1, 0, 200)
		fade2:Play(1, 0, 200, 67)
		fade3:Play(1, 0, 200, 133, function()
			if callback then 
				callback()
			end
			CSAPI.SetGOActive(gameObject, false)							
		end)
	else
		fade1.delayValue = 0
		fade2.delayValue = 0
		fade3.delayValue = 0
		CSAPI.SetGOActive(gameObject, true)
		fade1:Play(0, 1, 200, 100)
		fade2:Play(0, 1, 200, 200)
		fade3:Play(0, 1, 200, 300)		
	end
end 

function CloseSelectLanguage()
	CSAPI.SetGOActive(node2, false)
end

--中文
function OnClickCN()
    local state = SoundMgr:NeedDownloadLanguageCVs("cn");
    if(state)then
        local content = LanguageMgr:GetByID(14037);
        local content1 = LanguageMgr:GetByID(14034);
        content = string.format(content,content1);
        local dialogdata = {
			content = content,
			okCallBack = SureChangeToCN           
		}
		CSAPI.OpenView("Dialog", dialogdata);
    else
        SoundMgr:SetAllLanguageCVs("cn");
        Tips.ShowTips(LanguageMgr:GetTips(1012));

		--设置当前语音 --日：0 中：1
		SettingMgr:SaveValue("s_language_key", 1)
    end	
end

function SureChangeToCN()
    SoundMgr:SetAllLanguageCVs("cn");

    CSAPI.OpenView("Prompt", 
    {
        content = "语音资源下载中，完成后自动将切换",--LanguageMgr:GetByID(38010),
    });    

	--设置当前语音
	SettingMgr:SaveValue("s_language_key", 1)
end

--日文
function OnClickJP()
	SoundMgr:ResetAllLanguageCV();
    Tips.ShowTips(LanguageMgr:GetTips(1012));

	--设置当前语音
	SettingMgr:SaveValue("s_language_key", 0)
end

---------------------------------------------音乐播放器---------------------------------------------
--当前
function SetMusic()
	local cfg = Cfgs.CfgMusic:GetByID(BGMMgr:GetViewMusicID())
	CSAPI.SetText(txtName,cfg and cfg.sName or "")	
end

function OnClickMusic()
	CSAPI.OpenView("BgmView")
	-- LanguageMgr:ShowTips(1000)
end