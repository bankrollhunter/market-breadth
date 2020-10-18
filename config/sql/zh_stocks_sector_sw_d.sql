-- 创建 tmp_zh_stocks_sw_sector_d view
create view tmp_zh_stocks_sw_sector_d as
select
   date
  ,sector
  ,sum(is_above_s_ma) / COUNT(DISTINCT code) as above_rate
from (
  select
     `t1`.`date` AS `date`
    ,`t1`.`code` AS `code`
    ,`t1`.`sw_ind1` AS `sector`
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

-- 创建 zh_stocks_sector_sw_d view
create view zh_stocks_sector_sw_d as
SELECT
	`tmp_zh_stocks_sw_sector_d`.`date` AS `date`,
	round(
		sum(
			(
				`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100 / 28
			)
		),
		0
	) AS `TOTAL`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '交通运输'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `交通运输`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '传媒'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `传媒`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '公用事业'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `公用事业`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '农林牧渔'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `农林牧渔`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '化工'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `化工`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '医药生物'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `医药生物`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '商业贸易'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `商业贸易`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '国防军工'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `国防军工`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '家用电器'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
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
					`tmp_zh_stocks_sw_sector_d`.`sector` = '建筑材料'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `建筑材料`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '建筑装饰'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `建筑装饰`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '房地产'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `房地产`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '有色金属'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `有色金属`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '机械设备'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `机械设备`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '汽车'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `汽车`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '电子元器件'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `电子元器件`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '电气设备'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
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
					`tmp_zh_stocks_sw_sector_d`.`sector` = '纺织服装'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `纺织服装`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '综合'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `综合`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '计算机'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `计算机`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '轻工制造'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `轻工制造`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '通信'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `通信`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '采掘'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `采掘`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '钢铁'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `钢铁`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '银行'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
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
					`tmp_zh_stocks_sw_sector_d`.`sector` = '非银金融'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `非银金融`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '食品饮料'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `食品饮料`,
	round(
		sum(

			IF (
				(
					`tmp_zh_stocks_sw_sector_d`.`sector` = '餐饮旅游'
				),
				(
					`tmp_zh_stocks_sw_sector_d`.`above_rate` * 100
				),
				0
			)
		),
		0
	) AS `餐饮旅游`
FROM
	`tmp_zh_stocks_sw_sector_d`
GROUP BY
	`tmp_zh_stocks_sw_sector_d`.`date`
ORDER BY
	`tmp_zh_stocks_sw_sector_d`.`date` DESC