# create-structure.ps1
# 起源云文档：创建目录与占位文件（Windows PowerShell 5.1 / PowerShell 7 均可）
# 运行方式（在仓库根目录）：
#   powershell -ExecutionPolicy Bypass -File .\create-structure.ps1
# 或者：
#   pwsh -File ./create-structure.ps1

$ErrorActionPreference = "Stop"

# 1) 需要创建的目录
$folders = @(
  "logo",
  "images",

  "getting-started",
  "instances",
  "storage",
  "ai-dev",
  "security",
  "troubleshooting",
  "about"
)

# 2) 需要创建的占位文件
$files = @(
  "getting-started/what-is-origin.mdx",
  "getting-started/why-choose-origin.mdx",
  "getting-started/quickstart.mdx",
  "getting-started/concepts.mdx",
  "getting-started/pricing.mdx",

  "instances/create.mdx",
  "instances/connect.mdx",
  "instances/upgrade-downgrade.mdx",
  "instances/save-and-release.mdx",
  "instances/custom-service.mdx",

  "storage/origin-disk.mdx",
  "storage/data-disk.mdx",
  "storage/upload-download.mdx",
  "storage/multi-instance.mdx",

  "ai-dev/overview.mdx",
  "ai-dev/terminal.mdx",
  "ai-dev/mcp.mdx",
  "ai-dev/auto-learning.mdx",
  "ai-dev/smart-recommend.mdx",
  "ai-dev/api-overview.mdx",
  "ai-dev/webhooks.mdx",
  "ai-dev/sdk.mdx",

  "security/account.mdx",
  "security/ssh.mdx",
  "security/network.mdx",

  "troubleshooting/faq.mdx",
  "troubleshooting/connection.mdx",
  "troubleshooting/environment.mdx",
  "troubleshooting/training.mdx",

  "about/design-principles.mdx",
  "about/architecture.mdx",
  "about/roadmap.mdx",
  "about/feedback.mdx"
)

# 3) 占位内容模板（注意：这里用单引号 here-string，结尾的 @' 必须顶格）
$tpl = @'
# （占位）页面标题

> 本页内容正在完善中。
> 如需优先查看此功能，请在「关于起源云 -> 反馈与支持」页面提交建议。

'@

# 4) 创建目录
foreach ($d in $folders) {
  if (-not (Test-Path -LiteralPath $d)) {
    New-Item -ItemType Directory -Path $d | Out-Null
  }
}

# 5) 创建占位文件并写入模板
foreach ($p in $files) {
  $dir = Split-Path -Parent $p
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir | Out-Null
  }
  if (-not (Test-Path -LiteralPath $p)) {
    New-Item -ItemType File -Path $p -Force | Out-Null
    # Windows PowerShell 5.1 下 -Encoding UTF8 会写入 BOM；PowerShell 7 默认 UTF-8 无 BOM 也可
    Set-Content -Path $p -Value $tpl -Encoding UTF8
  }
}

Write-Host "Done. Folders and placeholder pages created successfully."
