$toRemove = @("SccProjectName", "SccLocalPath", "SccAuxPath", "SccProvider")

ls -Recurse -Include *.csproj, *.vbproj | foreach {
    $proj = [xml](Get-Content($_.FullName))
    $ns = New-Object System.Xml.XmlNamespaceManager($proj.NameTable)
    $ns.AddNamespace("ns", $proj.DocumentElement.NamespaceURI)

    $toRemove | foreach {
        $node = $proj.SelectSingleNode("//ns:$_", $ns)
        if( $node )
        {
            $node.ParentNode.RemoveChild($node) | Out-Null
        }
    }
    Write-Host Updating $_.FullName
	sp $_.fullname IsReadOnly $false
    $proj.Save($_.FullName)
}