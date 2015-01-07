drop table p_csi_tbs_t.fl_mobileFcst

create table p_csi_tbs_t.fl_mobileFcst (
trans_dt date format 'yyyy-mm-dd'
 , country varchar(64),
 , platform varchar(64),
 , gmb decimal(18,2)
, model_dt date format 'yyyy-mm-dd'
) primary index (trans_dt, country, platform, model_dt);