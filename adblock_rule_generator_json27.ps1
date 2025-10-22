# Title: AdBlock_Rule_For_Sing-box
# Description: 适用于Sing-box的域名拦截规则集，每20分钟更新一次，确保即时同步上游减少误杀
# Homepage: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box
# LICENSE1: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-GPL 3.0
# LICENSE2: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-CC-BY-NC-SA 4.0


# 定义广告过滤器URL列表
$urlList = @(
"https://github.com/cuongdt1994/Block-Phising-Crypto-Domains/raw/refs/heads/main/lists/domains",
"https://github.com/gfunkmonk/pihole-blocklist-cleaner2/raw/refs/heads/main/blocklist.txt",
"https://github.com/jtbrough/pihole-hosts/raw/refs/heads/main/firebog-ticked-hosts",
"https://github.com/Tahosol/blist/raw/refs/heads/master/blocklist.txt",
"https://github.com/stan4o/pihole-local/raw/refs/heads/main/hosts",
"https://github.com/Tempest-Solutions-Company/pihole_blocklists/raw/refs/heads/main/all_malicious.txt",
"https://github.com/Tempest-Solutions-Company/pihole_blocklists/raw/refs/heads/main/banking_trojan.txt",
"https://github.com/Tempest-Solutions-Company/pihole_blocklists/raw/refs/heads/main/c2_servers.txt",
"https://github.com/Tempest-Solutions-Company/pihole_blocklists/raw/refs/heads/main/malware.txt",
"https://github.com/Tempest-Solutions-Company/pihole_blocklists/raw/refs/heads/main/phishing.txt",
"https://github.com/FrancoStefano/PiHoleList/raw/refs/heads/main/PiLists",
"https://github.com/elliotwutingfeng/USOM-Blocklists/raw/refs/heads/main/urls_ABP.txt",
"https://raw.githubusercontent.com/elliotwutingfeng/USOM-Blocklists/refs/heads/main/urls_pihole.txt",
"https://github.com/invisiblethreat/openphish-pihole/raw/refs/heads/main/openphish.txt",
"https://raw.githubusercontent.com/Zaczero/pihole-phishtank/main/hosts.txt",
"https://github.com/Bastiaantjuhh/hostfile-merge/raw/refs/heads/main/hostfiles/blacklist.txt",
"https://blocklistproject.github.io/Lists/abuse.txt",
"https://blocklistproject.github.io/Lists/ads.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/crypto.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/drugs.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/everything.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/facebook.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/fraud.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/gambling.txt"
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/malware.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/phishing.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/piracy.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/porn.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/ransomware.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/redirect.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/scam.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/smart-tv.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/tiktok.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/torrent.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/tracking.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/twitter.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/vaping.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/whatsapp.txt",
"https://github.com/blocklistproject/Lists/raw/refs/heads/master/youtube.txt",
"https://github.com/Henchway/WatchlistInternetPihole/raw/refs/heads/main/data.txt",
"https://github.com/tsutsman/tsutsman-pihole-blacklist/raw/refs/heads/main/domains.txt",
"https://github.com/r0xd4n3t/pihole-adblock-lists/raw/refs/heads/main/pihole_adlists.txt",
"https://github.com/mstewart197930/PIHOLE_Homework_Blocking/raw/refs/heads/main/School_Blocking_List.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/entities.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_Advertising.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_Analytics.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_Anti-fraud.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_ConsentManagers.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_Content.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_Cryptomining.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_Email.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_EmailAggressive.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_FingerprintingGeneral.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_FingerprintingInvasive.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/services_Social.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/entities.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/entities.txt",
"https://github.com/erkexzcx/disconnectme-pihole/raw/refs/heads/master/entities.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/adlist.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/abuse.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/malware.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/coinmining.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/phishing.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/privacy.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/redirect.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/spam.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/google_amp.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/regex.txt",
"https://raw.githubusercontent.com/Levi2288/AdvancedBlockList/main/Lists/whitelist.txt",
"https://github.com/XionKzn/PiHole-Lists/raw/refs/heads/master/PiHole/HOSTS",
"https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
"https://mirror1.malwaredomains.com/files/justdomains",
"http://sysctl.org/cameleon/hosts",
"https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist",
"https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt",
"https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt",
"https://hosts-file.net/ad_servers.txt",
"https://raw.githubusercontent.com/StevenBlack/hosts/blob/master/extensions/fakenews/hosts",
"https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt",
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts",
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling/hosts",
"https://v.firebog.net/hosts/Easyprivacy.txt",
"https://hosts-file.net/download/HOSTS-Optimized.txt",
"https://hosts-file.net/emd.txt",
"https://hosts-file.net/exp.txt",
"https://hosts-file.net/fsa.txt",
"https://hosts-file.net/grm.txt",
"https://hosts-file.net/hfs.txt",
"https://hosts-file.net/hjk.txt",
"https://hosts-file.net/mmt.txt",
"https://hosts-file.net/psh.txt",
"https://hosts-file.net/hphosts-partial.txt",
"https://www.malwaredomainlist.com/hostslist/hosts.txt",
"https://raw.githubusercontent.com/anudeepND/youtubeadsblacklist/master/domainlist.txt",
"https://raw.githubusercontent.com/anudeepND/blacklist/master/CoinMiner.txt",
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts",
"https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt",
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts",
"https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling/hosts",
"https://v.firebog.net/hosts/Easyprivacy.txt",
"https://feodotracker.abuse.ch/blocklist/?download=domainblocklist",
"https://ransomwaretracker.abuse.ch/downloads/RW_IPBL.txt",
"https://ransomwaretracker.abuse.ch/downloads/RW_DOMBL.txt",
"https://ransomwaretracker.abuse.ch/downloads/RW_URLBL.txt",
"https://ransomwaretracker.abuse.ch/downloads/LY_C2_DOMBL.txt",
"https://ransomwaretracker.abuse.ch/downloads/CW_C2_DOMBL.txt",
"https://ransomwaretracker.abuse.ch/downloads/TC_C2_DOMBL.txt",
"https://ransomwaretracker.abuse.ch/downloads/CB_PS_DOMBL.txt",
"https://v.firebog.net/hosts/static/SamsungSmart.txt",
"https://tspprs.com/dl/torrent",
"https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt",
"https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt",
"https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt",
"https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SessionReplay.txt",
"https://tspprs.com/dl/phishing",
"https://tspprs.com/dl/ransomware",
"https://tspprs.com/dl/fakenews",
"https://tspprs.com/dl/crypto",
"https://tspprs.com/dl/scam",
"https://tspprs.com/dl/spam",
"https://tspprs.com/dl/abuse",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/PiHole_HOSTS_Spyware.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/Blocklist.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/Cerber_Ransomware.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/Quad9.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/OpenDNS_Block_list.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/OpenDNS_Global_block_list.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/PiHole_Custom_Block_List_Home.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/PiHole_Custom_Block_List_Office.txt",
"https://tspprs.com/dl/porn",
"https://tspprs.com/dl/fraud",
"https://tspprs.com/dl/drugs",
"https://dbl.oisd.nl",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/PiHole/HOSTS",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/refs/heads/master/PiHole/My_Blocked_Domains.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/refs/heads/master/PiHole/Archive/OpenDNS_Block_list.txt",
"https://raw.githubusercontent.com/XionKzn/PiHole-Lists/refs/heads/master/PiHole/Archive/Quad9.txt",
"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt",
"https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt"
)

