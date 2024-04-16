# 設定ファイルのパス (ファイル名はconfig.jsonと仮定)
$configFilePath = ".\Config.json"

# 設定ファイルから情報を読み取る
$config = Get-Content -Raw -Path $configFilePath | ConvertFrom-Json

# 処理対象フォルダ
$targetFolder = $config.TargetFolder

# 置換前文字列と置換後文字列
$replaceFrom = $config.ReplaceFrom
$replaceTo = $config.ReplaceTo

# フォルダ内のファイルを再帰的に処理
Get-ChildItem -Path $targetFolder -File -Recurse | ForEach-Object {
    $newName = $_.Name -replace $replaceFrom, $replaceTo
    if ($newName -ne $_.Name) {
        # 置換が必要な場合のみファイル名を変更
        Rename-Item -Path $_.FullName -NewName $newName
        Write-Host "Renamed file: $($_.FullName) to $newName"
    }
}
