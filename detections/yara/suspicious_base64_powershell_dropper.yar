rule Suspicious_Base64_PowerShell_Dropper
{
    meta:
        description = "Detects files containing base64-encoded PowerShell often used in droppers"
        author = "soc-home-lab"
        mitre_attack = "T1027, T1059.001"
        date = "2026-07"

    strings:
        $s1 = "FromBase64String" ascii wide
        $s2 = "IEX(" ascii wide
        $s3 = "-EncodedCommand" ascii wide

    condition:
        2 of ($s1, $s2, $s3)
}
