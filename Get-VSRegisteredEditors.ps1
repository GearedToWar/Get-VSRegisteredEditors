function CreateEditorObject()
{      
    return [PSCustomObject] @{     
        "EditorTypeGuid"="";
        "Name"="";
        "DeferUntilIntellisenseIsReady"="";
        "PackageGuid"="";
        "TrustLevel"=""
    }
}

$editors = VsRegEdit.exe enum local HKLM Editors
foreach ($ed in $editors)
{
    #VsRegEdit.exe enum local HKLM $ed
    $name = $(VsRegEdit.exe read local HKLM $ed `"`" string)

    if ($name.StartsWith("Failed"))
    {
        $name = ""
    }
    else
    {
        $name = $name.Substring($name.LastIndexOf(':') + 1)
    }

    $duiir = $(VsRegEdit.exe read local HKLM $ed DeferUntilIntellisenseIsReady dword)

    if ($duiir.StartsWith("Failed"))
    {
        $duiir = ""
    }
    else
    {
        $duiir = $duiir.Substring($duiir.LastIndexOf(':') + 1)
    }

    $packageGuid = $(VsRegEdit.exe read local HKLM $ed Package string)

    if ($packageGuid.StartsWith("Failed"))
    {
        $packageGuid = ""
    }
    else
    {
        $packageGuid = $packageGuid.Substring($packageGuid.LastIndexOf(':') + 1)
    }

    $trustLevel = $(VsRegEdit.exe read local HKLM $ed EditorTrustLevel dword)

    if ($trustLevel.StartsWith("Failed"))
    {
        $trustLevel = ""
    }
    else
    {
        $trustLevel = $trustLevel.Substring($trustLevel.LastIndexOf(':') + 1)
    }

    $editorObject = CreateEditorObject
    $editorObject.EditorTypeGuid = $ed.Substring(8)
    $editorObject.Name = $name
    $editorObject.DeferUntilIntellisenseIsReady = $duiir
    $editorObject.PackageGuid = $packageGuid
    $editorObject.TrustLevel = $trustLevel

    $editorObject
}
