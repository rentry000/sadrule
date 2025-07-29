
# 安装 ThreadJob 模块（若未安装）
if (-not (Get-Module -ListAvailable -Name ThreadJob)) {
    Install-Module -Name ThreadJob -Force -Scope CurrentUser
}

# 定义远程文件路径（示例）
$remoteFiles = @(
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_my.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_mz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_nc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ne.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_nf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ng.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ni.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_nl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_no.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_np.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_nr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_nu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_nz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_om.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pe.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ph.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ps.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_pw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_py.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_qa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_re.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ro.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_rs.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ru.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_rw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sa.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sd.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_se.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sh.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_si.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_so.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ss.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_st.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sx.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_sz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_td.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_th.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tj.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tl.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_to.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tr.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tv.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_tz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ua.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ug.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_um.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_us.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_uy.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_uz.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_va.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_vc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ve.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_vg.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_vi.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_vn.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_vu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_wf.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ws.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_xk.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_ye.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_yt.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_za.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_zm.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ipip_country/ipip_country_zw.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/bds_atif.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/bitcoin_nodes.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/bitcoin_nodes_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/bitcoin_nodes_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/bitcoin_nodes_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_apache.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_bots.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_bruteforce.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_ftp.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_imap.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_mail.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_sip.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_ssh.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_de_strongips.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/blocklist_net_ua.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/botscout.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/botscout_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/botscout_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/botscout_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/botvrij_dst.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/botvrij_src.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/bruteforceblocker.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ciarmy.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cidr_report_bogons.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_new.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_new_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_new_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_new_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_top20.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_updated.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_updated_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_updated_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cleantalk_updated_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cta_cryptowall.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/cybercrime.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/darklist_de.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/dm_tor.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/dshield.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/dshield_1d.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/dshield_30d.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/dshield_7d.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/et_block.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/et_compromised.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/et_dshield.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/et_spamhaus.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/et_tor.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/feodo.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/feodo_badips.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_abusers_1d.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_abusers_30d.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_anonymous.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_level1.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_level2.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_level3.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_level4.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_proxies.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_webclient.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/firehol_webserver.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/gpf_comics.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/graphiclineweb.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/greensnow.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_abuse_palevo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_abuse_spyeye.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_abuse_zeus.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_ciarmy_malicious.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_cidr_report_bogons.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_cruzit_web_attacks.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_aol.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_att.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_cablevision.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_charter.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_comcast.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_embarq.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_qwest.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_sprint.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_suddenlink.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_twc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_isp_verizon.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_malc0de.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_onion_router.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_activision.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_apple.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_blizzard.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_crowd_control.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_electronic_arts.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_joost.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_linden_lab.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_logmein.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_ncsoft.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_nintendo.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_pandora.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_pirate_bay.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_punkbuster.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_riot_games.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_sony_online.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_square_enix.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_steam.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_ubisoft.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_org_xfire.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_pedophiles.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_spamhaus_drop.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/iblocklist_yoyo_adservers.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/myip.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_commenters.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_commenters_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_commenters_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_commenters_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_dictionary.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_dictionary_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_dictionary_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_dictionary_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_harvesters.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_harvesters_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_harvesters_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_harvesters_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_spammers.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_spammers_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_spammers_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/php_spammers_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/sblam.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/set_file_timestamps.sh",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/socks_proxy.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/socks_proxy_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/socks_proxy_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/socks_proxy_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/spamhaus_drop.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/spamhaus_edrop.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/sslproxies.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/sslproxies_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/sslproxies_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/sslproxies_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam_180d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam_365d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam_90d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/stopforumspam_toxic.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/tor_exits.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/tor_exits_1d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/tor_exits_30d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/tor_exits_7d.ipset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/vxvault.ipset",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/afr.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/anz.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/asa.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/eur.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/nam.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/r_eur.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/r_neu.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/r_seu.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/sam.txt"

)

# 分块大小（单位：行）
$chunkSize = 5000



# 线程安全集合保存处理结果
$resultQueue = [System.Collections.Concurrent.ConcurrentQueue[object]]::new()

# 处理单个分块的函数
$processChunkScript = {
    param($url, $startLine, $endLine)
    
    try {
        # 下载远程文件分块（模拟示例）
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content -split "`n"
        $chunkData = $content[$startLine..$endLine]

        # 模拟处理逻辑（例如解析路由规则）
        $processed = $chunkData | Foreach-Object -ThrottleLimit 5 -Parallel {
            @($_.Trim())
        }
        # $processed = foreach ($line in $chunkData){
        #      @($line.Trim())
        # }

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
        
        Start-ThreadJob -ScriptBlock $processChunkScript -ArgumentList $file, $start, $end
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
for ($i = 0; $i -lt $array.Count; $i++) {
   # Write-Host "IPv4: $line"
                    if ($array[$i] -match '^\s*([0-9]{1,3}\.){3}[0-9]{1,3}\s*$' -and ($array[$i].Trim() -notmatch '^#') -and ($array[$i] -notmatch '/')) {
                        # Write-Host "IPv4: $line"
                        $domain = $array[$i] + "/" + "32"
                        # Write-Host "$domain"
                        if ($domain.Contains(".") -and($domain.Length -ge 4) ){
                            $uniqueRules.Add($domain) | Out-Null
                        }
                        
                    }
                    # 处理IPv6
                
                    elseif ($array[$i] -match '\s*([0-9a-fA-F:]+)+\s*$' -and ($array[$i].Trim() -notmatch '^#') -and ($array[$i] -notmatch '/') ) {
                        $domain = $array[$i] + "/" + "128"
                        if ($domain.Contains(".") -and($domain.Contains(":") )){
                            $uniqueRules.Add($domain) | Out-Null
                        }
                    }
                    # 处理CIDR
                    elseif ($array[$i] -match '^\s*([0-9]{1,3}\.){3}[0-9]{1,3}/\d{1,3}\s*$' -and ($array[$i].Trim() -notmatch '^#')) {
                        #Write-Host "IPv4cidr: $array[$i]"
                        $domain = $Matches[0] 
                        #Write-Host "$domain"
                        $uniqueRules.Add($domain) | Out-Null
                    }
                    # 处理CIDR
                    elseif ($array[$i] -match '^\s*([0-9a-fA-F:]+)+/\d{1,3}\s*$' -and ($array[$i].Trim() -notmatch '^#')) {
                
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
$outputPath = "$PSScriptRoot/adblock_reject20.json"

# 转换为带紧凑缩进的JSON格式
$jsonFormatted = $singBoxConfig | ConvertTo-Json -Depth 10 | ForEach-Object { $_.Trim() }
$jsonFormatted | Out-File -FilePath $outputPath -Encoding utf8

Write-Host "生成成功：adblock_reject20.json" -ForegroundColor Green
# 统计生成的规则条目数量
$ruleCount = $uniqueRules.Count
Write-Host "生成的有效规则总数: $ruleCount"

pause