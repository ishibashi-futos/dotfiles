# 標準のダサいPROMPTを上書きします
function prompt() {
  # FULLPATHを出したいときはこっちのフラグをオンにする
  if ($Env:PROMPT_DISPLAY_FULLPATH -ne $null) {
    $location = Get-Location
  } else {
    $drive = (Split-Path (Get-Location) -Qualifier)
    $currentDirectoy = (Split-Path (Get-Location) -Leaf)
    $location = "$drive ~ $currentDirectoy"
  }
  # PROMPTにbranchを `(branch name)` と表示する
  $branch = (git branch | Select-String "\*").Line
  if ($branch -eq $null) {
    $branch = ""
  } else {
    $branch = "(" + $branch.Split(" ")[1] + ")"
  }
  Write-Host "[$location]" -NoNewline
  Write-Host " $branch" -ForegroundColor Magenta -NoNewline
  return "`n> "
}
