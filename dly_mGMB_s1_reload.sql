INSERT INTO p_csi_tbs_t.fl_dly_mGMBforecast_s1

SELECT     			
		co.created_dt as created_dt,
		
		CASE	WHEN apps.app_id IS NULL AND sess_cobrand IN 7 THEN 'FSoM'		
					WHEN apps.app_id IS  NULL THEN 'Core Site on PC'
					WHEN TRIM(apps.prdct_name) IN 'IPhoneApp' THEN 'iPhone App'
					WHEN TRIM(apps.prdct_name) IN ('Android','Android Motors') THEN 'AndroidApp'
					WHEN TRIM(apps.prdct_name) IN 'IPad' THEN 'iPad App'
					WHEN TRIM(apps.prdct_name) IN ('MobWeb','MobWebGXO') THEN 'Mobile Web'
					ELSE 'Other Mobile'
		END platform,					
				
		CASE	WHEN buyer_country_id IN  (1, -1, 0, -999, 225, 679, 1000) THEN 'US'		
					WHEN buyer_country_id IN 3 THEN 'UK'
					WHEN buyer_country_id IN 77 THEN 'DE'
					WHEN buyer_country_id IN 15 THEN 'AU'
					WHEN buyer_country_id IN 2 THEN 'CA'
					ELSE 'Other'
		END country,			
	
		SUM(CAST(co.item_price * co.quantity * CAST(cr.CURNCY_PLAN_RATE AS FLOAT) AS DECIMAL(18,2))) AS gmb_plan			
		
FROM 					
		(
		SELECT *
		FROM p_soj_cl_v.checkout_metric_item xo
		WHERE 
		created_dt between :start_dt and :end_dt
		AND ck_wacko_yn = 'n'
		AND auct_end_dt >= :start_dt
		AND auct_type_code NOT IN (12,15)			
		) co			
		INNER JOIN dw_category_groupings ctg ON(co.item_site_id = ctg.site_id AND co.leaf_categ_id = ctg.leaf_categ_id )			
 		INNER JOIN SSA_CURNCY_PLAN_RATE_DIM cr ON co.LSTG_CURNCY_ID  = CR.CURNCY_ID			
 		INNER JOIN dw_cal_dt cal ON co.created_dt=cal.cal_dt
		LEFT JOIN dw_api_mbl_app apps ON co.app_id=apps.app_id			
		
WHERE  ctg.sap_category_id NOT IN (23,5,7,41) 
		
GROUP BY					
		1,2,3;