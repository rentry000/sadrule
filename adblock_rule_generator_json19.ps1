# Title: AdBlock_Rule_For_Sing-box
# Description: 适用于Sing-box的域名拦截规则集，每20分钟更新一次，确保即时同步上游减少误杀
# Homepage: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box
# LICENSE1: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-GPL 3.0
# LICENSE2: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-CC-BY-NC-SA 4.0
Import-Module ThreadJob

# 定义广告过滤器URL列表
$urlList = @(

#"https://www.bromite.org/filters/filters.dat",
#"https://raw.githubusercontent.com/Metrokoto/filterlists/refs/heads/main/combined_annoyances_without_element_hiding.txt",
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
"https://raw.githubusercontent.com/tn3w/IPSet/refs/heads/master/iplist.txt"


)


# 初始化线程安全的集合，用于存储所有 CIDR（PowerShell 7+ 支持）
$uniqueRules = [System.Collections.Concurrent.ConcurrentBag[object]]::new()

# 创建两个HashSet来存储唯一的规则和排除的域名
#$uniqueRules = [System.Collections.Generic.HashSet[string]]::new()
$global:excludedDomains = [System.Collections.Generic.HashSet[string]]::new()

$n = "1.12.12.12/13"
$uniqueRules.add($n)

if ($uniqueRules -ne $null) {
    $uniqueRules.ToString()
}
else {
    Write-Host "Variable is null, cannot call method."
}
# 创建临时目录

$chunkSize = 3000
# 函数1：拆分大文件为多个块

$scriptBlock2 = {
    param($url)

    Write-Host "IPv4: $url"
    try {
            # 获取原始文件名
            $response = Invoke-WebRequest -Uri $Url -Method Head
    
            # 方法1：从响应头获取文件名
            if ($response.Headers['Content-Disposition']) {
                $fileName = ($response.Headers['Content-Disposition'] -split 'filename=')[1].Trim('"')
            }
            # 方法2：从URL路径获取文件名
            else {
                $fileName = $Url.Split('/')[-1]
            }

            # 清理非法字符
            $fileName = $fileName -replace '[\\/:*?"<>|]', '_'
            # 临时工作目录
            $tempDir = "./cidr_$(Get-Date -Format yyyyMMddHH)"
            # 修改文件后缀名
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($fileName) + ".txt"
            # 检查路径是否存在
            if (-not (Test-Path $tempDir)) {
                # 自动创建路径（包括所有父目录）
                New-Item -Path $tempDir -ItemType Directory -Force | Out-Null
            }
            # 完整保存路径
            $fullPath = Join-Path $tempDir $fileName

            # 下载文件
            Invoke-WebRequest -Uri $Url -OutFile $fullPath
            
            Get-Content $fullPath -ReadCount 1000 | 
            ForEach-Object { $_ | Where { $_.Trim() -ne '' } } | 
            Add-Content $fullPath
            # 显示结果
            Write-Host "下载完成！" -ForegroundColor Green
            Write-Host "保存路径: $fullPath" 
        }
        catch {
            Write-Host "下载失败: $_" -ForegroundColor Red
        }
    try{
        # 读取并拆分内容为行$_.Trim() -notmatch '^#'
        # 创建WebClient对象用于下载规则
        # $webClient = New-Object System.Net.WebClient
        # $webClient.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
        # # 临时工作目录
        # $tempDir = "$env:TEMP\cidr_$(Get-Date -Format yyyyMMddHHmmss)"
        # $fileName = $Url.Split('/')[-1]
        # if($tempDir -eq $null){New-Item -ItemType Directory $tempDir | Out-Null}
        # $fullPath = Join-Path $tempDir $fileName
        # Write-Host "路径: $fullPath"
        # Invoke-WebRequest -Uri $Url -Method Head
        # $webClient.DownloadString($url, $fullPath)    
        # $reader = [System.IO.StreamReader]::new($fullPath) 
        $reader = [System.IO.File]::OpenText($fullPath)
            while (!$reader.EndOfStream) {
                $chunk = foreach ($i in 1..$chunkSize) {
                if ($reader.EndOfStream) { break}
                    $line = $reader.ReadLine().Trim()
                    ifif ($line -eq $null) { break }
                    if ($line -eq $null) { break }
                    $line.Trim()
                    # Write-Host $line
                }
                if (-not $chunk) { break }
                 
                
                $lines = $chunk
                # Write-Host "IPv6: $lines"
                #Write-Host "$lines"
                foreach ($line in $lines) {
                    if ($line -match '^\s*([0-9]{1,3}\.){3}[0-9]{1,3}\s*$' -and ($line.Trim() -notmatch '^#') -and ($line -notmatch '/')) {
                        # Write-Host "IPv4: $line"
                        $domain = $Matches[0] + "/" + "255"
                        # Write-Host "$domain"
                        ($using:uniqueRules).Add($domain) | Out-Null
                    }
                    # 处理IPv6
                
                    elseif ($line -match '\s*([0-9a-fA-F:]+)+\s*$' -and ($line.Trim() -notmatch '^#') -and ($line -notmatch '/') ) {
                        $domain = $Matches[0] + "/" + "255"
                        # Write-Host "IPv4: $line"
                        ($using:uniqueRules).Add($domain) | Out-Null
                    }
                    # 处理CIDR
                    elseif ($line -match '^\s*([0-9]{1,3}\.){3}[0-9]{1,3}/\d{1,3}\s*$' -and ($line.Trim() -notmatch '^#')) {
                        #Write-Host "IPv4cidr: $line"
                        $domain = $Matches[0] 
                        #Write-Host "$domain"
                        ($using:uniqueRules).Add($domain) | Out-Null
                    }
                    # 处理CIDR
                    elseif ($line -match '^\s*([0-9a-fA-F:]+)+/\d{1,3}\s*$' -and ($line.Trim() -notmatch '^#')) {
                
                        # Write-Host "IPv6cidr: $line"
                        $domain = $Matches[0]
                        ($using:uniqueRules).Add($domain) | Out-Null
                    }
            
                }
            }
    }
    catch {
        Write-Host "处理 $url 时出错: $_"
        #Add-Content -Path $using:logFilePath -Value "处理 $url 时出错: $_"
    }
    Start-Sleep -Seconds 1
}

