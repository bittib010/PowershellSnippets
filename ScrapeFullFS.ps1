# To run me, type "powershell.exe -s script.ps1". -s makes it run as system.
# Inspiration from https://github.com/AndrewRathbun/VanillaWindowsReference

# Set the output file path and name
output_file="file-info.csv"

# Set the log file path and name
log_file="errors.log"

# Set the directory path
selected_directory="/path/to/directory"

# Create a new empty array to hold the file and folder information
declare -a file_info

# Get a list of all the files and directories in the selected directory and its subdirectories
items=$(find "$selected_directory" -type f -o -type d)

# Empty fields:
$information = ""
$tags = ""

# Loop through each item
for item in $items; do
  # Check if the item is a file or a directory
  if [ -f "$item" ]; then
    # Item is a file
    # Get the file information
    name=$(basename "$item")
    full_name=$(realpath "$item")
    extension="${name##*.}"
    length=$(stat -c%s "$item")
    attribute=$(stat -c "%a %A" "$item")

    # Calculate the MD5 and SHA256 hashes
    md5=$(md5sum "$item" | awk '{print $1}')
    sha256=$(sha256sum "$item" | awk '{print $1}')

    # Get the file's owner and permissions information
    sddl=$(stat -c "%U:%G %a %n" "$item")
  else
    # Item is a directory
    # Get the directory information
    name=$(basename "$item")
    full_name=$(realpath "$item")
    extension=""
    length=""
    attribute=""
    md5=""
    sha256=""
    sddl=$(stat -c "%U:%G %a %n" "$item")
  fi

  # Add the item information to the file_info array
  file_info+=("$(dirname "$item")" "$information" "$tags" "$name" "$full_name" "$extension" "$length" "$attribute" "$md5" "$sha256" "$sddl")
done

# Export the file and folder information to the CSV file
printf '%s\n' "${file_info[@]}" > "$output_file"
