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
       "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset",
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset",
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level3.netset",
"https://github.com/bitwire-it/ipblocklist/raw/refs/heads/main/ip-list.txt",
"https://github.com/TimmiORG/ip-blacklist/raw/refs/heads/main/all.list.use",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_africa.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_antartica.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_asia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_north_america.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_oceania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_south_america.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_afghanistan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_aland_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_albania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_algeria.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_american_samoa.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_andorra.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_angola.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_anguilla.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_antarctica.ipset",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/main/lists/all-safe-ips.txt",
"https://github.com/stamparm/ipsum/raw/refs/heads/master/ipsum.txt",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_africa.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_antartica.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_asia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_europe.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_north_america.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_oceania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/continent_south_america.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_afghanistan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_aland_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_albania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_algeria.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_american_samoa.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_andorra.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_angola.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_anguilla.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_antarctica.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_antigua_barbuda.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_argentina.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_armenia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_aruba.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_australia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_austria.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_azerbaijan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bahamas.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bahrain.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bangladesh.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_barbados.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_belarus.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_belgium.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_belize.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_benin.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bermuda.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bhutan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bolivia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bonaire_sint_eustatius_saba.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bosnia_herzegovina.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_botswana.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bouvet_island.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_brazil.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_british_indian_ocean_territory.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_british_virgin_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_brunei_darussalam.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_bulgaria.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_burkina_faso.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_burundi.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cambodia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cameroon.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_canada.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cape_verde.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cayman_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cc.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_central_african_republic.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_chad.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_chile.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_china.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_christmas_island.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_colombia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_comoros.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_congo.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cook_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_costa_rica.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cote_divoire.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_croatia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cuba.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_curacao.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_cyprus.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_czech_republic.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_democratic_republic_congo.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_denmark.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_djibouti.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_dominica.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_dominican_republic.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_ecuador.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_egypt.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_el_salvador.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_equatorial_guinea.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_eritrea.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_estonia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_eswatini.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_ethiopia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_europe.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_falkland_islands_malvinas.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_faroe_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_fiji.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_finland.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_france.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_french_guiana.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_french_polynesia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_french_southern_territories.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_gabon.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_gambia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_georgia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_germany.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_ghana.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_gibraltar.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_great_britain.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_greece.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_greenland.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_grenada.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_guadeloupe.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_guam.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_guatemala.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_guernsey.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_guinea.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_guineabissau.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_guyana.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_haiti.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_heard_island_and_mcdonald_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_honduras.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_hong_kong.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_hungary.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_iceland.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_india.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_indonesia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_iran.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_iraq.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_ireland.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_isle_of_man.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_israel.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_italy.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_jamaica.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_japan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_jersey.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_jordan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_kazakhstan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_kenya.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_kiribati.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_kosovo.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_kuwait.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_kyrgyzstan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_laos.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_latvia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_lebanon.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_lesotho.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_liberia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_libya.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_liechtenstein.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_lithuania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_luxembourg.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_macao.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_macedonia_republic.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_madagascar.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_malawi.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_malaysia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_maldives.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_mali.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_malta.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_marshall_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_martinique.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_mauritania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_mauritius.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_mayotte.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_mexico.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_micronesia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_monaco.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_mongolia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_montenegro.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_montserrat.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_morocco.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_mozambique.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_myanmar.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_namibia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_nauru.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_nepal.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_netherlands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_new_caledonia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_new_zealand.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_nicaragua.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_niger.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_nigeria.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_niue.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_norfolk_island.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_north_korea.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_northern_mariana_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_norway.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_oman.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_pakistan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_palau.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_palestine.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_panama.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_papua_new_guinea.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_paraguay.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_peru.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_philippines.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_pitcairn.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_poland.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_portugal.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_puerto_rico.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_qatar.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_republic_moldova.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_reunion.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_romania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_russia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_rwanda.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saint_barthelemy.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saint_helena.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saint_kitts_nevis.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saint_lucia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saint_martin_north.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saint_pierre_miquelon.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saint_vincent_grenadines.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_samoa.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_san_marino.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_sao_tome_principe.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_saudi_arabia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_senegal.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_serbia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_seychelles.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_sierra_leone.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_singapore.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_sint_maarten_south.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_slovakia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_slovenia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_solomon_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_somalia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_south_africa.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_south_georgia_and_the_south_sandwich_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_south_korea.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_south_sudan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_spain.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_sri_lanka.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_sudan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_suriname.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_svalbard_jan_mayen.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_sweden.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_switzerland.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_syria.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_taiwan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_tajikistan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_tanzania.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_thailand.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_timorleste.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_togo.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_tokelau.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_tonga.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_trinidad_tobago.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_tunisia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_turkey.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_turkmenistan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_turks_caicos_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_tuvalu.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_uganda.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_ukraine.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_united_arab_emirates.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_united_states.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_united_states_minor_outlying_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_united_states_virgin_islands.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_uruguay.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_uzbekistan.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_vanuatu.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_vatican_city_holy_see.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_venezuela.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_vietnam.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_wallis_futuna.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_western_sahara.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_yemen.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_zambia.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/country/geolite/country_zimbabwe.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_aol.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_att.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_cablevision.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_charter_spectrum_timewarnercable.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_comcast.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_cox_communications.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_embarq.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_frontier_communications.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_qwest.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_spacex_starlink.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_sprint.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_suddenlink_altice_optimum.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/isp/isp_verizon.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_activision.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_ahrefs.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_amazon_aws.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_amazon_ec2.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_applebot.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_bing.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_blizzard.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_bunnycdn.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_cloudflarecdn.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_cloudfront.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_duckduckgo.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_electronicarts_ign.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_facebook.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_fastly.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_general.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_google.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_nintendo.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_pandora.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_pingdom.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_piratebay.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_punkbuster.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_riot_games.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_rssapi.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_sony.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_steam.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_stripe_api.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_stripe_armada_gator.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_stripe_webhooks.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_telegram.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_ubisoft.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_uptimerobot.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_webpagetest.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/privacy/privacy_xfire.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/spam/spam_forums.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/spam/spam_spamhaus.ipset",
"https://github.com/Aetherinox/blocklists/raw/refs/heads/main/blocklists/transmission/blocklist.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/highrisk.ipset",
"https://raw.githubusercontent.com/Aetherinox/blocklists/refs/heads/main/blocklists/master.ipset",
"https://github.com/borestad/blocklist-abuseipdb/raw/refs/heads/main/abuseipdb-s100-all.ipv4",
"https://github.com/ashleykleynhans/ipset/raw/refs/heads/main/ipv4.csv",
"https://raw.githubusercontent.com/tn3w/IPSet/refs/heads/master/iplist.txt",
"https://raw.githubusercontent.com/Sopils/myipset/refs/heads/main/output/sam.txt"
]
# 并发处理的线程数
MAX_WORKERS = 10
# 输出文件名
OUTPUT_FILENAME = "adblock_reject19.json"


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

