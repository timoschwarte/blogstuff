## requires Office Dev PnP PowerShell. Install according to instructions here: https://github.com/OfficeDev/PnP-PowerShell/

## change if needed
$targetWeb = "http://localhost/sites/teamsite/"
$targetDir = "Upload%20test/subfolder"

## should not need to be changed
$path = "..\subfolder"
$fullPath = (Get-Item $path).FullName
$files = Get-ChildItem -Path $path -Recurse -File

Connect-SPOnline -Url $targetWeb -CurrentCredentials

## upload each file to the directory specified before
foreach($currentFile in $files)
{
	## get relative path of documents
	$relativeDirectory = $currentFile.DirectoryName.Replace($fullPath, "").Replace("\","/")
	$uploadDirectory = $targetDir + $relativeDirectory

	Write-Host "Uploading" $currentFile.Name "to" $uploadDirectory

	Add-SPOFile -Path $currentFile.FullName -Folder $uploadDirectory
}
