LaTeX_thesis
============

A LaTeX document class for good-looking theses and other reports, based on the standard report class.
This document class provides a nice layout, has a redefined \maketitle command with additional options, contains some common includes (including the fullpage package which 
reduces page margins) and provides some convenience functions.

An example document is included with the release.
In future versions this will be replaced with a comprehensive documentational document about the document class.
For now the most important things to know are summarised below:

#Class options
* todo: loads the todonotes package without the disable option
* EN: uses English versions of any built-in words
* NL: uses Dutch versions of any built-in words (not yet supported)
* multiauthor: please specify this if you have multiple authors, it will change "author" to "authors" on the title page
* multisupervisor: please specify this if you have multiple supervisors, it will change "supervisor" to "supervisors" on the title page
* Of course all the options that the standard report class accepts are also accepted

#Defined commands for titlepage parameters
built-in: \title, \author, \date
new (all optional):
* \subtitle
* \supervisor
* \startdate, \finishdate (If both are provided, these will show a date range where otherwise the date would be printed, and \date will be ignored. If only zero or one of \startdate and \finishdate is provided, they are ignored and the date as specified by \date is printed as usual)
* \reporttype: type of report, e.g. bachelor thesis, master thesis etc.
* \institute: institute (usually a university or school) for which you did the work
* \organisation: organisation where you actually performed the work (applicable in the case of e.g. an internship), should be omitted if it's the same organisation you specified in \institute
* \coverimg: cover image
* \bottomleftimg: small image at bottom-left corner of title page, usually the logo of the institute
* \bottomrightimg: small image at bottom-right corner of title page, usually the logo of the organisation specified in \organisation or some government organisation that sponsored your work
Note that any image paths are relative to the img/ folder

#Remarks
This class also provides a \unnumberedchapter command which is added to the table of contents and changes the heading text on pages belonging to that chapter.
Sections of an unnumbered chapter are still wrongly numbered in the current release of this document class.
Furthermore a \pseudonumberedchapter command is provided which is a chapter
that has a number assigned but will not display it in its title and the table of contents.
This is especially useful for the Conclusion, since this is typically the final chapter, should not display a number but still often has sections.

