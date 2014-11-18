% LaTeX very fancy report-based document class
% Author: Zeust the Unoobian
%
% Class options:
%   todo: loads the todonotes package without the disable option
%   EN: uses English versions of any built-in words
%   NL: uses Dutch versions of any built-in words (not yet supported)
%   multiauthor: please specify this if you have multiple authors, it will
%                change "author" to "authors" on the title page
%   multisupervisor: please specify this if you have multiple supervisors, it
%                    will change "supervisor" to "supervisors" on the title page
%   And of course all the options that the standard report class accepts are
%   also accepted
%
% Defined commands for titlepage parameters:
% built-in: \title, \author, \date
% new: \supervisor, \startdate, \finishdate, \reporttype, \organisation,
%      \institute, \coverimg, \bottomleftimg, \bottomrightimg, \subtitle
% \institute refers to your university
% \organisation refers to an organisation that you've been sent to for an
%   internship or similar, and can be omitted if not applicable
% Any image paths are relative to the img/ folder
%
% Also provides a \unnumberedchapter command which is added to the table of
% contents and changes the heading text on pages belonging to that chapter.
% Furthermore a \pseudonumberedchapter command is provided which is a chapter
% that has a number assigned but will not display it in its title. This is
% especially useful for the Conclusion, since this is typically the final
% chapter, should not display a number but still often has sections.
%
% Issues:
% No known way to auto-detect difference between one or multiple authors
% Therefore cannot determine whether to put "author" or "authors" on title page
% Same for supervisor/supervisors
% For the time being the multiauthor and multisupervisor class options exist
% to remedy this

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2014/10/31 v0.1 Modified report class]
\gdef\@taal{EN}
\DeclareOption{NL}{\gdef\@taal{NL}}
\DeclareOption{EN}{\gdef\@taal{EN}}
\gdef\@hastodo{FALSE}
\DeclareOption{todo}{\gdef\@hastodo{TRUE}}
\gdef\@multiauthor{FALSE}
\DeclareOption{multiauthor}{\gdef\@multiauthor{TRUE}}
\gdef\@multisupervisor{FALSE}
\DeclareOption{multisupervisor}{\gdef\@multisupervisor{TRUE}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

\usepackage{tikz}
\usepackage{url}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{subcaption}
\usepackage{fullpage}
\usepackage[hidelinks]{hyperref}
\usepackage{glossaries}
\usepackage{multirow}
\usepackage{fancyhdr}
\usepackage{lastpage}
\usepackage{setspace}
\usepackage{titlesec}
\usepackage{tabularx}
\usepackage{ifthen}

\ifthenelse{\equal{\@taal}{NL}}{\usepackage[dutch]{babel}}{}
\ifthenelse{\equal{\@hastodo}{TRUE}}{\usepackage{todonotes}}{\usepackage[disable]{todonotes}}

% Define a bunch of convenient todo macros
\newcommand{\donetask}[1]{\todo[color=green]{#1}}
\newcommand{\missingref}[2][REF]{[\textcolor{red}{#1?}\todo[color=yellow]{MISSING #1: #2}]}
\newcommand{\badtodo}[1]{\todo[color=red]{#1}}
\newcommand{\missing}[1]{\todo[inline]{MISSING: #1}}
\newcommand{\badmissing}[1]{\todo[color=red,inline]{MISSING: #1}}
\newcommand{\missingchapter}{\missing{CHAPTER}}
\newcommand{\stub}{\todo[inline]{STUB: This chapter may be unfinished}}
\newcommand{\futuremustbepast}{\todo[inline]{This section is referring to the future while by the time the report is handed in it must refer to the past}}

% Command for censoring stuff in preliminary versions of the report
\newcommand{\censored}[1]{\textcolor{red}{[CENSORED]}}

% Command for easier insertion of images
\newcommand{\figcustom}[5]{
	\begin{figure}[#1]
		\centering
		\includegraphics[#2]{img/#4}
		\caption{#5}
		\label{img:#3}
	\end{figure}
}
\newcommand{\fig}[3][1]{\figcustom{bt}{width=#1\textwidth}{#2}{#2}{#3}}
\newcommand{\afig}[3][1]{\figcustom{h!!}{width=#1\textwidth}{#2}{#2}{#3}}

% Command for easier insertion of subfigures
\newcommand{\sfig}[3]{
	\begin{subfigure}{#1\textwidth}
		\includegraphics[width=\textwidth]{img/#2}
		\caption{#3}
		\label{img:subf:#2}
	\end{subfigure}
}
\newcommand{\sfignoc}[2]{
	\begin{subfigure}{#1\textwidth}
		\includegraphics[width=\textwidth]{img/#2}
		\label{img:subf:#2}
	\end{subfigure}
}

%%%%% Formatting %%%%%
% Make fancy layout
\pagestyle{fancyplain}
\fancyhf{}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection. #1}}
\lhead{}
\chead{\Large\MakeUppercase{\leftmark}}
\rhead{}
\lfoot{\rightmark}
\cfoot{}
\rfoot{Page \thepage\ of \pageref{LastPage}}
\setlength{\headheight}{18pt}
\setlength{\headsep}{25pt}
\renewcommand{\footrulewidth}{0.4pt}

% Make consistent but otherwise plain layout on first page of chapter
\fancypagestyle{plain}{%
	\fancyhf{} %
	\renewcommand{\footrulewidth}{0.4pt} %
	\renewcommand{\headrulewidth}{0.4pt} %
	\rfoot{Page \thepage\ of \pageref{LastPage}}
}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}} % Thick horizontal line
% Less whitespace above chapter heading
\titlespacing*{\chapter}{0pt}{-0pt}{20pt}
\titleformat{\chapter}[display]{\normalfont\huge\bfseries}{\chaptertitlename\ \thechapter}{20pt}{\Huge}

% Provide nice symbols for (dis-)advantages in an itemize list
\usepackage{bbding}
\newcommand{\greentickmark}{\textcolor{green}{\textbf{\Checkmark}}}
\newcommand{\lightgreenplus}{\textcolor{green!50!yellow}{\textbf{+}}}
\newcommand{\yellowcircle}{\textcolor{yellow!55!orange}{$\boldsymbol{\circ}$}}
\newcommand{\lightredminus}{\textcolor{orange!65!red}{\textbf{-}}}
\newcommand{\redcross}{\textcolor{red}{\textbf{\XSolidBrush}}}
\newcommand{\itemvgood}{\item[\greentickmark]}
\newcommand{\itemgood}{\item[\lightgreenplus]}
\newcommand{\itemmoderate}{\item[\yellowcircle]}
\newcommand{\itembad}{\item[\lightredminus]}
\newcommand{\itemvbad}{\item[\redcross]}

% Provide command for unnumbered chapters
\newcommand{\unnumberedchapter}[1]{\chapter*{#1\markboth{#1}{}}\addcontentsline{toc}{chapter}{#1}}
\newcommand{\pseudonumberedchapter}[1]{\unnumberedchapter{#1}\stepcounter{chapter}}



% Define additional title parameters
\newcommand{\startdate}[1]{\gdef\@startdate{#1}}
\newcommand{\finishdate}[1]{\gdef\@finishdate{#1}}
\newcommand{\reporttype}[1]{\gdef\@reporttype{#1}}
\newcommand{\organisation}[1]{\gdef\@organisation{#1}}
\newcommand{\institute}[1]{\gdef\@institute{#1}}
\newcommand{\bottomleftimg}[1]{\gdef\@bottomleftimg{#1}}
\newcommand{\bottomrightimg}[1]{\gdef\@bottomrightimg{#1}}
\newcommand{\coverimg}[1]{\gdef\@coverimg{#1}}
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}

% Renew \and command
\renewcommand{\and}{\\}

% Renew maketitle command
\renewcommand{\maketitle}{
	\begin{titlepage}
	\begin{center}
	\@ifundefined{@institute}{~}{\textsc{\LARGE \@institute}}\\[1.5cm]
	\@ifundefined{@reporttype}{}{\textsc{\Large \@reporttype}\\[0.5cm]}
	\@ifundefined{@organisation}{}{\textsc{\Large Organisation: \@organisation}\\[0.5cm]}
	\HRule \\[0.4cm]
	{\huge \bfseries \@title}\\[0.4cm]
	\HRule
	\@ifundefined{@subtitle}{\\[1.0cm]}{\\[0.6cm] \textsc{\Large \@subtitle} \\[0.9cm]}
	\begin{minipage}{\textwidth}
	\@ifundefined{@supervisor}{
		\begin{tabularx}{\textwidth}{X c X}
		& \emph{Author:} &  \\
		& \begin{tabular}{c}\@author\end{tabular} & 
		\end{tabularx}
	}{
		\begin{tabularx}{\textwidth}{X c X c X}
		& \emph{Author\ifthenelse{\equal{\@multiauthor}{TRUE}}{s}{}:} & & \emph{Supervisor\ifthenelse{\equal{\@multisupervisor}{TRUE}}{s}{}:} & \\
		& \begin{tabular}{c}\@author\end{tabular} & & \begin{tabular}{c}\@supervisor\end{tabular} & 
		\end{tabularx}
	}
	\end{minipage}
	\vfill

	\@ifundefined{@coverimg}{}{\includegraphics[width=0.7\textwidth]{img/\@coverimg}}

	\vfill
	\begin{figure}[h!]
		\begin{subfigure}{0.3\textwidth}
			\@ifundefined{@bottomleftimg}{}{\includegraphics[width=\textwidth]{img/\@bottomleftimg}}
		\end{subfigure} \hfill \begin{subfigure}{0.3\textwidth}
			\begin{center}
				\@ifundefined{@startdate}{\@date}{\@ifundefined{@finishdate}{\@date}{{\large \@startdate} \\ {\large --} \\ {\large \@finishdate}}}
			\end{center}
		\end{subfigure} \hfill \begin{subfigure}{0.3\textwidth}
			\@ifundefined{@bottomrightimg}{}{\includegraphics[width=\textwidth]{img/\@bottomrightimg}}
		\end{subfigure}
	\end{figure}
	\end{center}
	\end{titlepage}
}

