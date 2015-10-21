
# How to Write Great Help Examples #

From:   **"Hey, Scripting Guy" Blog**
[http://blogs.technet.com/b/heyscriptingguy/archive/2013/11/02/how-to-write-great-help-examples.aspx](http://blogs.technet.com/b/heyscriptingguy/archive/2013/11/02/how-to-write-great-help-examples.aspx)

2 November 2013

**Summary**: Read these tips to help you write outstanding Windows PowerShell Help.

*Microsoft Scripting Guy, Ed Wilson, is here. Our guest blogger today is June Blender. June is a writer for the Windows Azure AD SDK. She is also a frequent contributor to the Hey Scripting Guy! blog, and for PowerShell.org.*


----------
Examples are the most important element of Windows PowerShell cmdlet Help. Many users skip the narrative and read only the examples for guidance about using the cmdlet. As such, it's important to include as much information in the examples as possible. 

Use the following guidelines when composing your examples:

- Make the first example the simplest, showing the effect of using the cmdlet with only the required parameters. Make subsequent examples increasingly complex. The final example should involve a real world scenario with a series of commands in a pipeline.

- Include all of the parameter names in the command, even when the parameter names are optional. This helps the user interpret the command. Do not use aliases or partial parameter names, even if they work in Windows PowerShell.  

- Demonstrate each of the parameters at least once in the examples, whenever possible. Users who cannot understand the parameter descriptions can often predict the effect of the parameter and the construction of its values from the examples.

- The best examples are instructive; that is, they teach users how to construct their own commands, in addition to providing an example of a particular command. They are templates and models that provide a conceptual framework for the user.

- Don't be clever. Clever examples might elicit admiration, but if the example is difficult to understand, uses many aliases and shortcuts, or is customized for a very specific result, it might not be instructive. Users can cut and paste the command, but they cannot use the command as a template or model for future commands.

- Avoid long one-line commands. Your example will be easier to explain and to read if you perform one operation in each step. If you'd like, end the example by showing how to perform the steps in a one-liner.

- Teach only one concept in each example. Do not clutter the example with multiple concepts, even if they demonstrate a best practice, such as using PSCustomObject or error handling. Instead, demonstrate best practices in a different example.

- Explain the rationale for the construction of the command in the description. Explain why you chose particular parameters and values and how you use variables. If the command uses expressions, explain them in detail.

- If the command uses properties and methods of the object, especially properties that do not appear in the default display, use the example as an opportunity to tell the user about the object. Identify the properties or methods, remind the user that the object has other properties and methods, and tell them how to display and use them. 

The following example demonstrates this.

----------------------------------------------------
This command uses the CSDVersion property of Win32_OperatingSystem to verify that Service Pack 1 is installed:

    PS C:\> (Get-CimInstance Win32_OperatingSystem).CSDVersion
    Service Pack 1
    
CSDVersion is one of many properties of the Win32_OperatingSystem object that Get-CimInstance returns.

To see all of the properties in a list, pipe the object to the Format-List cmdlet, for example:

    PS C:\> Get-CimInstance Win32_OperatingSystem | Format-List –Properties *
    Service Pack 1

--------------------------------------

- Use best practices and use your examples as an opportunity to teach best practices. For example, be sure that your sample commands use approved cmdlet verbs.

- The best examples are realistic. They use the cmdlet and its parameters to solve real-world problems. For example, a Get-Date example might explain how to use the DateTime information from WMI in a Get-Date command, even though the dates and times are in different formats. 

- When using the version-specific parameters of a cmdlet that is included in multiple versions of Windows PowerShell, explain that the parameters are introduced in a specific version of Windows PowerShell. 

For example:

----------
This command displays the Help topic in a separate window. The ShowWindow parameter was introduced in Windows PowerShell 3.0.

    Get-Help –ShowWindow

----------

- Always use general good-writing practices in your examples. Use active voice in example descriptions, avoid fancy verbs (use "get" and "change," not "retrieve" and "modify"), and edit for clarity.
 
 


You really can't have too many examples. If you find an unexpected use for the cmdlet or its parameters, add an example showing how to do it. You might save someone hours of work or inspire someone to try something new.
~June


*Thanks, June! Join me tomorrow when I have a guest blogger who will talk about Windows PowerShell and security.
I invite you to follow me on Twitter and Facebook. If you have any questions, send email to me at [scripter@microsoft.com](mailto:scripter@microsoft.com), or post your questions on the Official Scripting Guys Forum. See you tomorrow. Until then, peace.*

*Ed Wilson, Microsoft Scripting Guy*