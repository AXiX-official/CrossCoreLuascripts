
function OnOpen()
    Refresh();
end

function Refresh()
    local index=1;
    if data then
        local hadL2d=data:HadLive2D();
        if hadL2d~=nil then
            local iconName=nil;
            local lID=0;
            if hadL2d==1 then
                iconName="img_22_03";
                lID=18136;
            elseif hadL2d==2 then
                iconName="img_22_07";
                lID=18137;
            elseif hadL2d==3 then
                iconName="img_22_06";
                lID=18138;
            end
            ResUtil.Tag:Load(desc1Icon,iconName);
            CSAPI.SetText(desc1Txt,LanguageMgr:GetByID(lID));
            index=index+1;
        end
        if data:HasModel() then
            ResUtil.Tag:Load(this[("desc"..index.."Icon")],"img_22_05");
            CSAPI.SetText(this[("desc"..index.."Txt")],LanguageMgr:GetByID(18139));
            index=index+1;
        end
        if data:HasSpecial() then
            ResUtil.Tag:Load(this[("desc"..index.."Icon")],"img_22_04");
            CSAPI.SetText(this[("desc"..index.."Txt")],LanguageMgr:GetByID(18140));
            index=index+1;
        end
        for i=1,index do
            CSAPI.SetGOActive(this["desc"..i],true);
        end
        if index<=3 then
            for i=index,3 do
                CSAPI.SetGOActive(this["desc"..i],false);
            end
        end
    end
end

function OnClickAnyWay()
    if not IsNil(view) then
        view:Close();
    end
end