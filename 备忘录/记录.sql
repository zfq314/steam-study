1、 cx_zt_dxbb2_sz 查询(短信报表(钱)) 	success 

2、 cx_sz_cpbcx_hpl 查询(产品包查询含品类)
	销售单子表缺少，一级品类和二级品类的名称 涉及到客户编码的信息 where JSKHBM=v_khbm  结算客户编码 success 

3、 cx_sz_xsdcx_fjgf_new 查询(产品包查询含品类) -- 不改
	新展厅系统 没有TYKHGJB 统一客户归集表 

4、 cx_ztxsfjgfcx_5g 查询(折扣附加工费查询) -- 不改

5、 cx_szzt_xslb 深圳展厅销售列表新（对应操作销售列表新）-- 不改

6、 cx_ztsz_lldfx 来料单分析 -- 改了一部分


7、 一些急用的存储过程
	cx_sz_cpbcx_hpl --已经改好
	cx_sz_xsdcx_fjgf_new -- 改了部分
	cx_zt_dxbb2_sz -- 已经改好
	cx_zt_xsrbb_sz_cw2 -- 3000多行最后改 
	cx_zt_ztkcsfc_sz_new -- 300多行 还没改
	
cx_sz_cpbcx_hpl Ok
cx_sz_xsdcx_fjgf_new ok
cx_zt_dxbb2_sz Ok 
cx_zt_ztkcsfc_sz_new ok
cx_zt_xsrbb_sz_kh4
cx_zt_xsrbb_sz_cw2 ok



	SELECT
	H.wdbm AS wdbm, -- 网点编码
	H.wdmc AS wdmc, -- 网点名称
	H.gsbm AS gsbm, --公司编码
	H.gsmc AS gsmc, -- 公司名称
	B.ckbm AS ckbm, --仓库编码
	B.ckmc AS ckmc, -- 仓库名称 
	B.cklx AS cklx, -- 仓库类型
	B.CKDM AS ckdm, -- 仓库代码
	H.kdwddm AS kdwddm, --客单网点代码
	H.gdwddm AS gdwddm  -- 柜台网点代码
FROM
	wdmlH H
	INNER JOIN wdmlB  B ON H.DjLsh= B.DjLsh

	视图 





 {
    "job": {
        "content": [
            {
                "reader": {
                    "name": "sqlserverreader", 
                    "parameter": {
                        "connection": [
                            {
                                "jdbcUrl": ["jdbc:sqlserver://10.10.80.38:1433;DatabaseName=ztdata_sync1"],
                               "table": ["zjyezh"]
                            }
                        ], 
                        "password": "Decent123", 
                        "username": "sa",
                        "column":["*"]
                    }
                }, 
                "writer": {
                    "name": "mysqlwriter", 
                    "parameter": {
                        "column": ["*"], 
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://hadoop33:3306/lxrj_test?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai", 
                                "table": ["zjyezh_eos"]
                            }
                        ], 
                        "password": "hadoopdb-hadooponeoneone@dc.com.", 
                        "preSql": [], 
                        "session": [], 
                        "username": "root", 
                        "writeMode": "replace"
                    }
                }
            }
        ], 
        "setting": {
            "speed": {
                "channel": "1"
            }
        }
    }
}



  {
    "job": {
        "content": [
            {
                "reader": {
                    "name": "sqlserverreader", 
                    "parameter": {
                        "connection": [
                            {
                            "querySql": [
                                    "select 	KCZT,
	KDZT,
	SPTM,
	ZSHM,
	GIAZS,
	WDMC,
	CKMC,
	GYSBM,
	GYS,
	PPMC,
	DLMC,
	JSMC,
	PLMC,
	GCKH,
	GSKH,
	GG,
	SPMC,
	SPLX,
	XLMC,
	JZ,
	HZ,
	JGF,
	XSGF,
	SXF,
	ZSYS,
	ZSJD,
	ZSQG,
	ZSSL,
	ZSZL,
	FSMC,
	FSSL,
	FSZL,
	JS,
	SJCB,
	SCCB,
	BZJG,
	BQJG,
	DW,
	CASE WHEN ifnull ( khh, '否' ) = '是' THEN 1 ELSE 0 END KHH,
	CASE WHEN ifnull ( ykj, '否' ) = '是' THEN 1 ELSE 0 END YKJ,
	CASE WHEN ifnull ( JP, '否' ) = '是' THEN 1 ELSE 0 END JP,
	GFLX,
	PJSM,
	CFHH,
	BZ,
	RKRQ,
	RKDH,
	RKDM,
	GXRQ,
	GXDH,
	PDZT,
	PDDH,
	LSDH,
	LSRQ,
	XSDJ,
	SJZK,
	ML,
	MJJ,
	LSJE,
	JSDH,
	JSRQ,
	JSJE,
	KHMC,
	ZSMC,
	CXM,
	EWM,
	EWMX,
	LBDM,
	ZSCB,
	FSCB,
	WXFY,
	BZCB,
	ZSGG,
	WXDM  from mxzh where kczt='库存';"
                                ],
                                "jdbcUrl": ["jdbc:sqlserver://10.10.80.38:1433;DatabaseName=ztdata_sync1"],
                            }
                        ], 
                        "password": "Decent123", 
                        "username": "sa",
                    }
                }, 
                "writer": {
                    "name": "mysqlwriter", 
                    "parameter": {
                      "column": ["KCZT",
"KDZT",
"SPTM",
"ZSHM",
"GIAZS",
"WDMC",
"CKMC",
"GYSBM",
"GYS",
"PPMC",
"DLMC",
"JSMC",
"PLMC",
"GCKH",
"GSKH",
"GG",
"SPMC",
"SPLX",
"XLMC",
"JZ",
"HZ",
"JGF",
"XSGF",
"SXF",
"ZSYS",
"ZSJD",
"ZSQG",
"ZSSL",
"ZSZL",
"FSMC",
"FSSL",
"FSZL",
"JS",
"SJCB",
"SCCB",
"BZJG",
"BQJG",
"DW",
"KHH",
"YKJ",
"JP",
"GFLX",
"PJSM",
"CFHH",
"BZ",
"RKRQ",
"RKDH",
"RKDM",
"GXRQ",
"GXDH",
"PDZT",
"PDDH",
"LSDH",
"LSRQ",
"XSDJ",
"SJZK",
"ML",
"MJJ",
"LSJE",
"JSDH",
"JSRQ",
"JSJE",
"KHMC",
"ZSMC",
"CXM",
"EWM",
"EWMX",
"LBDM",
"ZSCB",
"FSCB",
"WXFY",
"BZCB",
"ZSGG",
"WXDM"], 
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://hadoop33:3306/lxrj_test?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai", 
                                "table": ["T_KA_MXZ"]
                            }
                        ], 
                        "password": "hadoopdb-hadooponeoneone@dc.com.", 
                        "preSql": [], 
                        "session": [], 
                        "username": "root", 
                        "writeMode": "replace"
                    }
                }
            }
        ], 
        "setting": {
            "speed": {
                "channel": "1"
            }
        }
    }
}


