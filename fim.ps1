
Write-Host ""
Write-Host "which operation would you like to perform?"
Write-Host "A) Collect new baseline?"
Write-Host "B) Begin Montoring files with saved baseline?"
Write-Host ""

$response = Read-Host -Prompt "PLease enter 'A' or 'B'"
Write-Host ""

Function Calculate-File-Hash($filepath){
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA256
    return $filehash
}


Function Erase-Baseline-If-Already-Exists(){
    $baselineExists = Test-Path -Path .\baseline.txt

    if($baselineExists){
        #delete it
        Remove-Item -Path .\baseline.txt
    }
}


if ($response -eq "A".ToUpper()){
    #delete baseline if it already exists
    Erase-Baseline-If-Already-Exists
    
    #calculate hash from the target files and store in baseline.txt

    #collect all files in the target folder
    $files= Get-ChildItem -Path .\files
 
    #for file, calculate the hash, and write to baseline.txt
    foreach ($f in $files){
        $hash = Calculate-File-Hash $f.FullName 
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }
}

elseif ($response -eq "B".ToUpper()){
    
    $fileHashDictionary = @{}
    #load file : hash from baseline.txt and store them in a dictionary
    $filePathsAndHashes = Get-Content -Path .\baseline.txt
    
    foreach($f in $filePathsAndHashes){
        $fileHashDictionary.add($f.Split("|")[0],$f.Split("|")[1])
        
    }

    #begin (continuosly) monitoring files with saved Baseline

    while($true){
        Start-Sleep -Seconds 1

        $files= Get-ChildItem -Path .\files
 
        #for file, calculate the hash, and write to baseline.txt
        foreach ($f in $files){
            $hash = Calculate-File-Hash $f.FullName 
            #"$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
            
            #notify if a new file has been created
            if($fileHashDictionary[$hash.Path] -eq $null){
                #A new file has been created! 
                Write-Host "$($hash.Path) has been created!" -ForegroundColor Green
            }

            else{
                 
            #notify if a file has been changed
            if ($fileHashDictionary[$hash.Path] -eq $hash.Hash){
                #the file has not changed
            }
            else{

                #File has been compromised! Notify the user
                Write-Host "$($hash.Path) has changed!!! " -ForegroundColor Yellow
            }
            }
            }

           foreach($key in $fileHashDictionary.keys){
            
            $baselinefilestillExists = Test-Path -Path $key
            if(-Not $baselinefilestillExists){
                #One of the base line files must have been deleted! 
                Write-Host "$($key) has been deleted! " -ForegroundColor Red
            
        }
    }

}
}