#Requires -Version 7.0

$urls = @(
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset",
    "https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset"
)
$outputDir = "rule_sets"
$chunkSize = 50000
$throttleLimit = [System.Environment]::ProcessorCount

if (-not (Test-Path -Path $outputDir)) {
    New-Item -Path $outputDir -ItemType Directory | Out-Null
}

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

Write-Host "开始并行处理文件并转换 IP..."
$allIpCidrs = $downloadedFiles | ForEach-Object -Parallel {
    $filePath = $_
    $ipAddress = [System.Net.IPAddress]::None
    foreach ($line in [System.IO.File]::ReadLines($filePath)) {
        if ([System.Net.IPAddress]::TryParse($line, [ref]$ipAddress)) {
            if ($ipAddress.AddressFamily -eq 'InterNetwork') {
                "$line/32"
            }
            elseif ($ipAddress.AddressFamily -eq 'InterNetworkV6') {
                "$line/128"
            }
        }
    }
} -ThrottleLimit $throttleLimit

Write-Host "文件处理完成，共收集到 $($allIpCidrs.Count) 条有效 IP CIDR。"

Write-Host "正在将数据分块并生成规则集文件..."
$totalItems = $allIpCidrs.Count
$chunkCount = [System.Math]::Ceiling($totalItems / $chunkSize)

for ($i = 0; $i -lt $chunkCount; $i++) {
    $startIndex = $i * $chunkSize
    $endIndex = [System.Math]::Min($startIndex + $chunkSize - 1, $totalItems - 1)
    $chunk = $allIpCidrs[$startIndex..$endIndex]
    
    if ($chunk.Count -gt 0) {
        $ruleSet = @{
            version = 1
            rules   = @(
                @{
                    ip_cidr = $chunk
                }
            )
        }
        $outputFile = Join-Path $outputDir "ruleset_part_$($i + 1).json"
        $ruleSet | ConvertTo-Json -Depth 5 | Set-Content -Path $outputFile -Encoding UTF8 -NoNewline
        Write-Host "已生成: $outputFile"
    }
}

Write-Host "正在清理临时文件..."
$downloadedFiles | ForEach-Object { Remove-Item $_ -Force }

Write-Host "所有任务完成。"

pause
