local conf = {
	["filename"] = 's-上报映射.xlsx',
	["sheetname"] = '上报映射',
	["types"] = {
'int','string','string','string'
},
	["names"] = {
'id','TE_event','HC_event','HC_argument'
},
	["data"] = {
{'10001',	'before_login',	'event_1',	'param1'},
{'10002',	'before_login',	'',	''},
{'10003',	'before_login',	'',	''},
{'10004',	'before_login',	'',	''},
{'10005',	'before_login',	'event_1',	'param2'},
{'10006',	'before_login',	'event_1',	'param3'},
{'10007',	'before_login',	'event_1',	'param4'},
{'10008',	'before_login',	'',	''},
{'10009',	'before_login',	'',	''},
{'10010',	'before_login',	'',	''},
{'10011',	'before_login',	'',	''},
{'10012',	'before_login',	'event_1',	'param5'},
{'10013',	'before_login',	'',	''},
{'10014',	'before_login',	'',	''},
{'10015',	'before_login',	'',	''},
{'10016',	'before_login',	'',	''},
{'10017',	'before_login',	'event_1',	'param6'},
{'10018',	'before_login',	'',	''},
{'10019',	'before_login',	'event_1',	'param7'},
{'10020',	'before_login',	'',	''},
{'10021',	'before_login',	'event_1',	'param8'},
{'10022',	'before_login',	'event_1',	'param9'},
{'20001',	'after_login',	'event_2',	'param1'},
{'20002',	'after_login',	'',	''},
{'20003',	'after_login',	'',	''},
{'20004',	'after_login',	'',	''},
{'20005',	'after_login',	'',	''},
{'20006',	'after_login',	'',	''},
{'20007',	'after_login',	'',	''},
{'20008',	'after_login',	'',	''},
{'20009',	'after_login',	'',	''},
{'20010',	'after_login',	'',	''},
{'20011',	'after_login',	'',	''},
{'20012',	'after_login',	'',	''},
{'20013',	'after_login',	'',	''},
{'20014',	'after_login',	'',	''},
{'20015',	'after_login',	'',	''},
{'20016',	'after_login',	'',	''},
{'20017',	'after_login',	'',	''},
{'20018',	'after_login',	'',	''},
{'20019',	'after_login',	'',	''},
{'20020',	'after_login',	'',	''},
{'20021',	'after_login',	'',	''},
{'20022',	'after_login',	'',	''},
{'20023',	'after_login',	'',	''},
{'20024',	'after_login',	'',	''},
{'20025',	'after_login',	'',	''},
{'20026',	'after_login',	'',	''},
{'20027',	'after_login',	'',	''},
{'20028',	'after_login',	'',	''},
{'20029',	'after_login',	'',	''},
{'20030',	'after_login',	'',	''},
{'20031',	'after_login',	'',	''},
{'20032',	'after_login',	'event_2',	'param2'},
{'20033',	'after_login',	'',	''},
{'20034',	'after_login',	'',	''},
{'20035',	'after_login',	'',	''},
{'20036',	'after_login',	'',	''},
{'20037',	'after_login',	'',	''},
{'20038',	'after_login',	'',	''},
{'20039',	'after_login',	'',	''},
{'20040',	'after_login',	'',	''},
{'20041',	'after_login',	'',	''},
{'20042',	'after_login',	'event_2',	'param3'},
{'30003',	'after_login',	'',	''},
{'20043',	'after_login',	'',	''},
{'20044',	'after_login',	'',	''},
{'20045',	'after_login',	'',	''},
{'20046',	'after_login',	'',	''},
{'20047',	'after_login',	'',	''},
{'20048',	'after_login',	'',	''},
{'20049',	'after_login',	'',	''},
{'20050',	'after_login',	'event_2',	'param4'},
{'20051',	'after_login',	'',	''},
{'20052',	'after_login',	'',	''},
{'20053',	'after_login',	'',	''},
{'20054',	'after_login',	'',	''},
{'20055',	'after_login',	'',	''},
{'20056',	'after_login',	'',	''},
{'20057',	'after_login',	'',	''},
{'20058',	'after_login',	'',	''},
{'20059',	'after_login',	'',	''},
{'20060',	'after_login',	'',	''},
{'20061',	'after_login',	'',	''},
{'20062',	'after_login',	'',	''},
{'20063',	'after_login',	'',	''},
{'20064',	'after_login',	'',	''},
{'20065',	'after_login',	'',	''},
{'20066',	'after_login',	'event_2',	'param5'},
{'20067',	'after_login',	'',	''},
{'20068',	'after_login',	'',	''},
{'20069',	'after_login',	'',	''},
{'20070',	'after_login',	'',	''},
{'20071',	'after_login',	'',	''},
{'20072',	'after_login',	'',	''},
{'20073',	'after_login',	'',	''},
{'20074',	'after_login',	'',	''},
{'20075',	'after_login',	'',	''},
{'20076',	'after_login',	'',	''},
{'20077',	'after_login',	'',	''},
{'20078',	'after_login',	'',	''},
{'20079',	'after_login',	'',	''},
{'20080',	'after_login',	'',	''},
{'20081',	'after_login',	'',	''},
{'20082',	'after_login',	'',	''},
{'20083',	'after_login',	'',	''},
{'20084',	'after_login',	'',	''},
{'20085',	'after_login',	'',	''},
{'20086',	'after_login',	'',	''},
{'20087',	'after_login',	'',	''},
{'20088',	'after_login',	'',	''},
{'20089',	'after_login',	'',	''},
{'20090',	'after_login',	'',	''},
{'20091',	'after_login',	'',	''},
{'20092',	'after_login',	'',	''},
{'20093',	'after_login',	'',	''},
{'20094',	'after_login',	'',	''},
{'20095',	'after_login',	'',	''},
{'20096',	'after_login',	'',	''},
{'20097',	'after_login',	'',	''},
{'20098',	'after_login',	'event_2',	'param6'},
{'20099',	'after_login',	'',	''},
{'20100',	'after_login',	'',	''},
{'20101',	'after_login',	'',	''},
{'20102',	'after_login',	'',	''},
{'20103',	'after_login',	'',	''},
{'20104',	'after_login',	'event_2',	'param7'},
{'20105',	'after_login',	'',	''},
{'20106',	'after_login',	'',	''},
{'20107',	'after_login',	'',	''},
{'20108',	'after_login',	'',	''},
{'20109',	'after_login',	'',	''},
{'20110',	'after_login',	'',	''},
{'20111',	'after_login',	'event_2',	'param8'},
{'20112',	'after_login',	'',	''},
{'20113',	'after_login',	'',	''},
{'20114',	'after_login',	'',	''},
{'20115',	'after_login',	'',	''},
{'20116',	'after_login',	'',	''},
{'20117',	'after_login',	'event_2',	'param9'},
{'20118',	'after_login',	'',	''},
{'20119',	'after_login',	'',	''},
{'20120',	'after_login',	'',	''},
{'20121',	'after_login',	'',	''},
{'20122',	'after_login',	'',	''},
{'20123',	'after_login',	'',	''},
{'20124',	'after_login',	'',	''},
{'20125',	'after_login',	'',	''},
{'20126',	'after_login',	'',	''},
{'20127',	'after_login',	'',	''},
{'20128',	'after_login',	'',	''},
{'20129',	'after_login',	'',	''},
{'20130',	'after_login',	'',	''},
{'20131',	'after_login',	'',	''},
{'20132',	'after_login',	'',	''},
{'20133',	'after_login',	'',	''},
{'20134',	'after_login',	'',	''},
{'20135',	'after_login',	'',	''},
{'20136',	'after_login',	'',	''},
{'20137',	'after_login',	'',	''},
{'20138',	'after_login',	'',	''},
{'20139',	'after_login',	'',	''},
{'20140',	'after_login',	'',	''},
{'20141',	'after_login',	'',	''},
{'20142',	'after_login',	'',	''},
{'20143',	'after_login',	'',	''},
{'20144',	'after_login',	'',	''},
{'20145',	'after_login',	'',	''},
{'20146',	'after_login',	'',	''},
{'20147',	'after_login',	'',	''},
{'20148',	'after_login',	'',	''},
{'20149',	'after_login',	'',	''},
{'20150',	'after_login',	'',	''},
{'20151',	'after_login',	'',	''},
{'20152',	'after_login',	'',	''},
{'20153',	'after_login',	'',	''},
{'20154',	'after_login',	'',	''},
{'20155',	'after_login',	'',	''},
{'20156',	'after_login',	'',	''},
{'20157',	'after_login',	'',	''},
{'20158',	'after_login',	'',	''},
{'20159',	'after_login',	'',	''},
{'20160',	'after_login',	'',	''},
{'20161',	'after_login',	'',	''},
{'20162',	'after_login',	'',	''},
{'20163',	'after_login',	'',	''},
{'20164',	'after_login',	'',	''},
{'20165',	'after_login',	'',	''},
{'20166',	'after_login',	'',	''},
{'20167',	'after_login',	'',	''},
{'20168',	'after_login',	'',	''},
{'20169',	'after_login',	'',	''},
{'20170',	'after_login',	'',	''},
{'20171',	'after_login',	'',	''},
{'20172',	'after_login',	'',	''},
{'20173',	'after_login',	'',	''},
{'20174',	'after_login',	'',	''},
{'20175',	'after_login',	'',	''},
{'20176',	'after_login',	'',	''},
{'20177',	'after_login',	'',	''},
{'20178',	'after_login',	'',	''},
{'20179',	'after_login',	'',	''},
{'20180',	'after_login',	'',	''},
{'20181',	'after_login',	'',	''},
{'20182',	'after_login',	'',	''},
{'20183',	'after_login',	'',	''},
{'20184',	'after_login',	'',	''},
{'20185',	'after_login',	'',	''},
{'20186',	'after_login',	'',	''},
{'20187',	'after_login',	'',	''},
{'20188',	'after_login',	'event_2',	'param10'},
},
}
--cfgUpdateData = conf
return conf