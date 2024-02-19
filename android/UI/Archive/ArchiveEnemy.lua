local cfg = nil

function OnInit()
	UIUtil:AddTop2("ArchiveEnemy", gameObject, function()
		view:Close()
	end, nil, "")
end

function OnOpen()
	if data then
		cfg = data
		RefreshPanel()
	end
end

function RefreshPanel()
	SetLeft()
	SetRight()
end

function SetLeft()
	--name
	CSAPI.SetText(txtName1, cfg.name or "")
	CSAPI.SetText(txtName2, cfg.name_en or "")
	
	--type
	local cfgMEnum = Cfgs.CfgMonsterEnum:GetByID(tonumber(cfg.type))
	CSAPI.SetText(txtType, cfgMEnum.sName)
	
	--icon
	RoleTool.LoadImg(icon, cfg.aModels, LoadImgType.Archive)
end

function SetRight()
	--bgInfo
	CSAPI.SetText(txtBgInfo, cfg.bgDesc or "")
	
	--skilDesc
	CSAPI.SetText(txtSkillInfo, cfg.skillDesc or "")
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
icon=nil;
txtName1=nil;
txtName2=nil;
txtType=nil;
txt_title1=nil;
txt_title2=nil;
txtBgInfo=nil;
txtSkillInfo=nil;
view=nil;
end
----#End#----