#Requires -Version 7.0

$urls = @(
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset",
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset",
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level3.netset"
)
$finalRuleSetFile = "adblock_reject20.json"
$throttleLimit = [System.Environment]::ProcessorCount

Write-Host "开始并行下载文件..."
$downloadedFiles = $urls | ForEach-Object -Parallel {
    $url = $_
    $tempFile = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
    try {
        Invoke-WebRequest -Uri $url -OutFile $tempFile -UseBasicParsing -ErrorAction Stop
        return $tempFile
    }
    catch {
        Write-Warning "下载失败: $url"
    }
} -ThrottleLimit $throttleLimit

$downloadedFiles = $downloadedFiles | Where-Object { $_ }
if ($downloadedFiles.Count -eq 0) {
    Write-Error "所有文件下载失败，脚本终止。"
    exit
}
Write-Host "文件下载完成。"

Write-Host "开始并行处理文件并聚合 IP..."
$allIpCidrs = $downloadedFiles | ForEach-Object -Parallel {
    $filePath = $_
    $ipAddress = [System.Net.IPAddress]::None
    foreach ($line in [System.IO.File]::ReadLines($filePath)) {
        if ($line -and $line[0] -ne '#') {
            if ([System.Net.IPAddress]::TryParse($line, [ref]$ipAddress)) {
                if ($ipAddress.AddressFamily -eq 'InterNetwork') {
                    "$line/32"
                }
                elseif ($ipAddress.AddressFamily -eq 'InterNetworkV6') {
                    "$line/128"
                }
            }
        }
    }
} -ThrottleLimit $throttleLimit

Write-Host "文件处理完成，共收集到 $($allIpCidrs.Count) 条有效 IP CIDR。"

Write-Host "正在生成整合的 sing-box rule set 文件..."
$ruleSet = @{
    version = 1
    rules   = @(
        @{
            ip_cidr = $allIpCidrs | Select-Object -Unique
        }
    )
}
$ruleSet | ConvertTo-Json -Depth 5 | Set-Content -Path $PSScriptRoot/finalRuleSetFile -Encoding UTF8 -NoNewline
Write-Host "Rule set 文件已成功生成：$finalRuleSetFile"

Write-Host "正在清理临时文件..."
$downloadedFiles | ForEach-Object { Remove-Item $_ -Force }

Write-Host "所有任务完成。"

pause
