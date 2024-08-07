--地区设置
RegionalSet={}
local this=RegionalSet;
---1:中国内陆
---2：港澳台
---3：日语
---4：英文
---5：韩国
this.CurrentRegion=1;
---地区货币类型
function this.RegionalCurrencyType()
    if this.CurrentRegion==1 then
        return "￥";
    elseif this.CurrentRegion==2 then
        return "TWD";
    elseif this.CurrentRegion==5 then
        return "KRW";
    else
        return "￥";
    end
end