# Get the directory of the PowerShell script
$scriptDir = $PSScriptRoot

$dataDir = Join-Path -Path $scriptDir -ChildPath "Data"
$classDir = Join-Path -Path $scriptDir -ChildPath "Classes"
$classDirDepth2 = Join-Path -Path $scriptDir -ChildPath "Classes\Layer2"
$classDirDepth3 = Join-Path -Path $scriptDir -ChildPath "Classes\Layer2\Layer3"
$classDirDepth4 = Join-Path -Path $scriptDir -ChildPath "Classes\Layer2\Layer3\Layer4"
$questDir = Join-Path -Path $scriptDir -ChildPath "Quests"

$mainPath = Join-Path -Path $scriptDir -ChildPath "main.lua"

$outFile = "Compiled/FF14_Retainer_GC_Expert_MSQ.lua"
$outFilePath = Join-Path -Path $scriptDir -ChildPath $outFile

function CombineFiles {
    param (
        [string]$FolderPath
    )

    Write-Host "Combining Files" $FolderPath

    # Get all files in the folder and its subfolders
    $files = Get-ChildItem -Path $FolderPath -File

    # Initialize an empty string to store the combined content
    $combinedContent = ""

    # Iterate through each file and append its content to the combined content
    foreach ($file in $files) {
        Write-Host " -" $file.FullName
        $content = Get-Content -Path $file.FullName -Raw
        $combinedContent += $content + "`r`n`r`n"
    }

    # Return the combined content
    return $combinedContent
}

$fileContent = ""
$fileContent += CombineFiles $classDir
$fileContent += CombineFiles $classDirDepth2
$fileContent += CombineFiles $classDirDepth3
$fileContent += CombineFiles $classDirDepth4
$fileContent += CombineFiles $dataDir
$fileContent += CombineFiles $questDir
Write-Host "Attaching" $mainPath
$fileContent += Get-Content -Path $mainPath -Raw

$fileContent | Out-File -FilePath $outFilePath
Write-Host "Files combined successfully. Output file: $outFilePath"