# 日志文件路径
$logFilePath = "$PSScriptRoot/adblock_log.txt"

# 创建两个HashSet来存储唯一的规则和排除的域名
$uniqueRules = [System.Collections.Generic.HashSet[string]]::new()
$excludedDomains = [System.Collections.Generic.HashSet[string]]::new()

# 创建WebClient对象用于下载规则
$webClient = New-Object System.Net.WebClient
$webClient.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")

# DNS规范验证函数
function Is-ValidDNSDomain($domain) {
    if ($domain.Length -gt 253) { return $false }
    $labels = $domain -split "\."
    foreach ($label in $labels) {
        if ($label.Length -eq 0 -or $label.Length -gt 63) { return $false }
        if ($label -notmatch "^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$") {
            return $false
        }
    }
    $tld = $labels[-1]
    if ($tld -notmatch "^[a-zA-Z]{2,}$") { return $false }
    return $true
}

foreach ($url in $urlList) {
    Write-Host "正在处理: $url"
    Add-Content -Path $logFilePath -Value "正在处理: $url"
    try {
        # 读取并拆分内容为行
        $content = $webClient.DownloadString($url)
        $lines = $content -split "`n"

        foreach ($line in $lines) {
            # 直接处理以 @@ 开头的规则，提取域名并加入白名单
            if ($line.StartsWith('@@')) {
                $domains = $line -replace '^@@', '' -split '[^\w.-]+'
                foreach ($domain in $domains) {
                    if (-not [string]::IsNullOrWhiteSpace($domain) -and $domain -match '[\w-]+(\.[[\w-]+)+') {
                        $excludedDomains.Add($domain.Trim()) | Out-Null
                    }
                }
            }
            else {
                # 匹配 Adblock/Easylist 格式的规则
                if ($line -match '^\|\|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\^$') {
                    $domain = $Matches[1]
                    $uniqueRules.Add($domain) | Out-Null
                }
                # 匹配 Hosts 文件格式的 IPv4 规则
                elseif ($line -match '^(0\.0\.0\.0|127\.0\.0\.1)\s+([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$') {
                    $domain = $Matches[2]
                    $uniqueRules.Add($domain) | Out-Null
                }
                # 匹配 Hosts 文件格式的 IPv6 规则（以 ::1 或 :: 开头）
                elseif ($line -match '^::(1)?\s+([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$') {
                    $domain = $Matches[2]
                    $uniqueRules.Add($domain) | Out-Null
                }
                # 匹配 Dnsmasq address=/域名/格式的规则
                elseif ($line -match '^address=/([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/$') {
                    $domain = $Matches[1]
                    $uniqueRules.Add($domain) | Out-Null
                }
                # 匹配 Dnsmasq server=/域名/的规则
                elseif ($line -match '^server=/([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/$') {
                    $domain = $Matches[1]
                    $uniqueRules.Add($domain) | Out-Null
                }
                # 匹配通配符规则
                elseif ($line -match '^\|\|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\^$') {
                    $domain = $Matches[1]
                    $uniqueRules.Add($domain) | Out-Null
                }
                # 处理纯域名行
                elseif ($line -match '^([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$') {
                    $domain = $Matches[1]
                    $uniqueRules.Add($domain) | Out-Null
                }
            }
        }
    }
    catch {
        Write-Host "处理 $url 时出错: $_"
        Add-Content -Path $logFilePath -Value "处理 $url 时出错: $_"
    }
}

# 在写入文件之前进行DNS规范验证
$validRules = [System.Collections.Generic.HashSet[string]]::new()
$validExcludedDomains = [System.Collections.Generic.HashSet[string]]::new()

foreach ($domain in $uniqueRules) {
    if (Is-ValidDNSDomain($domain)) {
        $validRules.Add($domain) | Out-Null
    }
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
    rules = @(
        @{
            domain= $sortedDomains
        }
    )
}

# 转换为带紧凑缩进的JSON格式
$jsonFormatted = $jsonContent | ConvertTo-Json -Depth 10 | ForEach-Object { $_.Trim() }

# 定义输出文件路径
$outputPath = "$PSScriptRoot/adblock_reject27.json"
$jsonFormatted | Out-File -FilePath $outputPath -Encoding utf8

# 输出生成的有效规则总数
Write-Host "生成的有效规则总数: $ruleCount"
Add-Content -Path $logFilePath -Value "Total entries: $ruleCount"

Pause
