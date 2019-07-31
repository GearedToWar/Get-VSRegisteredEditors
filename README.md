# Get-VSRegisteredEditors
PowerShell script to read the editor registration information for a VS installation

## Usage
### Output information on the console
* .\Get-VSRegisteredEditors.ps1 | ft -AutoSize

### Save information in an excel file
* .\Get-VSRegisteredEditors.ps1 | Export-Csv Editors.xlx -Delimiter `t -NoTypeInformation
