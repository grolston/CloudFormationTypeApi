IPMO AWSPowerShell.NetCore
$Resources = Get-CFNTypeList -Type Resource -Visibility PUBLIC -Filters_Category AWS_Types | Select TypeName
$resourcetypejson = $Resources.TypeName | ConvertTo-JSON
$resourcetypejson | out-file resourcetypes.json -Encoding utf8

$i =1
mkdir -p ./output
Foreach ($resource in $Resources){
  $resourceName = $resource.TypeName
  $fileName = $resourceName.replace('::', '-')
  $JsonObj = $(Get-CFNType -TypeName $resourceName -Type Resource).Schema
  $JsonObj | Out-File ./output/$fileName.json -Encoding utf8
  Write-Host "completed $i of $($resources.count)…"
  if($i % 10  -eq 0) {write-host "throttling 5 seconds"; sleep 5}
  $i++
}