khbm , 客户编码 h
khmc , 客户名称 h
khbh , 客户编号 b
zkhbm , 子客户编码
zkhmc , 子客服名称
sjxqmc , 省级辖区名称 h
djsxx ,  地级市信息 h
sxqxx ,  市县区信息 h
qy='客户信息不存在或客户已禁用' 默认区域




Select 
KHXXSZH.KHKH as KHKH,
KHXXSZH.qy as qy,
KHXXSZH.kmbm as kmbm,
(case when ifnull(SYZKH,0)='1' then KHXXSZH.khbm+ifnull(cast(KHXXSZB.xh AS varchar(20)),'') else KHXXSZH.khbm end ) as khbm,
KHXXSZH.khmc as khmc,
KHXXSZH.khjc as khjc,
KHXXSZH.khyh as khyh,
KHXXSZH.yhzh as yhzh,
KHXXSZH.sh as sh,
KHXXSZH.dwdz as dwdz,
KHXXSZH.dwdh as dwdh,
KHXXSZH.cz as cz,
KHXXSZH.gszy as gszy,
KHXXSZH.zjm as zjm,
KHXXSZH.fr as fr,
KHXXSZH.frsfzh as frsfzh,
KHXXSZH.sjhm1 as frsjh ,
KHXXSZH.zw as zw,
KHXXSZH.sjhm as sjhm,
KHXXSZH.bgdh as bgdh,
KHXXSZH.dzyj as dzyj,
KHXXSZH.lrrid as lrrid,
KHXXSZH.lrrxm as lrrxm,
KHXXSZH.lrsj as lrsj,
KHXXSZH.zhwhr as zhwhr,
KHXXSZH.zhwhsj as zhwhsj,
KHXXSZH.zxhjsxs as zxhjsxs,
KHXXSZH.zxhxsxs as zxhxsxs,
KHXXSZH.xydj as xydj,
KHXXSZH.xyed as xyed,
KHXXSZH.xysm as xysm,
KHXXSZH.fkqx as fkqx,
KHXXSZH.jjqx as jjqx,
KHXXSZH.jszk as jszk,
KHXXSZH.wdmc as wdmc,
KHXXSZH.gsmc as gsmc,
KHXXSZH.sjxqbm as sjxqbm, 
sjxqmc = CASE WHEN ifnull(SYZKH,0)='1' THEN SSSF  ELSE  SJXQMC  END ,
djsbm = CASE WHEN ifnull(SYZKH,0)='1' THEN '' ELSE KHXXSZH.djsbm  END ,
djsxx = CASE WHEN ifnull(SYZKH,0)='1' THEN KHXXSZB.djsxxb ELSE KHXXSZH.djsxx  END ,
sxqbm = CASE WHEN ifnull(SYZKH,0)='1' THEN '' ELSE KHXXSZH.sxqbm  END ,
sxqxx = CASE WHEN ifnull(SYZKH,0)='1' THEN KHXXSZB.sxjxxb ELSE KHXXSZH.sxqxx  END ,
KHXXSZH.bz as bz,
KHXXSZH.pqbm as pqbm,
KHXXSZH.pqmc as pqmc,
KHXXSZH.gfyh as gfyh,
KHXXSZH.kh as kh,
KHXXSZH.gys as gys,
KHXXSZH.rll as rll,
KHXXSZH.ywy as ywy,
KHXXSZH.lxhm as lxhm,
(case when ifnull(SYZKH,0)='1' then ifnull(khxxszb.lxdz,'') else KHXXSZH.XXDZ end) as XXDZ,
(case when ifnull(SYZKH,0)='1' then ifnull(KHXXSZb.lxdh,'') else KHXXSZH.DHHM end ) as DHHM,
KHXXSZH.SYZKH as syzkh,
KHXXSZH.csmc as csmc,
KHXXSZB.xh as zkhbm,
khwd as zkhmc,
zjme as zkhzjm,
(case when ifnull(SYZKH,0)='1' then ifnull(KHXXSZb.LXDHB,'') else KHXXSZH.DHHM end ) as DHHMB,
CSKHLX,
WYID,
dpzzqc,
ifnull(khxxszb.khbh,'') as khbh,YYZZHM,
YYFW ,
lxrh cylxr
from  KHXXSZH left join KHXXSZB  on KHXXSZH.DjLsh =KHXXSZB.DjLsh and syzkh=1
  where  ifnull(SFQY,'Y')='Y' and  ifnull(QY,'Y')='Y'

  mvn clean install -DskipTests



   select $temp2.jskh as jskh,$temp2.ZKH as zkh,$temp2.dshj as dshj,$temp2.jzhj as jzhj,$temp2.jehj as zjehj,
 $temp1.hpcs as hpcs,$temp1.csmch as csmch,$temp1.plmch as plmch,$temp1.djh as djh,
 $temp1.bzh as bzh,$temp1.jshj as jshj,$temp1.ckjzhj as ckjzhj,$temp1.jehj as jehj,$temp1.fjgfhj as fjgfhj,
 $temp1.fyhj as fyhj,$temp1.jjjz as jjjz,$temp1.jjje as jjje,$temp1.lljzhj as lljzhj,
 $temp1.llgfhj as llgfhj,$temp1.zqjzhj as zqjzhj,$temp1.zqlgfje as zqlgfje,$temp1.khlljz as khlljz,
 $temp1.khllje as khllje,$temp1.tsjzhj as tsjzhj,$temp1.khtsgfje as khtsgfje
 from $temp2 
 left join $temp1 on $temp2.JSKHBM=$temp1.jskhbm and $temp2.JSKH=$temp1.jskh and ifnull($temp2.ZKH,'')ifnull($temp1.zkh,'')
