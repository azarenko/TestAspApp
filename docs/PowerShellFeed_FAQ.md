Sitecore PowerShell Public NuGet Feed
====================================

Sitecore distributes PowerShell modules as NuGet packages.  Here are the answers to some of the most frequently asked questions about using Sitecore PowerShell modules.

| Question                                                              | Answer                                                                                                                     |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| What is the URL of the PowerShell NuGet feed?                                    | `https://sitecore.myget.org/F/sc-powershell/api/v2`                                                                        |
| When are the packages available?                                      | We intend to make packages available as soon as possible.  Packages may be released more frequently then platform updates. |
| What about hotfixes?                                                  | Only major, minor and patch releases will be made following [Semver] principles.                                            |
| Will there be a private feed for MVPs who get the release early?      | We have no plans for a seperate MVP feed yet.                                                                              |
| What about external references?                                       | Packages with dependencies to external content will install those dependencies whenever possible.                          |
| What is actually in the packages?                                     | Packages are built to conform to the requirements for [PowerShellGet]                                                      |
| Where is the Sitecore license for PowerShell modules hosted on MyGet? | You can find the license file here: [Sitecore MyGet License Agreement][License].                                                      |
| What about support?                                                   |                                                                                                                        |
How do I register the PowerShell NuGet repository?
------------------------------------------------

To install Sitecore PowerShell modules, you must register the PowerShell NuGet repository. You only need to register the repository only once.

To register the PowerShell NuGet repository:

1. Launch PowerShell as an administrator.
1. In the PowerShell command line, run the following cmdlet:
    ```PowerShell
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2
    ```
    Repositories are registered as _untrusted_ by default and you must therefore approve every module that you want to install.

3. To register your repository as trusted and automatically approve the installation of any module, run the following cmdlet:
    ```PowerShell
    Set-PSRepository -Name SitecoreGallery -InstallationPolicy Trusted
    ```

How do I install a module?
-------------------------

After you register the repository, you can use it to install modules.

For example, to install the _SitecoreInstallFramework_ module:

1. Launch PowerShell as an administrator.
1. In the PowerShell command line, run the following cmdlet:
    ```PowerShell
    Install-Module -Name SitecoreInstallFramework -Repository SitecoreGallery
    ```
    Modules are installed for all users by default.
    To install the module for the current user only, append `-Scope CurrentUser` to the previous cmdlet.


How do I update a module?
--------------------------

New versions of the modules are pushed to the same repository. You can then update the module to get the latest version.

For example, to update the _SitecoreInstallFramework_ module:
1. Launch PowerShell as an administrator.
1. In the PowerShell command line, run the following cmdlet:
    ```PowerShell
    Update-Module SitecoreInstallFramework
    ```



[Semver]: https://semver.org/spec/v2.0.0.html
[PowerShellGet]: https://docs.microsoft.com/en-gb/powershell/module/powershellget/?view=powershell-5.1
[License]: https://doc.sitecore.net/~/media/C23E989268EC4FA588108F839675A5B6.pdf