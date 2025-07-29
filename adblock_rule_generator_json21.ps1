
# 安装 ThreadJob 模块（若未安装）
if (-not (Get-Module -ListAvailable -Name ThreadJob)) {
    Install-Module -Name ThreadJob -Force -Scope CurrentUser
}

# 定义远程文件路径（示例）
$remoteFiles = @(
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_so.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ss.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_st.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_sz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_td.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_th.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_to.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ua.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ug.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_um.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_us.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_uy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_uz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_va.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_vc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ve.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_vg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_vi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_vn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_vu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_wf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ws.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_ye.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_yt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_za.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_zm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_zw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_continent_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_continent_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_continent_eu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_continent_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_continent_oc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_continent_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ad.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ae.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ag.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ai.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_al.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_am.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ao.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ap.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_aq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ar.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_at.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_au.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_aw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ax.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_az.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ba.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_be.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_br.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_by.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_bz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ca.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ch.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ci.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ck.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_co.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_cz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_de.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_dj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_dk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_dm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_do.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_dz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ec.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ee.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_eg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_er.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_es.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_et.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_eu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_fi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_fj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_fk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_fm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_fo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_fr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ga.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ge.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_gy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_hk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_hn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_hr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ht.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_hu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_id.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ie.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_il.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_im.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_in.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_io.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_iq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ir.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_is.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_it.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_je.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_jm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_jo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_jp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ke.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_kg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_kh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ki.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_km.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_kn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_kp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_kr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_kw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ky.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_kz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_la.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_lb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_lc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_li.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_lk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_lr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ls.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_lt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_lu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_lv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ly.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ma.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_md.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_me.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ml.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ms.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_my.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_mz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_nc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ne.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_nf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ng.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ni.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_nl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_no.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_np.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_nr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_nu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_nz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_om.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pe.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ph.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ps.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_pw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_py.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_qa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_re.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ro.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_rs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ru.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_rw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_se.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_si.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_so.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ss.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_st.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_sz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_td.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_th.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_to.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_tz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ua.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ug.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_um.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_us.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_uy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_uz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_va.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_vc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ve.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_vg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_vi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_vn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_vu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_wf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ws.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_ye.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_yt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_za.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_zm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipdeny_country/id_country_zw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_continent_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_continent_aq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_continent_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_continent_eu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_continent_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_continent_oc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_continent_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ad.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ae.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_afrinic.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ag.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ai.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_al.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_am.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_anycast.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ao.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_apnic.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_aq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ar.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_arin.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_at.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_au.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_aw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ax.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_az.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ba.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_backbone.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_be.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_br.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_by.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_bz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ca.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ch.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ci.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ck.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_co.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_cz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_de.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_dj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_dk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_dm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_do.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_dz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ec.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ee.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_eg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_eh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_er.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_es.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_et.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_eu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_fi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_fj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_fk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_fm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_fo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_fr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ga.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ge.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_gy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_hk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_hm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_hn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_hr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ht.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_hu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_id.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ie.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_il.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_im.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_in.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_io.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_iq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ir.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_is.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_it.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_je.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_jm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_jo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_jp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ke.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_kg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_kh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ki.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_km.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_kn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_kp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_kr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_kw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ky.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_kz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_la.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lacnic.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_li.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ls.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_lv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ly.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ma.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_md.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_me.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ml.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mp.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ms.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mw.netset"


)

# 分块大小（单位：行）
$chunkSize = 1000



# 线程安全集合保存处理结果
$resultQueue = [System.Collections.Concurrent.ConcurrentQueue[object]]::new()

# 处理单个分块的函数
$processChunkScript = {
    param($url, $startLine, $endLine,$using:resultQueue)
    
    try {
        # 下载远程文件分块（模拟示例）
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content -split "`n"
        $chunkData = $content[$startLine..$endLine]

        # 模拟处理逻辑（例如解析路由规则）
        $processed = foreach ($line in $chunkData) {
             @($line.Trim())
        }

        # 将结果添加到线程安全队列
        ($using:resultQueue).Enqueue($processed)
    } catch {
        Write-Warning "处理分块失败：$url (行 $startLine-$endLine) - $_"
    }
}

