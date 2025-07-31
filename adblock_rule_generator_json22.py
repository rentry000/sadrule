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
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/r_seu.txt"
]

# 并发处理的线程数
MAX_WORKERS = 10
# 输出文件名
OUTPUT_FILENAME = "adblock_reject.json"


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

