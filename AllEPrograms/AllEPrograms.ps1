$exeFiles = Get-ChildItem -Path E:\ -Recurse -Filter *.exe -ErrorAction SilentlyContinue

foreach ($exe in $exeFiles) {
    try {
        # Expanded blacklist of executables to avoid
        $blacklist = @("shutdown.exe", "bootim.exe", "logoff.exe", "msoobe.exe", "restart.exe", "tsshutdn.exe", "poweroff.exe", "slidetoshutdown.exe", "WerFault.exe")
        if ($blacklist -notcontains $exe.Name -and $exe.Name -notmatch
"shutdown|bootim|logoff|msoobe|restart|tsshutdn|poweroff|slidetoshutdown|WerFault") {
            Start-Process -FilePath $exe.FullName
        } else {
            Write-Host "Skipping $exe due to blacklist" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Failed to open $exe" -ForegroundColor Red
    }
}
