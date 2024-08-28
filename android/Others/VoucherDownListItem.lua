--折扣券下拉子物体
local click=nil;
function Refresh(_d,index)
    local isSelect=false;
    this.data=_d;
    if _d then
        CSAPI.SetText(txt,_d.txt);
        CSAPI.SetText(txt2,_d.txt2);
        isSelect=this.index==index and true or false;
    end
    SetSelect(isSelect);
end

function SetSelect(_isSelect)
    if _isSelect then
        CSAPI.SetImgColorByCode(bg,"FFC146");
        CSAPI.SetTextColorByCode(txt,"0f0f19");
        CSAPI.SetTextColorByCode(txt2,"0f0f19");
    else
        CSAPI.SetImgColorByCode(bg,this.index%2==1 and "21212b" or "0f0f19");
        CSAPI.SetTextColorByCode(txt,"929296");
        CSAPI.SetTextColorByCode(txt2,"929296");
    end
end

function SetIndex(i)
    this.index=i;
end

function GetIndex()
    return this.index;
end

function SetClickCB(_click)
    click=_click;
end

function OnClickItem()
    if click then
        click(this);
    end
end
