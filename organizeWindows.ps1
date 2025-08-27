
$downloadPath = "$env:USERPROFILE\Downloads"

$rules = @{
    # Documents
    ".pdf"      = "PDFs"
    ".docx"     = "Documents"
    ".doc"      = "Documents"
    ".xlsx"     = "Documents"
    ".xls"      = "Documents"
    ".xlsm"     = "Documents"
    ".pptx"     = "Documents"
    ".ppt"      = "Documents"
    ".txt"      = "Documents"
    ".rtf"      = "Documents"
    ".odt"      = "Documents"
    ".ods"      = "Documents"
    ".odp"      = "Documents"
    ".csv"      = "Documents"
    ".md"       = "Documents"
    ".epub"     = "Documents"
    
    # Images
    ".jpg"      = "Images"
    ".jpeg"     = "Images"
    ".png"      = "Images"
    ".gif"      = "Images"
    ".webp"     = "Images"
    ".bmp"      = "Images"
    ".tiff"     = "Images"
    ".tif"      = "Images"
    ".svg"      = "Images"
    ".ico"      = "Images"
    ".psd"      = "Images"
    ".ai"       = "Images"
    ".eps"      = "Images"
    ".raw"      = "Images"
    ".cr2"      = "Images"
    ".nef"      = "Images"
    ".heic"     = "Images"
    ".heif"     = "Images"
    
    # Videos
    ".mp4"      = "Videos"
    ".mkv"      = "Videos"
    ".mov"      = "Videos"
    ".avi"      = "Videos"
    ".wmv"      = "Videos"
    ".flv"      = "Videos"
    ".webm"     = "Videos"
    ".m4v"      = "Videos"
    ".3gp"      = "Videos"
    ".ogv"      = "Videos"
    ".mts"      = "Videos"
    ".vob"      = "Videos"
    
    # Audio
    ".mp3"      = "Audio"
    ".wav"      = "Audio"
    ".flac"     = "Audio"
    ".aac"      = "Audio"
    ".ogg"      = "Audio"
    ".wma"      = "Audio"
    ".m4a"      = "Audio"
    ".opus"     = "Audio"
    ".aiff"     = "Audio"
    ".au"       = "Audio"
    
    # Archives/Compressed
    ".zip"      = "Archives"
    ".rar"      = "Archives"
    ".7z"       = "Archives"
    ".tar"      = "Archives"
    ".gz"       = "Archives"
    ".bz2"      = "Archives"
    ".xz"       = "Archives"
    ".tar.gz"   = "Archives"
    ".tar.bz2"  = "Archives"
    ".tar.xz"   = "Archives"
    ".cab"      = "Archives"
    ".iso"      = "Archives"
    
    # Executables/Installers
    ".exe"      = "Installers"
    ".msi"      = "Installers"
    ".msix"     = "Installers"
    ".appx"     = "Installers"
    ".deb"      = "Installers"
    ".rpm"      = "Installers"
    ".pkg"      = "Installers"
    ".dmg"      = "Installers"
    
    # Code Files
    ".js"       = "Code"
    ".html"     = "Code"
    ".htm"      = "Code"
    ".css"      = "Code"
    ".scss"     = "Code"
    ".sass"     = "Code"
    ".less"     = "Code"
    ".json"     = "Code"
    ".xml"      = "Code"
    ".yaml"     = "Code"
    ".yml"      = "Code"
    ".ts"       = "Code"
    ".tsx"      = "Code"
    ".jsx"      = "Code"
    ".vue"      = "Code"
    ".php"      = "Code"
    ".c"        = "Code"
    ".cpp"      = "Code"
    ".cc"       = "Code"
    ".cxx"      = "Code"
    ".h"        = "Code"
    ".hpp"      = "Code"
    ".java"     = "Code"
    ".class"    = "Code"
    ".jar"      = "Code"
    ".py"       = "Code"
    ".pyc"      = "Code"
    ".pyw"      = "Code"
    ".go"       = "Code"
    ".rs"       = "Code"
    ".rb"       = "Code"
    ".pl"       = "Code"
    ".swift"    = "Code"
    ".kt"       = "Code"
    ".scala"    = "Code"
    ".r"        = "Code"
    ".matlab"   = "Code"
    ".sql"      = "Code"
    ".db"       = "Code"
    ".sqlite"   = "Code"
    
    # Scripts
    ".ps1"      = "Scripts"
    ".psm1"     = "Scripts"
    ".psd1"     = "Scripts"
    ".sh"       = "Scripts"
    ".bash"     = "Scripts"
    ".zsh"      = "Scripts"
    ".fish"     = "Scripts"
    ".bat"      = "Scripts"
    ".cmd"      = "Scripts"
    ".vbs"      = "Scripts"
    ".applescript" = "Scripts"
    
    # Mobile Apps
    ".apk"      = "Mobile_Apps"
    ".ipa"      = "Mobile_Apps"
    ".xapk"     = "Mobile_Apps"
    
    # 3D Models & Assets
    ".glb"      = "3D_Models"
    ".gltf"     = "3D_Models"
    ".obj"      = "3D_Models"
    ".fbx"      = "3D_Models"
    ".dae"      = "3D_Models"
    ".3ds"      = "3D_Models"
    ".blend"    = "3D_Models"
    ".max"      = "3D_Models"
    ".ma"       = "3D_Models"
    ".mb"       = "3D_Models"
    ".c4d"      = "3D_Models"
    ".stl"      = "3D_Models"
    ".ply"      = "3D_Models"
    
    # Fonts
    ".ttf"      = "Fonts"
    ".otf"      = "Fonts"
    ".woff"     = "Fonts"
    ".woff2"    = "Fonts"
    ".eot"      = "Fonts"
    
    # Configuration Files
    ".ini"      = "Config"
    ".cfg"      = "Config"
    ".conf"     = "Config"
    ".config"   = "Config"
    ".toml"     = "Config"
    ".env"      = "Config"
    
    # Data Files
    ".dat"      = "Data"
    ".log"      = "Data"
    ".temp"     = "Data"
    ".tmp"      = "Data"
    ".backup"   = "Data"
    ".bak"      = "Data"
}

