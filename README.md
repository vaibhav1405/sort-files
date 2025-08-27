# Downloads Folder Organizer

A comprehensive, cross-platform file organization tool that automatically sorts your Downloads folder into organized subdirectories based on file types. Available for Windows (PowerShell), Linux (Bash), and macOS (Bash with macOS optimizations).

## 🚀 Features

- **Automatic file organization** by type into logical folders
- **Comprehensive file type support** (200+ file extensions)
- **Smart conflict resolution** - automatically renames duplicate files
- **Detailed logging** with timestamps for every operation
- **Cross-platform support** - Windows, Linux, and macOS
- **Error handling** with detailed error reporting
- **Safe operation** - creates backups and handles edge cases
- **Platform-specific optimizations**

## 📁 Folder Structure Created

The organizer creates the following folder structure in your Downloads directory:

```
Downloads/
├── Archives/           # .zip, .rar, .7z, .tar.gz, etc.
├── Audio/              # .mp3, .wav, .flac, .aac, etc.
├── Code/               # .js, .py, .java, .html, .css, etc.
├── Config/             # .ini, .cfg, .json, .xml, etc.
├── Data/               # .log, .dat, .backup, .tmp, etc.
├── Documents/          # .docx, .xlsx, .pptx, .txt, .csv, etc.
├── Fonts/              # .ttf, .otf, .woff, etc.
├── Images/             # .jpg, .png, .gif, .svg, .psd, etc.
├── Installers/         # .exe, .msi, .dmg, .pkg, .deb, etc.
├── Mobile_Apps/        # .apk, .ipa, .xapk
├── Other/              # Files with unknown extensions
├── PDFs/               # .pdf files
├── Scripts/            # .sh, .bat, .ps1, .applescript, etc.
├── Videos/             # .mp4, .mkv, .mov, .avi, etc.
├── 3D_Models/          # .obj, .fbx, .blend, .stl, etc.
└── organizer-log.txt   # Detailed log of all operations
```

### Platform-Specific Additions

**macOS only:**
- `Disk_Images/` - Virtual machine and disk image files

## 🖥️ Platform Versions

### Windows (PowerShell)
- **File**: `downloads_organizer.ps1`
- **Requirements**: Windows PowerShell 5.0+ or PowerShell Core 6.0+
- **Features**: Full Windows file system support

### Linux (Bash)
- **File**: `downloads_organizer.sh`
- **Requirements**: Bash 4.0+
- **Features**: Unix permission handling, case-sensitive filesystem support

### macOS (Bash)
- **File**: `macos_downloads_organizer.sh`
- **Requirements**: macOS 10.10+ with Bash 4.0+
- **Features**: 
  - macOS system file filtering (skips .DS_Store, etc.)
  - Native notification support
  - Finder integration
  - iWork and Xcode file type support

## 📋 Installation & Usage

### Windows (PowerShell)

1. **Download the script**:
   ```powershell
   # Save downloads_organizer.ps1 to your preferred location
   ```

2. **Run the script**:
   ```powershell
   # Navigate to script location
   cd C:\path\to\script
   
   # Run with default Downloads folder
   .\downloads_organizer.ps1
   ```

3. **Optional - Create shortcut**:
   ```powershell
   # Add to PowerShell profile for easy access
   echo 'function Organize-Downloads { & "C:\path\to\downloads_organizer.ps1" }' >> $PROFILE
   ```

### Linux

1. **Download and setup**:
   ```bash
   # Make executable
   chmod +x downloads_organizer.sh
   ```

2. **Run the script**:
   ```bash
   # With default ~/Downloads folder
   ./downloads_organizer.sh
   
   # With custom folder
   ./downloads_organizer.sh /path/to/custom/folder
   ```

3. **Optional - System-wide installation**:
   ```bash
   # Copy to system PATH
   sudo cp downloads_organizer.sh /usr/local/bin/organize-downloads
   sudo chmod +x /usr/local/bin/organize-downloads
   
   # Now you can run from anywhere
   organize-downloads
   ```

### macOS

1. **Download and setup**:
   ```bash
   # Make executable
   chmod +x macos_downloads_organizer.sh
   ```

2. **Run the script**:
   ```bash
   # With default ~/Downloads folder
   ./macos_downloads_organizer.sh
   
   # With custom folder
   ./macos_downloads_organizer.sh /path/to/custom/folder
   ```

