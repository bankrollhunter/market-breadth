
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for zh_stocks_d
-- ----------------------------
DROP TABLE IF EXISTS `zh_stocks_d`;
CREATE TABLE `zh_stocks_d` (
  `date` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日期',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `industry` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '行业',
  `sw_ind1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '申万一级行业',
  `sw_ind1_weight` decimal(20,3) DEFAULT NULL COMMENT '申万一级行业权重',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地区',
  `market` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市场',
  `open` decimal(20,3) DEFAULT NULL COMMENT '开盘价',
  `high` decimal(20,3) DEFAULT NULL COMMENT '最高价',
  `low` decimal(20,3) DEFAULT NULL COMMENT '最低价',
  `close` decimal(20,3) DEFAULT NULL COMMENT '收盘价',
  `pre_close` decimal(20,3) DEFAULT NULL COMMENT '前一天收盘价',
  `is_gap` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否有缺口',
  `vol` bigint DEFAULT NULL COMMENT '成交量',
  `ma_vol` bigint DEFAULT NULL COMMENT '月均成交量',
  `vol_rate` decimal(20,3) DEFAULT NULL COMMENT '成交量/月均量',
  `amount` bigint DEFAULT NULL COMMENT '成交额',
  `ma_amt` bigint DEFAULT NULL COMMENT '月（）均成交额',
  `amt_rate` decimal(20,3) DEFAULT NULL COMMENT '成交额/月均额',
  `s_ma` decimal(20,3) DEFAULT NULL COMMENT 'MA20',
  `m_ma` decimal(20,3) DEFAULT NULL COMMENT 'MA60',
  `l_ma` decimal(20,3) DEFAULT NULL COMMENT 'MA120',
  `s_ema` decimal(20,3) DEFAULT NULL COMMENT 'EMA20',
  `m_ema` decimal(20,3) DEFAULT NULL COMMENT 'EMA60',
  `l_ema` decimal(20,3) DEFAULT NULL COMMENT 'EMA120',
  `cs` decimal(20,3) DEFAULT NULL COMMENT 'C/S',
  `pcs` decimal(20,3) DEFAULT NULL COMMENT '前一日 C/S',
  `is_cs_over` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否破线（上穿）',
  `sm` decimal(20,3) DEFAULT NULL COMMENT 'S/M',
  `psm` decimal(20,3) DEFAULT NULL COMMENT '前一日 S/M',
  `is_sm_over` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否交叉(MA20上穿MA60)',
  `ml` decimal(20,3) DEFAULT NULL COMMENT 'M/L',
  `pml` decimal(20,3) DEFAULT NULL COMMENT '前一日 M/L',
  `is_ml_over` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否交叉(MA60上穿MA120)',
  `bais` decimal(20,3) DEFAULT NULL COMMENT 'C/S+S/M+M/L',
  `ecs` decimal(20,3) DEFAULT NULL COMMENT 'EMA C/S',
  `esm` decimal(20,3) DEFAULT NULL COMMENT 'EMA S/M',
  `pesm` decimal(20,3) DEFAULT NULL COMMENT '前一日 EMA S/M',
  `is_esm_over` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否交叉(EMA20上穿EMA60)',
  `eml` decimal(20,3) DEFAULT NULL COMMENT 'EMA M/L',
  `peml` decimal(20,3) DEFAULT NULL COMMENT '前一日 EMA M/L',
  `is_eml_over` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否交叉(EMA60上穿EMA120)',
  `ebais` decimal(20,3) DEFAULT NULL COMMENT 'EMA C/S+S/M+M/L',
  `s_close` decimal(20,3) DEFAULT NULL COMMENT 'MA20 抵扣价 ',
  `s_pre_close` decimal(20,3) DEFAULT NULL COMMENT 'MA21 抵扣价 ',
  `is_s_up` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'MA20 是否向上拐头',
  `m_close` decimal(20,3) DEFAULT NULL COMMENT 'MA60 抵扣价 ',
  `m_pre_close` decimal(20,3) DEFAULT NULL COMMENT 'MA61 抵扣价 ',
  `is_m_up` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'MA60 是否向上拐头',
  `l_close` decimal(20,3) DEFAULT NULL COMMENT 'MA120 抵扣价 ',
  `l_pre_close` decimal(20,3) DEFAULT NULL COMMENT 'MA121 抵扣价 ',
  `is_l_up` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'MA120 是否向上拐头',
  PRIMARY KEY (`date`,`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;
