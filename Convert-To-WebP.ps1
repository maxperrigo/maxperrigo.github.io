# WebP Image Conversion Script for Rental Property Gallery
# This script converts JPG images to WebP format for faster web loading
# Author: Created for Perrigo Rentals Gallery Optimization

param(
    [Parameter(Mandatory=$false)]
    [string]$InputFolder = "",
    
    [Parameter(Mandatory=$false)]
    [string]$OutputFolder = "",
    
    [Parameter(Mandatory=$false)]
    [int]$Quality = 80,
    
    [Parameter(Mandatory=$false)]
    [string]$Size = "1200x800",
    
    [Parameter(Mandatory=$false)]
    [switch]$CreateThumbnails = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$KeepOriginals = $true,
    
    [Parameter(Mandatory=$false)]
    [switch]$Verbose = $false
)

# Function to display colored output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Function to check if ImageMagick is installed
function Test-ImageMagick {
    try {
        $magickVersion = magick -version 2>$null
        if ($magickVersion) {
            Write-ColorOutput "✅ ImageMagick is installed and ready" "Green"
            return $true
        }
    } catch {
        Write-ColorOutput "❌ ImageMagick not found. Please install ImageMagick first." "Red"
        Write-ColorOutput "   Download from: https://imagemagick.org/script/download.php#windows" "Yellow"
        return $false
    }
    return $false
}

# Function to create directory if it doesn't exist
function Ensure-Directory {
    param([string]$Path)
    if (!(Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-ColorOutput "📁 Created directory: $Path" "Cyan"
    }
}

# Function to get user input for folder selection
function Get-FolderPath {
    param(
        [string]$Prompt,
        [string]$DefaultPath = ""
    )
    
    if ($DefaultPath -and (Test-Path $DefaultPath)) {
        $response = Read-Host "$Prompt`n   Default: $DefaultPath`n   Press Enter to use default, or type new path"
        if ([string]::IsNullOrWhiteSpace($response)) {
            return $DefaultPath
        }
        return $response
    } else {
        return Read-Host $Prompt
    }
}

# Function to convert images
function Convert-Images {
    param(
        [string]$Source,
        [string]$Destination,
        [int]$Quality,
        [string]$Size,
        [bool]$CreateThumbs,
        [bool]$Verbose
    )
    
    $jpgFiles = Get-ChildItem -Path $Source -Filter "*.jpg" -File
    $jpegFiles = Get-ChildItem -Path $Source -Filter "*.jpeg" -File
    $allFiles = $jpgFiles + $jpegFiles
    
    if ($allFiles.Count -eq 0) {
        Write-ColorOutput "⚠️  No JPG/JPEG files found in: $Source" "Yellow"
        return
    }
    
    Write-ColorOutput "`n🔄 Converting $($allFiles.Count) images to WebP format..." "Cyan"
    Write-ColorOutput "   Quality: $Quality%" "Gray"
    Write-ColorOutput "   Size: $Size" "Gray"
    Write-ColorOutput "   Output: $Destination" "Gray"
    
    $successCount = 0
    $failCount = 0
    
    foreach ($file in $allFiles) {
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $webpOutput = Join-Path $Destination "$baseName.webp"
        
        try {
            Write-ColorOutput "   Processing: $($file.Name)" "Gray"
            
            # Main WebP conversion
            $magickCommand = "magick `"$($file.FullName)`" -resize `"$Size^`" -gravity center -extent `"$Size`" -quality $Quality -format webp `"$webpOutput`""
            
            if ($Verbose) {
                Write-ColorOutput "   Command: $magickCommand" "DarkGray"
            }
            
            Invoke-Expression $magickCommand
            
            if (Test-Path $webpOutput) {
                $originalSize = [math]::Round($file.Length / 1KB, 1)
                $newSize = [math]::Round((Get-Item $webpOutput).Length / 1KB, 1)
                $savings = [math]::Round((($file.Length - (Get-Item $webpOutput).Length) / $file.Length) * 100, 1)
                
                Write-ColorOutput "   ✅ $($file.Name) → $baseName.webp ($originalSize KB → $newSize KB, $savings% savings)" "Green"
                $successCount++
                
                # Create thumbnail if requested
                if ($CreateThumbs) {
                    $thumbFolder = Join-Path $Destination "thumbnails"
                    Ensure-Directory $thumbFolder
                    $thumbOutput = Join-Path $thumbFolder "$baseName-thumb.webp"
                    
                    $thumbCommand = "magick `"$($file.FullName)`" -resize `"400x300^`" -gravity center -extent `"400x300`" -quality 70 -format webp `"$thumbOutput`""
                    Invoke-Expression $thumbCommand
                    
                    if (Test-Path $thumbOutput) {
                        Write-ColorOutput "   📱 Created thumbnail: $baseName-thumb.webp" "Blue"
                    }
                }
            } else {
                Write-ColorOutput "   ❌ Failed to create: $baseName.webp" "Red"
                $failCount++
            }
        } catch {
            Write-ColorOutput "   ❌ Error processing $($file.Name): $($_.Exception.Message)" "Red"
            $failCount++
        }
    }
    
    # Summary
    Write-ColorOutput "`n📊 Conversion Summary:" "Cyan"
    Write-ColorOutput "   ✅ Successful: $successCount images" "Green"
    if ($failCount -gt 0) {
        Write-ColorOutput "   ❌ Failed: $failCount images" "Red"
    }
    Write-ColorOutput "   💾 WebP files saved to: $Destination" "Yellow"
    
    if ($CreateThumbs) {
        Write-ColorOutput "   📱 Thumbnails saved to: $(Join-Path $Destination 'thumbnails')" "Blue"
    }
}

