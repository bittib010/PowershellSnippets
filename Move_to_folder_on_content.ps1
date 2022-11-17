get-childitem .\ -filter *.yaml -recurse| select-string -list -pattern "kind: Scheduled" | Move-Item -dest .\Scheduled


get-childitem .\ -filter *.yaml -recurse| select-string -list -pattern "kind: NRT" | Move-Item -dest .\NRT
