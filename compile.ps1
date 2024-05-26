# Resolves the file dependencies and compiles them into one file.
#   This DOES NOT resolve circular dependencies correctly. Avoid those.
#
# Paremeters
#   -Output [-O][-Out]: Sets output directory for combined file.

param(
    [Alias("O","Out")]
    [string]$Output=((split-path -parent $MyInvocation.MyCommand.Definition) + "\SND_Questhelper_FULL.lua")
) 


# Get the directory of the PowerShell script
$scriptDir = split-path -parent $MyInvocation.MyCommand.Definition

$classDir = Join-Path -Path $scriptDir -ChildPath "Classes"
$mainPath = Join-Path -Path $scriptDir -ChildPath "main.lua"

# Resolve the order of files based on dependencies
$dependencies = @{}
$resolvedFiles = New-Object System.Collections.Generic.List[string]
$seenFiles = New-Object System.Collections.Generic.HashSet[string]

# Function to parse Lua files for dependencies
function Parse-LuaFiles {
    param (
        [string]$directory
    )
    
    # Get all Lua files in the directory and its subdirectories
    $files = Get-ChildItem -Path $directory -Filter *.lua -Recurse

    # Create a mapping of filenames to their full paths
    $fileMap = @{}
    Write-Host "Finding -lua files in $directory recursively:"
    foreach ($file in $files) {
        Write-Host "-- Found file:" $file.Name
        if ($fileMap.ContainsKey($file.Name)){
            Write-Warning "There is more than 1 .lua file with the name" $file.Name "! Please make sure to use unique names!"
            exit 1
        }
        $fileMap[$file.Name] = $file.FullName
    }
    Write-Host "Done finding files."
    
    Write-Host "Parsing files for dependencies."
    foreach ($file in $files) {
        $content = Get-Content -Path $file.FullName
        $hasDependencies = $false
        foreach ($line in $content) {
            if ($line -match "-- @depends (.+\.lua)") {
                $dependency = $matches[1]
                if ($fileMap.ContainsKey($dependency)) {
                    if (-not $dependencies.ContainsKey($file.FullName)) {
                        $dependencies[$file.FullName] = @()
                    }
                    $dependencies[$file.FullName] += $fileMap[$dependency]
                    Write-Host "In" $file.FullName "found dependency:" $dependency
                    $hasDependencies = $true
                } else {
                    Write-Error "Dependency $dependency not found for file $($file.FullName)"
                }
            } else {
                break;
            }
        }
        if (-not $hasDependencies) {
            $resolvedFiles.Add($file.FullName)
            Write-Host "Found no dependencies for" $file.FullName
        }
    }
    Write-Host "Done parsing."
}

# Function to resolve dependencies
function Resolve-Dependencies {
    param (
        [string]$file,
        [hashtable]$dependencies,
        [ref]$resolved,
        [ref]$seen
    )

    if ($seen.Value.Contains($file)) {
        return
    }

    $seen.Value.Add($file)

    if ($dependencies.ContainsKey($file)) {
        foreach ($dependency in $dependencies[$file]) {
            Resolve-Dependencies -file $dependency -dependencies $dependencies -resolved $resolved -seen $seen
        }
    }

    if (-not $resolved.Value.Contains($file)) {
        $resolved.Value.Add($file)
    }
}

# Parse Lua files in the specified directory
Parse-LuaFiles -directory $classDir

foreach ($file in $dependencies.Keys) {
    # $t stops it from spitting out True and False into console
    $t = Resolve-Dependencies -file $file -dependencies $dependencies -resolved ([ref]$resolvedFiles) -seen ([ref]$seenFiles)
}

# Create or overwrite the output file
Write-Host "Deleting" $Output
Remove-Item -Path $Output -ErrorAction Ignore

foreach ($file in $resolvedFiles) {
    Write-Host "Attaching" $file
    Get-Content -Path $file -Raw | Add-Content -Path $Output
    Add-Content -Path $Output -Value "`n"  # Add a newline between files
}

Write-Host "Attaching" $mainPath
Get-Content -Path $mainPath -Raw | Add-Content -Path $Output

Write-Host "Files combined successfully. Output file: $Output"