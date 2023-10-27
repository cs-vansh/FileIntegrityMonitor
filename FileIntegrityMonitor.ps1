Write-Host "Enter the folder path to create a baseline and start monitoring:"
$folderPath = Read-Host -Prompt "Folder Path"

Function Calculate-File-Hash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

Function Delete-Baseline-If-Exists($folderPath){
    $baselinePath = Join-Path (Split-Path $folderPath -Parent) "baseline.txt"
    if(Test-Path -Path $baselinePath){
        Remove-Item -Path $baselinePath
    }
}

if (Test-Path -Path $folderPath) {
    # Create a new baseline
    $files = Get-ChildItem -Path $folderPath
    Delete-Baseline-If-Exists $folderPath

    foreach ($file in $files) {
        $hash = Calculate-File-Hash $file.FullName
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath (Join-Path (Split-Path $folderPath -Parent) "baseline.txt") -Append
    }
    Write-Host "Baseline created successfully." -ForegroundColor Green

    # Start monitoring using the new baseline
    while ($true) {
        Start-Sleep -Seconds 5
        Write-Host "Checking the Integrity of Files.."

        if (!(Test-Path -Path (Join-Path (Split-Path $folderPath -Parent) "baseline.txt"))) {
            Write-Host "Baseline file not found. Monitoring cannot continue." -ForegroundColor Red
            break
        }

        $fileHashDictionary = @{}
        $ContentPathsAndHashes = Get-Content -Path (Join-Path (Split-Path $folderPath -Parent) "baseline.txt")

        foreach ($f in $ContentPathsAndHashes) {
            $fileHashDictionary.Add($f.Split("|")[0], $f.Split("|")[1])
        }

        $files = Get-ChildItem -Path $folderPath

        # Check for created or modified files
        foreach ($file in $files) {
            $hash = Calculate-File-Hash $file.FullName

            if ($fileHashDictionary[$hash.Path] -eq $null) {
                Write-Host "$($hash.Path) has been created" -ForegroundColor Gray
            } else {
                if ($fileHashDictionary[$hash.Path] -eq $hash.Hash) {
                    # File is unmodified
                } else {
                    Write-Host "$($hash.Path) has been modified" -ForegroundColor Red
                }
            }
        }

        # Check for deleted files
        foreach ($key in $fileHashDictionary.Keys) {
            if (!(Test-Path -Path $key)) {
                Write-Host "$($key) has been deleted!" -ForegroundColor Red
            }
        }
    }
} else {
    Write-Host "The specified folder does not exist."
}
