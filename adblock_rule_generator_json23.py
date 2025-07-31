import requests
import json
import ipaddress
import concurrent.futures
import time

# --- 配置 ---
# 在这里添加您需要下载的远程规则文件 URL 列表
# 例如，可以混合包含不同格式列表的源
URLS = [
    "https://github.com/bitwire-it/ipblocklist/raw/refs/heads/main/inbound.txt",
"https://github.com/bitwire-it/ipblocklist/raw/refs/heads/main/outbound.txt",
"https://github.com/knarfd/ipblocker/raw/refs/heads/main/abusedb-cidr-30d.txt",
"https://raw.githubusercontent.com/bnlktm/ipblock/refs/heads/main/ipblocklist.txt",
"https://raw.githubusercontent.com/ChzSandvich/ipblocklistAWS/refs/heads/main/prefixes.txt",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/bitcoin_nodes_30d.ipset",
"https://raw.githubusercontent.com/ShadowWhisperer/IPs/refs/heads/master/BruteForce/Extreme",
"https://raw.githubusercontent.com/ShadowWhisperer/IPs/refs/heads/master/Malware/Hosting",
"https://raw.githubusercontent.com/ShadowWhisperer/IPs/refs/heads/master/Other/Scanners",
"https://raw.githubusercontent.com/ramit-mitra/blocklist-ipsets/refs/heads/main/rottenIPs.json",
"https://github.com/ashleykleynhans/ipset/raw/refs/heads/main/ipv4.csv",
"https://github.com/tn3w/IPSet/raw/refs/heads/master/iplist.txt",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/bds_atif.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/bitcoin_nodes.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/bitcoin_nodes_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/bitcoin_nodes_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/bitcoin_nodes_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_apache.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_bots.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_bruteforce.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_ftp.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_imap.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_mail.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_sip.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_ssh.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_de_strongips.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/blocklist_net_ua.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/botscout.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/botscout_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/botscout_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/botscout_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/botvrij_dst.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/bruteforceblocker.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/ciarmy.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cidr_report_bogons.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_new.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_new_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_new_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_new_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_top20.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_updated.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_updated_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_updated_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cleantalk_updated_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/coinbl_hosts.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cruzit_web_attacks.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/cybercrime.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/darklist_de.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/dm_tor.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/dyndns_ponmocup.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/et_block.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/et_compromised.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/et_dshield.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/et_spamhaus.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/et_tor.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_abusers_1d.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_abusers_30d.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_anonymous.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_level1.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_level2.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_level3.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_level4.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_proxies.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_webclient.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/firehol_webserver.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/gpf_comics.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/greensnow.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/haley_ssh.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/iblocklist_ciarmy_malicious.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/iblocklist_cidr_report_bogons.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/iblocklist_cruzit_web_attacks.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/iblocklist_onion_router.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/iblocklist_yoyo_adservers.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/myip.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_commenters.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_commenters_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_commenters_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_commenters_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_dictionary.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_dictionary_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_dictionary_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_dictionary_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_harvesters.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_harvesters_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_harvesters_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_harvesters_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_spammers.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_spammers_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_spammers_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/php_spammers_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/sblam.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/socks_proxy.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/socks_proxy_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/socks_proxy_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/socks_proxy_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/spamhaus_drop.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/spamhaus_edrop.netset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/sslproxies.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/sslproxies_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/sslproxies_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/sslproxies_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/start.txt",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/stopforumspam.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/stopforumspam_180d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/stopforumspam_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/stopforumspam_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/stopforumspam_365d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/stopforumspam_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/stopforumspam_90d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/tor_exits.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/tor_exits_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/tor_exits_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/tor_exits_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/vxvault.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/xroxy.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/xroxy_1d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/xroxy_30d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/xroxy_7d.ipset",
"https://raw.githubusercontent.com/borestad/firehol-mirror/refs/heads/main/yoyo_adservers.ipset",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/ahrefsbot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/betteruptimebot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/bingbot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/bunnycdn/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/censys/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/cloudflare/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/duckduckbot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/facebookbot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/google-special-crawlers/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/googlebot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/modat/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/openai/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/paloaltonetworks/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/pingdombot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/rssapi/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/shodan/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/stripewebhook/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/telegrambot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/uptimerobot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/webpagetestbot/ips.txt",
"https://raw.githubusercontent.com/sefinek/known-bots-ip-whitelist/refs/heads/main/lists/yandexbot/ips.txt"
]

# 并发处理的线程数
MAX_WORKERS = 10
# 输出文件名
OUTPUT_FILENAME = "adblock_reject23.json"


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