3. **Optional - Add to shell profile**:
   ```bash
   # Add to ~/.zshrc (macOS default) or ~/.bash_profile
   echo 'alias organize-downloads="~/path/to/macos_downloads_organizer.sh"' >> ~/.zshrc
   source ~/.zshrc
   ```

## 🔧 Advanced Usage

### Custom Folder Organization

You can modify the file extension rules in each script to customize folder organization:

**Example - Adding new file types**:
```bash
# In the get_target_folder function, add:
customext) echo "Custom_Folder" ;;
```

### Automation

#### Windows (Task Scheduler)
```powershell
# Create scheduled task to run daily
schtasks /create /tn "Organize Downloads" /tr "powershell.exe -File 'C:\path\to\downloads_organizer.ps1'" /sc daily /st 09:00
```

#### Linux/macOS (Cron)
```bash
# Add to crontab for daily organization at 9 AM
crontab -e
# Add line:
0 9 * * * /path/to/downloads_organizer.sh
```

#### macOS (Automator)
1. Open Automator
2. Create new "Application"
3. Add "Run Shell Script" action
4. Paste: `/path/to/macos_downloads_organizer.sh`
5. Save as "Downloads Organizer.app"

## 📊 Supported File Types

### Documents (40+ extensions)
`.pdf`, `.docx`, `.doc`, `.xlsx`, `.xls`, `.pptx`, `.ppt`, `.txt`, `.rtf`, `.csv`, `.md`, `.epub`, `.pages`*, `.numbers`*, `.key`*

### Images (20+ extensions)
`.jpg`, `.jpeg`, `.png`, `.gif`, `.webp`, `.bmp`, `.tiff`, `.svg`, `.psd`, `.ai`, `.raw`, `.heic`, `.heif`

### Videos (15+ extensions)
`.mp4`, `.mkv`, `.mov`, `.avi`, `.wmv`, `.webm`, `.m4v`, `.3gp`, `.ogv`, `.vob`

### Audio (12+ extensions)
`.mp3`, `.wav`, `.flac`, `.aac`, `.ogg`, `.m4a`, `.opus`, `.aiff`, `.caf`*

### Archives (15+ extensions)
`.zip`, `.rar`, `.7z`, `.tar`, `.gz`, `.tar.gz`, `.tar.bz2`, `.iso`, `.sit`*, `.sitx`*

### Code Files (50+ extensions)
`.js`, `.html`, `.css`, `.py`, `.java`, `.cpp`, `.swift`, `.go`, `.php`, `.json`, `.xml`, `.m`*, `.mm`*, `.playground`*

### And many more categories...

*\* Platform-specific file types*

## 📝 Logging

All operations are logged to `organizer-log.txt` in your Downloads folder:

```
[2024-03-15 14:30:15] Organizer run started.
[2024-03-15 14:30:15] Created folder: Images/
[2024-03-15 14:30:15] Moved: vacation_photo.jpg → Images/
[2024-03-15 14:30:15] Renamed to avoid conflict: document.pdf → document (2).pdf
[2024-03-15 14:30:15] Moved: document (2).pdf → PDFs/
[2024-03-15 14:30:16] Organizer run complete. Moved: 15, Skipped: 2, Errors: 0
```

## 🛡️ Safety Features

- **Non-destructive**: Only moves files, never deletes
- **Conflict resolution**: Automatically renames duplicates
- **System file protection**: Skips important system files (especially macOS)
- **Comprehensive logging**: Track every operation
- **Error handling**: Graceful failure with detailed error messages
- **Dry-run support**: Check what would happen (modify scripts to add `echo` before `mv`/`Move-Item`)

## 🔍 Troubleshooting

### Common Issues

**Permission Denied (Linux/macOS)**:
```bash
chmod +x script_name.sh
```

**PowerShell Execution Policy (Windows)**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Script not found**:
- Ensure you're in the correct directory
- Use full path to script

**Files not moving**:
- Check file permissions
- Verify Downloads folder exists
- Check log file for detailed errors

### Getting Help

1. Check the log file (`organizer-log.txt`) for detailed error information
2. Ensure you have proper permissions for the Downloads folder
3. Verify the script has execute permissions (Linux/macOS)
4. Test with a small number of files first

## 🤝 Contributing

Feel free to:
- Add support for new file types
- Improve platform-specific features
- Enhance error handling
- Add new organization categories

## 📄 License

These scripts are provided as-is for personal and educational use. Modify and distribute freely.

---

**Note**: Always backup important files before running any automated organization script for the first time.