#!/bin/bash

# Enhanced Downloads Folder Organizer - Linux Version
# Addresses common issues and includes comprehensive file type support

# Set downloads path (default to ~/Downloads, can be overridden)
DOWNLOAD_PATH="${1:-$HOME/Downloads}"

# Function to get file extension in lowercase
get_extension() {
    local filename="$1"
    echo "${filename##*.}" | tr '[:upper:]' '[:lower:]'
}

# Function to get filename without extension
get_name_without_ext() {
    local filename="$1"
    echo "${filename%.*}"
}

# Function to log messages
log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
}

# Function to get target folder for extension
get_target_folder() {
    local ext="$1"
    
    case "$ext" in
        # Documents
        pdf) echo "PDFs" ;;
        docx|doc|xlsx|xls|xlsm|pptx|ppt|txt|rtf|odt|ods|odp|csv|md|epub) echo "Documents" ;;
        
        # Images
        jpg|jpeg|png|gif|webp|bmp|tiff|tif|svg|ico|psd|ai|eps|raw|cr2|nef|heic|heif) echo "Images" ;;
        
        # Videos
        mp4|mkv|mov|avi|wmv|flv|webm|m4v|3gp|ogv|mts|vob) echo "Videos" ;;
        
        # Audio
        mp3|wav|flac|aac|ogg|wma|m4a|opus|aiff|au) echo "Audio" ;;
        
        # Archives/Compressed
        zip|rar|7z|tar|gz|bz2|xz|cab|iso) echo "Archives" ;;
        
        # Special handling for compound extensions
        tar.gz|tar.bz2|tar.xz) echo "Archives" ;;
        
        # Executables/Installers
        exe|msi|msix|appx|deb|rpm|pkg|dmg) echo "Installers" ;;
        
        # Code Files
        js|html|htm|css|scss|sass|less|json|xml|yaml|yml|ts|tsx|jsx|vue|php) echo "Code" ;;
        c|cpp|cc|cxx|h|hpp|java|class|jar|py|pyc|pyw|go|rs|rb|pl|swift|kt|scala|r|matlab|sql|db|sqlite) echo "Code" ;;
        
        # Scripts
        sh|bash|zsh|fish|bat|cmd|vbs|applescript) echo "Scripts" ;;
        
        # Mobile Apps
        apk|ipa|xapk) echo "Mobile_Apps" ;;
        
        # 3D Models & Assets
        glb|gltf|obj|fbx|dae|3ds|blend|max|ma|mb|c4d|stl|ply) echo "3D_Models" ;;
        
        # Fonts
        ttf|otf|woff|woff2|eot) echo "Fonts" ;;
        
        # Configuration Files
        ini|cfg|conf|config|toml|env) echo "Config" ;;
        
        # Data Files
        dat|log|temp|tmp|backup|bak) echo "Data" ;;
        
        # Default case
        *) echo "Other" ;;
    esac
}

# Function to handle compound extensions (like .tar.gz)
get_compound_extension() {
    local filename="$1"
    
    # Check for compound extensions
    if [[ "$filename" =~ \.tar\.(gz|bz2|xz)$ ]]; then
        echo "tar.${BASH_REMATCH[1]}"
        return
    fi
    
    # Return regular extension
    get_extension "$filename"
}

# Function to generate unique filename
generate_unique_filename() {
    local target_dir="$1"
    local filename="$2"
    local name_without_ext="$3"
    local extension="$4"
    
    local counter=1
    local new_path="$target_dir/$filename"
    
    while [[ -e "$new_path" ]]; do
        if [[ -n "$extension" ]]; then
            new_path="$target_dir/${name_without_ext} ($counter).$extension"
        else
            new_path="$target_dir/${name_without_ext} ($counter)"
        fi
        ((counter++))
    done
    
    echo "$new_path"
}

# Main script starts here
main() {
    # Initialize variables
    LOG_FILE="$DOWNLOAD_PATH/organizer-log.txt"
    moved_count=0
    skipped_count=0
    error_count=0
    
    # Check if downloads path exists
    if [[ ! -d "$DOWNLOAD_PATH" ]]; then
        echo "Error: Downloads folder not found: $DOWNLOAD_PATH" >&2
        exit 1
    fi
    
    # Start logging
    log_message "Organizer run started."
    
    # Get all files (not directories) in downloads folder
    shopt -s nullglob  # Handle case when no files match
    files=("$DOWNLOAD_PATH"/*)
    
    # Filter out directories and the log file itself
    file_list=()
    for item in "${files[@]}"; do
        if [[ -f "$item" && "$(basename "$item")" != "organizer-log.txt" ]]; then
            file_list+=("$item")
        fi
    done
    
    if [[ ${#file_list[@]} -eq 0 ]]; then
        log_message "No files found to organize."
        echo "No files found to organize in Downloads folder."
        exit 0
    fi
    
    # Process each file
    for file_path in "${file_list[@]}"; do
        filename=$(basename "$file_path")
        
        # Handle compound extensions first
        ext=$(get_compound_extension "$filename")
        target_folder_name=$(get_target_folder "$ext")
        target_folder="$DOWNLOAD_PATH/$target_folder_name"
        
        # Create target directory if it doesn't exist
        if [[ ! -d "$target_folder" ]]; then
            if mkdir -p "$target_folder"; then
                log_message "Created folder: $target_folder_name/"
            else
                log_message "Error creating folder: $target_folder_name/"
                echo "Warning: Could not create folder $target_folder_name/" >&2
                ((error_count++))
                continue
            fi
        fi
        
        # Handle filename conflicts
        if [[ "$ext" =~ ^tar\. ]]; then
            # Special handling for compound extensions like .tar.gz
            name_without_ext="${filename%.tar.*}"
            full_ext="tar.${ext#tar.}"
        else
            name_without_ext=$(get_name_without_ext "$filename")
            full_ext="$ext"
        fi
        
        destination=$(generate_unique_filename "$target_folder" "$filename" "$name_without_ext" "$full_ext")
        
        # Log if filename was changed
        if [[ "$destination" != "$target_folder/$filename" ]]; then
            new_filename=$(basename "$destination")
            log_message "Renamed to avoid conflict: $filename → $new_filename"
        fi
        
        # Move the file
        if mv "$file_path" "$destination"; then
            if [[ "$target_folder_name" == "Other" ]]; then
                log_message "Moved (unknown extension): $filename → $target_folder_name/"
            else
                log_message "Moved: $filename → $target_folder_name/"
            fi
            ((moved_count++))
        else
            log_message "Error moving $filename: Move operation failed"
            echo "Warning: Error moving $filename" >&2
            ((error_count++))
        fi
    done
    
    # Summary
    summary="Organizer run complete. Moved: $moved_count, Skipped: $skipped_count, Errors: $error_count"
    log_message "$summary"
    echo "$summary"
    
    if [[ $error_count -eq 0 ]]; then
        exit 0
    else
        exit 1
    fi
}

# Run main function
main "$@"