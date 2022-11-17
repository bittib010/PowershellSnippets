$files = get-childitem -recurse "C:\Users\Hunting Queries"

foreach ($file in $files)
{
    & .\Create_TF_from_yml.ps1 -Path $file.FullName
}
