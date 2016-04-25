<#	
	.NOTES
		===========================================================================
		Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.119
		Created on:   	4/12/2016 1:11 PM
		Created by:   	June Blender
		Organization: 	SAPIEN Technologies, Inc
		Filename:		*.Help.Tests.ps1
		===========================================================================
	.DESCRIPTION
	Test help for a module. You can run this Tests file from any location. 
    To specify the module to test, enter values for the $ModuleName and $RequiredVersion variables.

	For a help test that is located in a module directory, use https://github.com/juneb/PesterTDD/InModule.Help.Tests.ps1
#>


#Requires -Module @{ModuleName='Pester'; ModuleVersion='3.4.0'}

# Specify the name and version of the module to test
$ModuleName = 'Microsoft.PowerShell.Archive'
$RequiredVersion = '1.0.0.0'

Get-Module $ModuleName | Remove-Module
Import-Module $ModuleName -RequiredVersion $RequiredVersion -ErrorAction Stop
$commands = Get-Command -FullyQualifiedModule @{ ModuleName = $ModuleName;  RequiredVersion=$RequiredVersion}

## When testing help, remember that help is cached at the beginning of each session.
## To test, restart session.

foreach ($command in $commands)
{
	$commandName = $command.Name
	
	Describe "Test help for $commandName" {
		
		# If help is not found, synopsis in auto-generated help is the syntax diagram
		It "should not be auto-generated" {
			(Get-Help $command -ErrorAction SilentlyContinue).Synopsis | Should Not BeLike '*`[`<CommonParameters`>`]*'
		}
		
		# Should be a description for every function
		It "gets description for $commandName" {
			(Get-Help $command -ErrorAction SilentlyContinue).Description | Should Not BeNullOrEmpty
		}
		
		# Should be at least one example
		It "gets example code from $commandName" {
			((Get-Help $command -ErrorAction SilentlyContinue).Examples.Example | Select-Object -First 1).Code | Should Not BeNullOrEmpty
		}
		
		# Should be at least one example description
		It "gets example help from $commandName" {
			((Get-Help $command -Full -ErrorAction SilentlyContinue).Examples.Example.Remarks | Select-Object -First 1).Text | Should Not BeNullOrEmpty
		}
		
		Context "Test parameter help for $commandName" {
			
			$Common = 'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutBuffer', 'OutVariable',
			'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable'
			
			$parameterNames = (Get-Command $command).ParameterSets.Parameters.Name | Sort-Object -Unique | Where-Object { $_ -notin $common }
			foreach ($parameterName in $parameterNames)
			{
				# Should be a description for every parameter
				It "gets help for parameter: $parameterName" {
					(Get-Help $command -Parameter $parameterName -ErrorAction SilentlyContinue).Description.Text | Should Not BeNullOrEmpty
				}
			}
		}
	}
}