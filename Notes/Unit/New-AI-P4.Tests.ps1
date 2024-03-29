Remove-Module -Name $env:BHProjectName -Force -ErrorAction "SilentlyContinue"
Import-Module -Name "$env:BHModulePath\$env:BHProjectName.psm1"

InModuleScope -ModuleName $env:BHProjectName {

	Describe "$env:BHProjectName - Get-AIService" {

		Context "Verifying the function succeeds" {

			Mock Get-AIGender { "Male" }
			Mock Get-AIName { "Ted Hope" }
			Mock Get-AIService { "Test DisplayName" }
			Mock Out-File { }

			$Results = New-AI

			It "Contains a name" {
				$Results.Name | Should Be "Ted Hope"
			}

			It "Contains a gender" {
				$Results.Gender | Should Be "Male"
			}

			It "Contains a service" {
				$Results.Service | Should Be "Test DisplayName"
			}

		}

		Context "Verifying the function fails - Get-AIGender" {

			Mock Get-AIGender { Throw "Failed" }
			Mock Get-AIName { "Ted Hope" }
			Mock Get-AIService { "Test DisplayName" }
			Mock Out-File { }

			It "Get-AIGender fails" {
				{ New-AI } | Should Throw "Failed`nFailed to generate the new AI's gender."
			}

		}

		Context "Verifying the function fails - Get-AIName" {

			Mock Get-AIGender { "Male" }
			Mock Get-AIName { Throw "Failed" }
			Mock Get-AIService { "Test DisplayName" }
			Mock Out-File { }

			It "Get-AIName fails" {
				{ New-AI } | Should Throw "Failed`nFailed to generate the new AI's name."
			}

		}

		Context "Verifying the function fails - Get-AIService" {

			Mock Get-AIGender { "Male" }
			Mock Get-AIName { "Ted Hope" }
			Mock Get-AIService { Throw "Failed" }
			Mock Out-File { }

			It "Get-AIService fails" {
				{ New-AI } | Should Throw "Failed`nFailed to generate the new AI's service."
			}

		}

	}

}