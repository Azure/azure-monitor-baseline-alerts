---
title: PowerShell ExecutionPolicy
geekdocHidden: true
---

{{< hint type=Important >}}
To run PowerShell scripts provided in the ALZ pattern, you may need to _**temporarily**_ change the execution policy if it is not set to _**Unrestricted**_. Verify the current execution policy by executing the following command:

```PowerShell
Get-ExecutionPolicy
```

If the current execution policy is not set to _**Unrestricted**_, execute the following command to change it to **Unrestricted**:

```PowerShell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
```

After running your scripts, you may revert the execution policy to its original setting if desired.

{{< /hint >}}
