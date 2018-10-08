%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% poster.cls
%
% Document class to produce posters with KTH logo.
% 
% Mats Bengtsson, 28/5 2002
%
% Incompatible change: Added environment rutor to
% set the number of columns. Mats 29/7 2002
%
% Renamed to KTHEEposter and modified to adhere somewhat more to the
% graphical profile. Mats Bengtsson, 7/8 2006. 
%
% Renewed layout, reimplemented using tikz instead of pstricks, added
% possibility to add extra logotype. Mats Bengtsson April 2011 - July 2012
%
% Latest version of the KTH logo. Mats Bengtsson, 2/4 2014.
%
% Modified and modernized by Manuel Olguín, October 2018.
% - Changed environment names to english.
% - Rewrote maketitle to be able to correctlty add an additional logo.
% - General formatting changes.
% - Option for changing colors
% - Option for adding additional logo4
% - changed inner workings to use tcolorbox!
% - Added additional frame type with border but without shadows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{KTHEEposter}[2014/04/02 -- EE Poster]


% Default size: A0
\newcommand{\p@persize}{a0}
% Handle A1 paper as well: 
\DeclareOption{a1}{\renewcommand{\p@persize}{a1}}
\DeclareOption{A1}{\renewcommand{\p@persize}{a1}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{a0poster}}
\ProcessOptions
\LoadClass[\p@persize]{a0poster}

\RequirePackage{graphicx}
\RequirePackage[margin=1in, hcentering, vcentering]{geometry}
%\RequirePackage[dvips]{color}
\RequirePackage{fancybox}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}
\tcbuselibrary{breakable}
\tcbuselibrary{raster}

%\RequirePackage{pstricks,pst-node}
\RequirePackage{tikz}
\RequirePackage{multicol}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{anyfontsize}
\RequirePackage{libertine}
\RequirePackage{libertinust1math}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{sourcecodepro}

\setcounter{secnumdepth}{0} % Turn off section numbers
\tikzstyle{every picture}+=[remember picture] % Make it possible to
                                % draw arrows between different frames

\newcommand{\kthlogo}[1]{\def\kthl@g@{#1}}
\newcommand{\extralogo}[1]{\def\extral@g@{#1}}
\newcommand{\kthcolor}[1]{\def\kthc@l@r{#1}}

\newlength{\tmpl@ngth}

%\newcmykcolor{KTHblue}{1 0.55 0 0}
\definecolor{KTHblue}{cmyk}{1 0.55 0 0}
%\newcmykcolor{KTHred}{0 1 0.65 0.23}
\definecolor{KTHred}{cmyk}{0 1 0.65 0.23}


%\parskip 2cm

\renewcommand{\maketitle}{
    \pagestyle{empty}%
    \setlength{\parindent}{0pt}%
    %\setlength{\tmpl@ngth}{15mm-\hoffset-.85in-\oddsidemargin}%
    \noindent\mbox{}\hspace*{\tmpl@ngth}%
    %\parbox[t][130mm]{\paperwidth-30mm}{%
    \begin{minipage}{\linewidth}
        \noindent%
        %\hfill%
        \begin{minipage}{.2\linewidth}
            \raggedright
            \includegraphics[width=.7\linewidth]{Logo/\kthl@g@}
        \end{minipage}%
        \hfill%
        \begin{minipage}{.6\linewidth}
            \begin{center}
                {\Huge\bfseries
                \@title \\[1.5cm]}
                {\LARGE\@author}
            \end{center}
        \end{minipage}%
        \hfill%
        \begin{minipage}{.2\linewidth}
            \raggedleft
            \ifthenelse{\isundefined{\extral@g@}}%
            {\includegraphics[width=.7\linewidth]{Logo/\kthl@g@}}%
            {\includegraphics[width=.7\linewidth]{\extral@g@}}
        \end{minipage}%
        %\hfill%    
    \end{minipage}%
    %}%
}

\newlength{\innerH}
\newlength{\offset}
\newlength{\spacersz}
\setlength{\spacersz}{20mm}

\newenvironment{pcolumns}[1][2]{%
    \newenvironment{pcolumn}[1][2]{%
        % calculate offset based on number of frames - 1
        \setlength{\offset}{##1\spacersz}%
        \addtolength{\offset}{-1.0\spacersz}%        
        \newenvironment{pframe}[1][1]{% frame with border and shadow!
            \begin{tcolorbox}[enhanced,
                height=####1\innerH,
                sharp corners, 
                colframe=\kthc@l@r, 
                colback=white, 
                opacityback=1.0, 
                opacitybacktitle=1.0, 
                opacityframe=1.0,
                shadow={20mm}{-20mm}{0mm}{black!50!white},
                borderline={20pt}{-20pt}{\kthc@l@r}]%
                %\fontsize{35}{43}\normalfont%
        }{%
            \end{tcolorbox}
        }%
        \newenvironment{pframe*}[1][1]{% frame with border, but no shadow!
            \begin{tcolorbox}[enhanced,
                height=####1\innerH,
                sharp corners, 
                colframe=\kthc@l@r, 
                colback=white, 
                opacityback=1.0, 
                opacitybacktitle=1.0, 
                opacityframe=1.0,
                %shadow={20mm}{-20mm}{0mm}{black!50!white},
                borderline={20pt}{-20pt}{\kthc@l@r}]%
                %\fontsize{35}{43}\normalfont%
            }{%
            \end{tcolorbox}
        }%
        \newenvironment{pframe**}[1][1]{% frame without border or shadow!
            \begin{tcolorbox}[enhanced,
                height=####1\innerH,
                sharp corners, 
                colframe=\kthc@l@r, 
                colback=white, 
                opacityback=1.0, 
                opacitybacktitle=1.0, 
                opacityframe=0.0,
                %shadow={20mm}{-20mm}{0mm}{black!50!white},
                %borderline={20pt}{-20pt}{\kthc@l@r}]%
                ]
                %\fontsize{35}{43}\normalfont%
            }{%
            \end{tcolorbox}
        }%
        \begin{tcboxedraster}[raster columns=1,
            raster rows=##1,
            raster row skip=\spacersz,
            raster valign=top,
            colframe=white,
            sharp corners]{blankest, height fill, width=\linewidth}%
            \setlength{\innerH}{\tcbtextheight - \offset}%
            \setlength{\innerH}{\innerH/##1}%
            
    }{%
        \end{tcboxedraster}
    }
    \noindent%
    \begin{tcbraster}[raster columns=#1,
        raster before skip=.025\paperheight,
        raster rows=1,
        raster column skip=\spacersz,
        raster valign=top,
        raster equal height=rows,
        sharp corners]%
}{%
    \end{tcbraster}%
}
  