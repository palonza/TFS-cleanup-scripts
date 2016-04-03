dir -Recurse -Include *.sln | foreach {
    sp $_ IsReadOnly $false
    $lines = [System.IO.File]::ReadAllLines($_)
    $output = $true
    $lines | foreach {
        if( $_.Contains("GlobalSection(TeamFoundationVersionControl)"))
        {
            $output = $false
        }
        if($output)
        {
            $_
        }
        else
        {
            if( $_.Contains("EndGlobalSection"))
            {
                $output = $true
            }
        }
    } | Set-Content $_
    Write-Host Processed $_
}