# Create log file with better error handling
$logFile = Join-Path $downloadPath "organizer-log.txt"

try {
    # Ensure downloads path exists
    if (!(Test-Path $downloadPath)) {
        Write-Warning "Downloads folder not found: $downloadPath"
        exit 1
    }
    
    # Add log entry
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content $logFile "`n[$timestamp] Organizer run started."
    
    # Get all files with better error handling
    $files = Get-ChildItem -Path $downloadPath -File -ErrorAction SilentlyContinue
    
    if ($files.Count -eq 0) {
        Add-Content $logFile "No files found to organize."
        Write-Host "No files found to organize in Downloads folder."
        exit 0
    }
    
    $movedCount = 0
    $skippedCount = 0
    $errorCount = 0
    
    foreach ($file in $files) {
        try {
            # Skip the log file itself
            if ($file.Name -eq "organizer-log.txt") {
                continue
            }
            
            $ext = $file.Extension.ToLower()
            
            if ($rules.ContainsKey($ext)) {
                $targetFolder = Join-Path $downloadPath $rules[$ext]
                
                # Create target directory if it doesn't exist
                if (!(Test-Path $targetFolder)) {
                    New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null
                    Add-Content $logFile "Created folder: $($rules[$ext])/"
                }
                
                $destination = Join-Path $targetFolder $file.Name
                
                # Handle file name conflicts
                if (Test-Path $destination) {
                    $counter = 1
                    $nameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                    $extension = $file.Extension
                    
                    do {
                        $newName = "$nameWithoutExt ($counter)$extension"
                        $destination = Join-Path $targetFolder $newName
                        $counter++
                    } while (Test-Path $destination)
                    
                    Add-Content $logFile "Renamed to avoid conflict: $($file.Name) → $newName"
                }
                
                # Move the file
                Move-Item -Path $file.FullName -Destination $destination -Force
                Add-Content $logFile "Moved: $($file.Name) → $($rules[$ext])/"
                $movedCount++
                
            } else {
                # Handle unknown extensions - move to "Other" folder
                $targetFolder = Join-Path $downloadPath "Other"
                
                # Create Other directory if it doesn't exist
                if (!(Test-Path $targetFolder)) {
                    New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null
                    Add-Content $logFile "Created folder: Other/"
                }
                
                $destination = Join-Path $targetFolder $file.Name
                
                # Handle file name conflicts in Other folder
                if (Test-Path $destination) {
                    $counter = 1
                    $nameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                    $extension = $file.Extension
                    
                    do {
                        $newName = "$nameWithoutExt ($counter)$extension"
                        $destination = Join-Path $targetFolder $newName
                        $counter++
                    } while (Test-Path $destination)
                    
                    Add-Content $logFile "Renamed to avoid conflict: $($file.Name) → $newName"
                }
                
                # Move the file to Other folder
                Move-Item -Path $file.FullName -Destination $destination -Force
                Add-Content $logFile "Moved (unknown extension): $($file.Name) → Other/"
                $movedCount++
            }
        }
        catch {
            Add-Content $logFile "Error processing $($file.Name): $($_.Exception.Message)"
            Write-Warning "Error processing $($file.Name): $($_.Exception.Message)"
            $errorCount++
        }
    }
    
    # Summary
    $summary = "Organizer run complete. Moved: $movedCount, Skipped: $skippedCount, Errors: $errorCount"
    Add-Content $logFile $summary
    Write-Host $summary -ForegroundColor Green
    
} catch {
    $errorMsg = "Critical error: $($_.Exception.Message)"
    Add-Content $logFile $errorMsg
    Write-Error $errorMsg
    exit 1
}