# 启动多线程处理
$jobs = foreach ($file in $remoteFiles) {
    # 获取文件总行数（此处简化示例）
    $content = (Invoke-WebRequest -Uri $file -UseBasicParsing).Content -split "`n"
    $totalLines = $content.count  # 实际需动态获取
    Write-Host "文件总数: $totalLines"
    # 分块并提交线程任务
    for ($i = 0; $i -lt $totalLines; $i += $chunkSize) {
        $start = $i
        $end = [Math]::Min($i + $chunkSize - 1, $totalLines - 1)
        
        Start-ThreadJob -ScriptBlock $processChunkScript -ArgumentList $file, $start, $end,$resultQueue
    }
}

# 等待所有任务完成
$jobs | Wait-Job | Receive-Job -AutoRemoveJob -wait

# # 合并结果到 JSON 配置
# while ($resultQueue.TryDequeue([ref]$null)) {
#     $singBoxConfig.route.rules += $resultQueue.ToArray()
# }
# 最终生成的 JSON 结构（根据 sing-box 要求定制）
# 将规则格式化为JSON格式
# 排除所有白名单规则中的域名
$uniqueRules = [System.Collections.Generic.HashSet[string]]::new()
$array = $resultQueue.ToArray() -split " "
foreach ($line in $array) {
    #Write-Host "IPv4: $line"
                    if ($line -match '^\s*([0-9]{1,3}\.){3}[0-9]{1,3}\s*$' -and ($line.Trim() -notmatch '^#') -and ($line -notmatch '/')) {
                        # Write-Host "IPv4: $line"
                        $domain = $line + "/" + "32"
                        # Write-Host "$domain"
                        if ($domain.Contains(".") -and($domain.Length -ge 4) ){
                            $uniqueRules.Add($domain) | Out-Null
                        }
                        
                    }
                    # 处理IPv6
                
                    elseif ($line -match '\s*([0-9a-fA-F:]+)+\s*$' -and ($line.Trim() -notmatch '^#') -and ($line -notmatch '/') ) {
                        $domain = $line + "/" + "128"
                        if ($domain.Contains(".") -and($domain.Contains(":") )){
                            $uniqueRules.Add($domain) | Out-Null
                        }
                    }
                    # 处理CIDR
                    elseif ($line -match '^\s*([0-9]{1,3}\.){3}[0-9]{1,3}/\d{1,3}\s*$' -and ($line.Trim() -notmatch '^#')) {
                        #Write-Host "IPv4cidr: $line"
                        $domain = $Matches[0] 
                        #Write-Host "$domain"
                        $uniqueRules.Add($domain) | Out-Null
                    }
                    # 处理CIDR
                    elseif ($line -match '^\s*([0-9a-fA-F:]+)+/\d{1,3}\s*$' -and ($line.Trim() -notmatch '^#')) {
                
                        # Write-Host "IPv6cidr: $line"
                        $domain = $Matches[0]
                        $uniqueRules.Add($domain) | Out-Null
                    }
            
                }
$singBoxConfig = @{
    version = 1  # 设置 version 为 1
    rules   = @(
        @{
            ip_cidr = $uniqueRules
        }
    )
}

# 定义输出文件路径
$outputPath = "$PSScriptRoot/adblock_reject21.json"

# 转换为带紧凑缩进的JSON格式
$jsonFormatted = $singBoxConfig | ConvertTo-Json -Depth 10 | ForEach-Object { $_.Trim() }
$jsonFormatted | Out-File -FilePath $outputPath -Encoding utf8

Write-Host "生成成功：adblock_reject21.json" -ForegroundColor Green
# 统计生成的规则条目数量
$ruleCount = $uniqueRules.Count
Write-Host "生成的有效规则总数: $ruleCount"

pause