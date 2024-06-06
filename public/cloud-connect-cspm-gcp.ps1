function Get-FalconHorizonGcpAccount {
<#
.SYNOPSIS
Search for Falcon Horizon GCP accounts
.DESCRIPTION
Requires 'CSPM registration: Read'.
.PARAMETER Id
GCP resource identifier
.PARAMETER ParentType
GCP hierarchy parent type
.PARAMETER ScanType
Scan type
.PARAMETER Status
Account status
.PARAMETER Sort
Property and direction to sort results
.PARAMETER Limit
Maximum number of results per request [default: 100]
.PARAMETER Offset
Position to begin retrieving results
.PARAMETER All
Repeat requests until all available results are retrieved
.PARAMETER Total
Display total result count instead of results
.LINK
https://github.com/crowdstrike/psfalcon/wiki/Get-FalconHorizonGcpAccount
#>
  [CmdletBinding(DefaultParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get',SupportsShouldProcess)]
  param(
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get',Position=1)]
    [Alias('ids')]
    [string[]]$Id,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get',Position=2)]
    [ValidateSet('Folder','Organization','Project',IgnoreCase=$false)]
    [Alias('parent_type')]
    [string]$ParentType,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get',Position=3)]
    [ValidateSet('dry','full',IgnoreCase=$false)]
    [Alias('scan-type')]
    [string]$ScanType,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get',Position=4)]
    [ValidateSet('operational','provisioned',IgnoreCase=$false)]
    [string]$Status,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get',Position=5)]
    [string]$Sort,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get',Position=6)]
    [int32]$Limit,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get')]
    [int32]$Offset,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get')]
    [switch]$All,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:get')]
    [switch]$Total
  )
  begin {
    $Param = @{ Command = $MyInvocation.MyCommand.Name; Endpoint = $PSCmdlet.ParameterSetName }
    [System.Collections.Generic.List[string]]$List = @()
  }
  process {
    if ($Id) { @($Id).foreach{ $List.Add($_) } } else { Invoke-Falcon @Param -UserInput $PSBoundParameters }
  }
  end {
    if ($List) { $PSBoundParameters['Id'] = @($List) }
    Invoke-Falcon @Param -UserInput $PSBoundParameters
  }
}
function Get-FalconHorizonGcpServiceAccount {
<#
.SYNOPSIS
Retrieve service account and email information for a Falcon Horizon GCP service account
.DESCRIPTION
Requires 'CSPM registration: Read'.
.PARAMETER Id
GCP service account identifier
.LINK
https://github.com/crowdstrike/psfalcon/wiki/Get-FalconHorizonGcpServiceAccount
#>
  [CmdletBinding(DefaultParameterSetName='/cloud-connect-cspm-gcp/entities/service-accounts/v1:get',
    SupportsShouldProcess)]
  param(
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/service-accounts/v1:get',
      ValueFromPipelineByPropertyName,ValueFromPipeline,Mandatory,Position=1)]
    [string]$Id
  )
  begin { $Param = @{ Command = $MyInvocation.MyCommand.Name; Endpoint = $PSCmdlet.ParameterSetName }}
  process { Invoke-Falcon @Param -UserInput $PSBoundParameters }
}
function Invoke-FalconHorizonGcpHealthCheck {
<#
.SYNOPSIS
Perform a synchronous health check for a Falcon Horizon GCP parent account
.DESCRIPTION
Requires 'CSPM registration: Write'.
.PARAMETER Id
GCP parent account identifier
.LINK
https://github.com/crowdstrike/psfalcon/wiki/Invoke-FalconHorizonGcpHealthCheck
#>
  [CmdletBinding(DefaultParameterSetName='/cloud-connect-cspm-gcp/entities/account/validate/v1:post',
    SupportsShouldProcess)]
  param(
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/validate/v1:post',Position=0)]
    [Alias('parent_id')]
    [string]$Id
  )
  begin { $Param = @{ Command = $MyInvocation.MyCommand.Name; Endpoint = $PSCmdlet.ParameterSetName }}
  process { Invoke-Falcon @Param -UserInput $PSBoundParameters }
}
function Receive-FalconHorizonGcpScript {
<#
.SYNOPSIS
Download a Bash script which grants Falcon Horizon access using Google Cloud Shell
.DESCRIPTION
Requires 'CSPM registration: Read'.
.PARAMETER Id
GCP resource identifier
.PARAMETER ParentType
GCP hierarchy parent type
.PARAMETER Path
Destination path
.PARAMETER Force
Overwrite an existing file when present
.LINK
https://github.com/crowdstrike/psfalcon/wiki/Receive-FalconHorizonGcpScript
#>
  [CmdletBinding(DefaultParameterSetName='/cloud-connect-cspm-gcp/entities/user-scripts-download/v1:get',
    SupportsShouldProcess)]
  param(
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/user-scripts-download/v1:get',
      ValueFromPipelineByPropertyName,ValueFromPipeline,Position=1)]
    [Alias('ids')]
    [string[]]$Id,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/user-scripts-download/v1:get',
      ValueFromPipelineByPropertyName,Position=2)]
    [ValidateSet('Folder','Organization','Project',IgnoreCase=$false)]
    [Alias('parent_type')]
    [string]$ParentType,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/user-scripts-download/v1:get',Mandatory,
      Position=3)]
    [string]$Path,
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/user-scripts-download/v1:get')]
    [switch]$Force
  )
  begin {
    $Param = @{
      Command = $MyInvocation.MyCommand.Name
      Endpoint = $PSCmdlet.ParameterSetName
      Headers = @{ Accept = 'application/octet-stream' }
      Format = Get-EndpointFormat $PSCmdlet.ParameterSetName
    }
    $Param.Format['Outfile'] = 'path'
    [System.Collections.Generic.List[string]]$List = @()
  }
  process { if ($Id) { @($Id).foreach{ $List.Add($_) }}}
  end {
    if ($List) { $PSBoundParameters['Id'] = @($List) }
    $PSBoundParameters.Path = Assert-Extension $PSBoundParameters.Path 'sh'
    $OutPath = Test-OutFile $PSBoundParameters.Path
    if ($OutPath.Category -eq 'ObjectNotFound') {
      Write-Error @OutPath
    } elseif ($PSBoundParameters.Path) {
      if ($OutPath.Category -eq 'WriteError' -and !$Force) {
        Write-Error @OutPath
      } else {
        Invoke-Falcon @Param -UserInput $PSBoundParameters
      }
    }
  }
}
function Remove-FalconHorizonGcpAccount {
<#
.SYNOPSIS
Remove Falcon Horizon GCP accounts
.DESCRIPTION
Requires 'CSPM registration: Write'.
.PARAMETER Id
GCP resource identifier
.LINK
https://github.com/crowdstrike/psfalcon/wiki/Remove-FalconHorizonGcpAccount
#>
  [CmdletBinding(DefaultParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:delete',
    SupportsShouldProcess)]
  param(
    [Parameter(ParameterSetName='/cloud-connect-cspm-gcp/entities/account/v1:delete',
      ValueFromPipelineByPropertyName,ValueFromPipeline,Position=1)]
    [Alias('ids')]
    [string[]]$Id
  )
  begin {
    $Param = @{ Command = $MyInvocation.MyCommand.Name; Endpoint = $PSCmdlet.ParameterSetName }
    [System.Collections.Generic.List[string]]$List = @()
  }
  process { if ($Id) { @($Id).foreach{ $List.Add($_) }}}
  end {
    if ($List) {
      $PSBoundParameters['Id'] = @($List)
      Invoke-Falcon @Param -UserInput $PSBoundParameters
    }
  }
}