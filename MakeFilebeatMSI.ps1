
# https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.3.1-windows-x86_64.zip


[Environment]::CurrentDirectory = $PSScriptRoot



$wixbinpath = 'C:\Program Files (x86)\WiX Toolset v3.11\bin\'
$wixbuildpath = $PSScriptRoot + '\build\'
$wixsourcefilespath = $PSScriptRoot + '\source\'

start-process -filepath $wixbinpath"heat.exe" -ArgumentList "dir", $wixsourcefilespath, "-cg FilebeatFiles -gg -scom -sreg -sfrag -srd -dr INSTALLLOCATION  -var `"var.FilebeatFilesDir`" -t", $PSScriptRoot"\excludeExe.xslt", "-out", $wixbuildpath"FilesFragment.wxs" -NoNewWindow -Wait
start-process -filepath $wixbinpath"candle.exe" -ArgumentList "filebeat.wxs -arch x64 -out", $wixbuildpath -NoNewWindow -Wait
start-process -filepath $wixbinpath"candle.exe" -ArgumentList $wixbuildpath"FilesFragment.wxs -arch x64 -out", $wixbuildpath -NoNewWindow -Wait
start-process -filepath $wixbinpath"light.exe" -ArgumentList "-v", $wixbuildpath"filebeat.wixobj", $wixbuildpath"FilesFragment.wixobj", "-o",$wixbuildpath"filebeat.msi" -NoNewWindow -Wait