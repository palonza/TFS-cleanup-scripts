# TFS Cleanup Scripts

I recently moved a large codebase from a Team Foundation Server (TFS) repository to a 
git repository on Visual Studio Team Services. The repository had grown
over the course of many years and had a few structural issues I wanted to address.  
One was some issues with nuGet package restore along with some nuGet libraries checked 
into source control.  Thanks to [Owen Johnson's Powershell scripts](https://github.com/owen2/AutomaticPackageRestoreMigrationScript),
that problem was easy to solve.

The next was ripping out the TFS-specific "stuff" that TFS injected into the SLN and project files. Inspired by Owen's scripts, I wrote a couple
of scripts myself to help clean up all of the project and solution files.

__NOTE__: These scripts are provided "as-is".  They worked out great for me and I've had
no ill effects from removing all of the TFS crap out of my SLN and project files. 

## RemoveTFS-FromSLN.ps1

This script removes the `GlobalSection(TeamFoundationVersionControl)` section in each SLN file.  Nothing fancy -- it's just a simple state machine
that outputs the SLN file line by line but ignores the TFS stuff.

## RemoveTFS-FromProjects.ps1

This script removes 4 nodes in the project files used to indicate a project is under TFS source control -- `SccProjectName`, `SccLocalPath`,
`SccAuxPath` and `SccProvider`.

 