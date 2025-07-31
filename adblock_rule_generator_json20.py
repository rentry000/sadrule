import requests
import json
import ipaddress
import concurrent.futures
import time

# --- 配置 ---
# 在这里添加您需要下载的远程规则文件 URL 列表
# 例如：
# URLS = [
#     "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset",
#     "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset",
#     "https://some/other/large_list.txt"
# ]
URLS = [
  "https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/anonymous.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_an.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_eu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_oc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ad.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ae.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ag.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ai.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_al.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_am.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ao.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_aq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ar.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_at.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_au.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_aw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ax.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_az.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ba.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_be.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_br.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_by.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_bz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ca.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ch.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ci.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ck.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_co.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_cz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_de.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_dj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_dk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_dm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_do.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_dz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ec.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ee.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_eg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_eh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_er.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_es.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_et.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_fi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_fj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_fk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_fm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_fo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_fr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ga.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ge.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_gy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_hk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_hm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_hn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_hr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ht.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_hu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_id.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ie.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_il.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_im.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_in.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_io.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_iq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ir.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_is.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_it.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_je.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_jm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_jo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_jp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ke.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_kg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_kh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ki.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_km.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_kn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_kp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_kr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_kw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ky.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_kz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_la.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_lb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_lc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_li.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_lk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_lr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ls.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_lt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_lu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_lv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ly.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ma.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_md.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_me.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ml.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ms.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_my.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_mz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_nc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ne.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_nf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ng.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ni.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_nl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_no.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_np.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_nr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_nu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_nz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_om.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pe.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ph.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ps.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_pw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_py.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_qa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_re.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ro.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_rs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ru.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_rw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_se.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_si.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_so.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ss.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_st.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_sz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_td.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_th.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_to.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_tz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ua.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ug.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_um.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_us.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_uy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_uz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_va.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_vc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ve.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_vg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_vi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_vn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_vu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_wf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ws.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_xk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_ye.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_yt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_za.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_zm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/country_zw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_continent_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_continent_aq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_continent_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_continent_eu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_continent_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_continent_oc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_continent_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ad.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ae.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ag.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ai.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_al.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_am.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ao.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_aq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ar.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_at.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_au.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_aw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ax.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_az.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ba.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_be.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_br.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_by.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_bz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ca.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ch.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ci.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ck.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_co.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_countryless.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_cz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_de.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_dj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_dk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_dm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_do.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_dz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ec.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ee.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_eg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_eh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_er.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_es.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_et.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_fi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_fj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_fk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_fm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_fo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_fr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ga.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ge.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_gy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_hk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_hm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_hn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_hr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ht.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_hu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_id.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ie.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_il.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_im.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_in.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_io.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_iq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ir.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_is.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_it.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_je.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_jm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_jo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_jp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ke.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_kg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_kh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ki.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_km.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_kn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_kp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_kr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_kw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ky.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_kz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_la.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_lb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_lc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_li.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_lk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_lr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ls.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_lt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_lu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_lv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ly.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ma.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_md.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_me.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ml.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ms.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_my.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_mz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_nc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ne.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_nf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ng.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ni.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_nl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_no.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_np.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_nr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_nu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_nz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_om.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pe.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ph.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ps.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_pw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_py.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_qa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_re.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ro.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_rs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ru.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_rw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_se.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_si.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sj.netset"
]

# 并发处理的线程数
MAX_WORKERS = 10
# 输出文件名
OUTPUT_FILENAME = "adblock_reject20.json"