order by $temp1.jskhbm,$temp1.hpcs




 select '合计' as jskh,'' as ZKH,COUNT(*) as dshj,ifnull(SUM(ckjzhj),0) as jzhj,ifnull(SUM(jehj),0) as zjehj,
 '' as hpcs,'' as csmch,'' as plmch,'' as djh,
 '' as bzh,ifnull(sum(jshj),0) as jshj,ifnull(SUM(ckjzhj),0) as ckjzhj,ifnull(SUM(jehj),0) as jehj,ifnull(SUM(fjgfhj),0) as fjgfhj,
 ifnull(SUM(fyhj),0) as fyhj,ifnull(SUM(jjjz),0) as jjjz,ifnull(SUM(jjje),0) as jjje,ifnull(SUM(lljzhj),0) as lljzhj,
 ifnull(SUM(llgfhj),0) as llgfhj,ifnull(SUM(zqjzhj),0) as zqjzhj,ifnull(SUM(zqlgfje),0) as zqlgfje,ifnull(SUM(khlljz),0) as khlljz,
 ifnull(SUM(khllje),0) as khllje,ifnull(SUM(tsjzhj),0) as tsjzhj,ifnull(SUM(khtsgfje),0) as khtsgfje
 from $temp1 


error:1271 Illegal mix of collations for operation 'UNION'
解决：查看union相关的表的 字符类型和长度是否匹配，调成一致就可以了
查看表的具体信息
 -- DESCRIBE $temp3;
 -- DESCRIBE $temp4;