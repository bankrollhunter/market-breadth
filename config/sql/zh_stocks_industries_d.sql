create view tmp_zh_stocks_sector_d as
select
   date
  ,sector
  ,sum(is_above_s_ma) / COUNT(DISTINCT code) as above_rate
from (
  select
     `t1`.`date` AS `date`
    ,`t1`.`code` AS `code`
    ,`t1`.`industry` AS `sector`
    ,`t1`.`is_above_s_ma` AS `is_above_s_ma`
  from (
    select
       *,case when (`close` > `s_ma`) then 1 else 0 end AS `is_above_s_ma`
      from `zh_stocks_d`
      where (`date` >= DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 6 month), '%Y-%m-%d'))
  ) `t1`
) a
where (`a`.`sector` is not null)
group by
   date
  ,sector
;

create view zh_stocks_industries_d as
SELECT
	`tmp_zh_stocks_sector_d`.`date` AS `date`,
	round(
		sum(
			(
				`tmp_zh_stocks_sector_d`.`above_rate` * 100 / 110
			)
		),
		0
	) AS `TOTAL`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = 'IT设备'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `IT设备`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '专用机械'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `专用机械`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '中成药'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `中成药`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '乳制品'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `乳制品`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '互联网'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `互联网`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '仓储物流'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `仓储物流`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '供气供热'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `供气供热`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '保险'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `保险`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '元器件'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `元器件`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '全国地产'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `全国地产`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '公共交通'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `公共交通`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '公路'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `公路`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '其他商业'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `其他商业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '其他建材'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `其他建材`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '农业综合'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `农业综合`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '农用机械'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `农用机械`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '农药化肥'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `农药化肥`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '出版业'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `出版业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '化学制药'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `化学制药`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '化工原料'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `化工原料`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '化工机械'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `化工机械`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '化纤'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `化纤`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '区域地产'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `区域地产`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '医疗保健'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `医疗保健`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '医药商业'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `医药商业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '半导体'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `半导体`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '商品城'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `商品城`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '商贸代理'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `商贸代理`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '啤酒'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `啤酒`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '园区开发'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `园区开发`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '塑料'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `塑料`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '多元金融'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `多元金融`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '家居用品'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `家居用品`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '家用电器'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `家用电器`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '小金属'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `小金属`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '工程机械'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `工程机械`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '广告包装'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `广告包装`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '建筑工程'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `建筑工程`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '影视音像'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `影视音像`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '房产服务'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `房产服务`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '批发业'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `批发业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '摩托车'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `摩托车`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '文教休闲'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `文教休闲`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '新型电力'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `新型电力`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '旅游景点'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `旅游景点`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '旅游服务'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `旅游服务`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '日用化工'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `日用化工`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '普钢'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `普钢`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '服饰'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `服饰`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '机场'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `机场`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '机床制造'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `机床制造`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '机械基件'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `机械基件`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '林业'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `林业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '染料涂料'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `染料涂料`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '橡胶'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `橡胶`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '水力发电'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `水力发电`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '水务'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `水务`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '水泥'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `水泥`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '水运'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `水运`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '汽车整车'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `汽车整车`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '汽车服务'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `汽车服务`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '汽车配件'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `汽车配件`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '渔业'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `渔业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '港口'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `港口`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '火力发电'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `火力发电`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '焦炭加工'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `焦炭加工`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '煤炭开采'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `煤炭开采`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '特种钢'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `特种钢`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '环境保护'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `环境保护`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '玻璃'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `玻璃`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '生物制药'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `生物制药`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '电信运营'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `电信运营`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '电器仪表'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `电器仪表`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '电器连锁'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `电器连锁`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '电气设备'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `电气设备`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '白酒'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `白酒`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '百货'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `百货`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '石油加工'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `石油加工`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '石油开采'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `石油开采`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '石油贸易'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `石油贸易`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '矿物制品'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `矿物制品`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '种植业'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `种植业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '空运'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `空运`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '红黄酒'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `红黄酒`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '纺织'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `纺织`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '纺织机械'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `纺织机械`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '综合类'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `综合类`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '航空'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `航空`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '船舶'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `船舶`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '装修装饰'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `装修装饰`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '证券'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `证券`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '超市连锁'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `超市连锁`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '路桥'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `路桥`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '软件服务'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `软件服务`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '软饮料'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `软饮料`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '轻工机械'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `轻工机械`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '运输设备'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `运输设备`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '通信设备'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `通信设备`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '造纸'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `造纸`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '酒店餐饮'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `酒店餐饮`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '钢加工'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `钢加工`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '铁路'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `铁路`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '铅锌'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `铅锌`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '铜'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `铜`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '铝'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `铝`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '银行'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `银行`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '陶瓷'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `陶瓷`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '食品'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `食品`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '饲料'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `饲料`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sector_d`.`sector` = '黄金'
				),
				(
					`tmp_zh_stocks_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `黄金`
FROM
	`tmp_zh_stocks_sector_d`
GROUP BY
	`tmp_zh_stocks_sector_d`.`date`
ORDER BY
	`tmp_zh_stocks_sector_d`.`date` DESC
;