$jobs2 = foreach ($url in $urlList) {
            Write-Host "开始执行"
            Start-ThreadJob -ScriptBlock $scriptBlock2 -ArgumentList $url
            Start-Sleep -Seconds 1
            
    

        # 等待所有线程任务执行完成
        
}
Wait-Job -Job $jobs2
        foreach ($job in $jobs2) {
            Receive-Job -Job $job
        }

    
# 在写入文件之前进行DNS规范验证
$validRules = [System.Collections.Generic.HashSet[string]]::new()
$validExcludedDomains = [System.Collections.Generic.HashSet[string]]::new()

foreach ($domain in ($uniqueRules)) {
    $validRules.Add($domain) | Out-Null
   
}

foreach ($domain in $excludedDomains) {
    if (Is-ValidDNSDomain($domain)) {
        $validExcludedDomains.Add($domain) | Out-Null
    }
}

# 排除所有白名单规则中的域名
$finalRules = $validRules | Where-Object { -not $validExcludedDomains.Contains($_) }

# 统计生成的规则条目数量
$ruleCount = $finalRules.Count

# 将域名按字母顺序排序
$sortedDomains = $finalRules | Sort-Object

# 将规则格式化为JSON格式
$jsonContent = @{
    version = 1  # 设置 version 为 1
    rules   = @(
        @{
            ip_cidr = $sortedDomains
        }
    )
}

# 转换为带紧凑缩进的JSON格式
$jsonFormatted = $jsonContent | ConvertTo-Json -Depth 10 | ForEach-Object { $_.Trim() }

# 定义输出文件路径
$outputPath = "$PSScriptRoot/adblock_reject19.json"
$jsonFormatted | Out-File -FilePath $outputPath -Encoding utf8

# 输出生成的有效规则总数
Write-Host "生成的有效规则总数: $ruleCount"
#Add-Content -Path $logFilePath -Value "Total entries: $ruleCount"

Pause
