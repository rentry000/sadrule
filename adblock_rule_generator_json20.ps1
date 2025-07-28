
# 安装 ThreadJob 模块（若未安装）
if (-not (Get-Module -ListAvailable -Name ThreadJob)) {
    Install-Module -Name ThreadJob -Force -Scope CurrentUser
}

# 定义远程文件路径（示例）
$remoteFiles = @(
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/anonymous.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_af.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_an.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_as.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_eu.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_na.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_oc.netset",
"https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/geolite2_country/continent_sa.netset"
)

# 分块大小（单位：行）
$chunkSize = 1000

# 最终生成的 JSON 结构（根据 sing-box 要求定制）
$singBoxConfig = @{
    "route" = @{
        "rules" = @()
    }
    "outbounds" = @()
}

# 线程安全集合保存处理结果
($using:resultQueue) = [System.Collections.Concurrent.ConcurrentQueue[object]]::new()

# 处理单个分块的函数
$processChunkScript = {
    param($url, $startLine, $endLine)
    
    try {
        # 下载远程文件分块（模拟示例）
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content -split "`n"
        $chunkData = $content[$startLine..$endLine]

        # 模拟处理逻辑（例如解析路由规则）
        $processed = foreach ($line in $chunkData) {
            @{
                "type" = "field"
                "domain" = @($line.Trim())
                "outboundTag" = "block"
            }
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
    $totalLines = $remoteFiles.count  # 实际需动态获取

    # 分块并提交线程任务
    for ($i = 0; $i -lt $totalLines; $i += $chunkSize) {
        $start = $i
        $end = [Math]::Min($i + $chunkSize - 1, $totalLines - 1)
        
        Start-ThreadJob -ScriptBlock $processChunkScript -ArgumentList $file, $start, $end
    }
}

# 等待所有任务完成
$jobs | Wait-Job | Receive-Job -AutoRemoveJob -wait

# 合并结果到 JSON 配置
while (($using:resultQueue).TryDequeue([ref]$null)) {
    $singBoxConfig.route.rules += ($using:resultQueue).ToArray()
}

# 生成最终 JSON 文件
$singBoxConfig | ConvertTo-Json -Depth 10 | Out-File "adblock_reject20.json"

Write-Host "生成成功：singbox_config.json" -ForegroundColor Green

pause