def _convert_range_to_cidrs(line: str) -> list[str]:
    """
    [辅助函数] 解析 "IP起始-IP结束" 格式的行，不产生控制台输出。
    如果一行同时包含 ':' 和 '-'，则尝试此解析。
    """
    if ':' not in line or '-' not in line:
        return []

    try:
        range_part = line.rsplit(':', 1)[1]
        start_ip_str, end_ip_str = range_part.split('-')

        if '.' not in end_ip_str:
            base_ip = start_ip_str.rsplit('.', 1)[0]
            end_ip_str = f"{base_ip}.{end_ip_str}"

        start_ip = ipaddress.ip_address(start_ip_str)
        end_ip = ipaddress.ip_address(end_ip_str)

        if start_ip > end_ip:
            return []

        return [str(net) for net in ipaddress.summarize_address_range(start_ip, end_ip)]
    except (ValueError, IndexError):
        # 捕获所有可能的解析错误（格式错误、IP无效等）并静默失败
        return []


def process_line(line: str) -> list[str]:
    """
    处理单行文本，进行清洗、验证和格式化。
    现在可以处理标准 IP/CIDR 和 IP 范围格式。

    Args:
        line: 输入的原始行。

    Returns:
        一个包含一个或多个 CIDR 字符串的列表，如果该行无效则返回空列表。
    """
    cleaned_line = line.split('#', 1)[0].strip()

    # 1. 去掉注释和空行
    if not cleaned_line or cleaned_line.startswith('#'):
        return []

    # --- 策略 1: 尝试直接解析为 IP/CIDR ---
    try:
        ip_net = ipaddress.ip_network(cleaned_line, strict=False)
        return [ip_net.with_prefixlen]
    except ValueError:
        # --- 策略 2: 如果直接解析失败，则尝试作为 IP 范围解析 ---
        cidrs_from_range = _convert_range_to_cidrs(cleaned_line)
        if cidrs_from_range:
            return cidrs_from_range

    # 3. 如果所有策略都失败，则认为该行无效
    return []


def download_and_process_url(url: str) -> set[str]:
    """
    下载单个 URL 的内容，逐行处理，并返回一个包含所有有效 CIDR 的集合。
    """
    processed_cidrs = set()
    print(f"开始处理: {url}")
    try:
        with requests.get(url, stream=True, timeout=60) as r:
            r.raise_for_status()
            for line_bytes in r.iter_lines():
                line_str = line_bytes.decode('utf-8', errors='ignore')
                
                # process_line 现在返回一个列表
                processed_list = process_line(line_str)
                
                # 如果列表非空，使用 update 将所有元素添加到集合中
                if processed_list:
                    processed_cidrs.update(processed_list)

    except requests.RequestException as e:
        print(f"错误: 下载或处理 {url} 时失败: {e}")
        return set()

    print(f"处理完成: {url} | 发现 {len(processed_cidrs)} 个有效条目")
    return processed_cidrs


def create_singbox_ruleset(cidrs: list[str], output_file: str):
    """
    根据提供的 CIDR 列表生成 sing-box 规则集 JSON 文件。
    """
    print("\n正在生成最终的 sing-box 规则集...")
    rule_set = {
        "version": 1,
        "rules": [
            {
                "ip_cidr": cidrs
            }
        ]
    }
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(rule_set, f, ensure_ascii=False, indent=2)
    print(f"成功! 规则集已保存到: {output_file}")


def main():
    """主执行函数"""
    start_time = time.time()
    all_processed_cidrs = set()

    with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        future_to_url = {executor.submit(download_and_process_url, url): url for url in URLS}
        for future in concurrent.futures.as_completed(future_to_url):
            try:
                result_set = future.result()
                all_processed_cidrs.update(result_set)
            except Exception as exc:
                url = future_to_url[future]
                print(f"错误: URL {url} 的处理线程产生异常: {exc}")

    sorted_cidrs = sorted(list(all_processed_cidrs))
    print(f"\n所有文件处理完毕。共找到 {len(sorted_cidrs)} 个唯一的 IP/CIDR 条目。")

    create_singbox_ruleset(sorted_cidrs, OUTPUT_FILENAME)
    end_time = time.time()
    print(f"\n总耗时: {end_time - start_time:.2f} 秒。")


if __name__ == "__main__":
    main()

