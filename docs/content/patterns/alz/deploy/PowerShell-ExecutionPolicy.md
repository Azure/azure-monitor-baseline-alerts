---
title: PowerShell ExecutionPolicy
geekdocHidden: true
---

{{< hint type=Important >}}
Since PowerShell scripts released as part of the ALZ pattern are not digitally signed they might require you to _**temporarily**_ change the execution policy if not already set to _**Unrestricted**_. Before running the script, check the execution policy settings using this command:

```PowerShell
Get-ExecutionPolicy
```

If the result is everything but _**Unrestricted**_, run the following command to change it to **Unrestricted**

```PowerShell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
```

At this point, you should be able to run your scripts with no issues. After you finished, you can set the execution policy back to what it was if you like to do so.

{{< /hint >}}
