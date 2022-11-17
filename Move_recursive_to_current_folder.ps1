
$files = get-childitem -recurse ".\"
foreach ($file in $files)
{
    Move-Item $File.FullName ".\"
    Write-Output $file.FullName
}