# Main script execution
Write-ColorOutput "🖼️  WebP Image Conversion Script for Rental Property Gallery" "Cyan"
Write-ColorOutput "=" * 65 "Gray"

# Check if ImageMagick is available
if (!(Test-ImageMagick)) {
    Write-ColorOutput "`n🛑 Cannot proceed without ImageMagick. Please install it first." "Red"
    Read-Host "Press Enter to exit"
    exit 1
}

# Get input folder
if ([string]::IsNullOrWhiteSpace($InputFolder)) {
    Write-ColorOutput "`n📂 Select Input Folder (containing JPG images):" "Yellow"
    $InputFolder = Get-FolderPath "Enter path to folder with JPG images" ".\raw"
}

if (!(Test-Path $InputFolder)) {
    Write-ColorOutput "❌ Input folder does not exist: $InputFolder" "Red"
    Read-Host "Press Enter to exit"
    exit 1
}

# Get output folder
if ([string]::IsNullOrWhiteSpace($OutputFolder)) {
    Write-ColorOutput "`n📁 Select Output Folder (for WebP images):" "Yellow"
    $OutputFolder = Get-FolderPath "Enter path for WebP output" ".\webp"
}

Ensure-Directory $OutputFolder

# Display current settings
Write-ColorOutput "`n⚙️  Current Settings:" "Yellow"
Write-ColorOutput "   Input Folder: $InputFolder" "Gray"
Write-ColorOutput "   Output Folder: $OutputFolder" "Gray"
Write-ColorOutput "   Quality: $Quality%" "Gray"
Write-ColorOutput "   Size: $Size" "Gray"
Write-ColorOutput "   Create Thumbnails: $CreateThumbnails" "Gray"
Write-ColorOutput "   Keep Originals: $KeepOriginals" "Gray"

# Confirm before proceeding
$confirm = Read-Host "`n🚀 Ready to convert images? (Y/n)"
if ($confirm -eq "n" -or $confirm -eq "N") {
    Write-ColorOutput "Operation cancelled by user." "Yellow"
    exit 0
}

# Start conversion
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
Convert-Images -Source $InputFolder -Destination $OutputFolder -Quality $Quality -Size $Size -CreateThumbs $CreateThumbnails -Verbose $Verbose
$stopwatch.Stop()

Write-ColorOutput "`n🎉 Conversion completed in $($stopwatch.Elapsed.TotalSeconds.ToString('F1')) seconds!" "Green"

# Offer to open output folder
$openFolder = Read-Host "`n📁 Open output folder? (Y/n)"
if ($openFolder -ne "n" -and $openFolder -ne "N") {
    Start-Process explorer.exe -ArgumentList $OutputFolder
}

Write-ColorOutput "`n✨ Script completed successfully!" "Green"
Read-Host "Press Enter to exit"