---
title: PowerShell Execution Policy
geekdocHidden: true
---

{{< hint type=Important >}}
To execute the PowerShell scripts provided in the ALZ pattern, you may need to _**temporarily**_ modify the execution policy if it is not set to _**Unrestricted**_. Check the current execution policy by running the following command:

```PowerShell
Get-ExecutionPolicy
```

If the execution policy is not _**Unrestricted**_, change it to **Unrestricted** by running:

```PowerShell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
```

After executing your scripts, you can revert the execution policy to its original setting if needed.

{{< /hint >}}
