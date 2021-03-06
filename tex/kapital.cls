\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kapital}[2017/04/15 Das Kapital]

\LoadClass[11pt, b5paper, final, openany]{memoir}


% 2893px 1889px
% 11.8082 px in mm
\setstocksize{235mm}{155mm}
\settrimmedsize{\stockheight}{\stockwidth}{*}

% 1422px (2190 + 56)px
\settypeblocksize{*}{120.42mm}{1.5795}
% 178px 297px
\setlrmargins{42pt}{*}{*}
% (349 - 56)px 360px
\setulmargins{*}{*}{1.23}
\setfootins{18\p@ \@plus 4\p@ \@minus 4\p@}{\bigskipamount}
\setheaderspaces{*}{13pt}{*}
\checkandfixthelayout

% languages support
\RequirePackage[no-math]{fontspec}
\RequirePackage{polyglossia}
\setmainlanguage{ukrainian}
\setotherlanguage{greek}
\setotherlanguage{german}
\setotherlanguage{english}
% Temporary disable due to franch footnotes
% \setotherlanguage{french}

% similar to [babelshorthands=true]
\newcommand{\dash}{\nobreak-\hskip\z@skip}


\RequirePackage{counters}

%% We move headings one level up
\let\subparagraph\paragraph
\let\paragraph\subsubsection
\let\subsubsection\subsection
\let\subsection\section
\let\section\chapter
\let\chapter\part

\addto\captionsukrainian{\renewcommand{\partname}{Відділ}}
\renewcommand{\thepart}{\UkrNumToName{\value{part}}}

\counterwithout{chapter}{part}

\setsecnumdepth{paragraph}
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{section}. }
\renewcommand{\thesubsection}{\alph{subsection}) }
\renewcommand{\thesubsubsection}{\arabic{subsubsection}. }
\renewcommand{\theparagraph}{\Alph{subsubsection}) }

%% ======
%% Math
%% ======

\RequirePackage{xfrac}
\RequirePackage{amsmath}
\RequirePackage{mathtools}
%% \usepackage{abraces} % do we need it (?)

% braces
\usepackage{tikz}
\usetikzlibrary{hobby}
\tikzstyle{every picture}+=[remember picture]
\tikzstyle{na} = [baseline=-.5ex]

\input{fonts.tex}

%% sfrac
\let\oldsfrac\sfrac
\renewcommand{\sfrac}[2]{\ensuremath{\oldsfrac{#1}{#2}}}

%% fraction in tables
\newcommand{\tbfrac}[2]{\sfrac{\textsf{#1}}{\textsf{#2}}}

%% frac 
%% The latest fixes the linespace in inline fractions
\let\oldfrac\frac
\renewcommand{\frac}[2]{\ensuremath{%
\mathchoice{%
\oldfrac{#1}{#2}}{%
\oldfrac{#1}{%
  \raisebox{1.5pt}{$\scriptstyle #2$}}%
}{%
\oldfrac{#1}{#2}}{%
\oldfrac{#1}{#2}}}%
}

%% oversets
\newcommand{\oversetn}[2]{\overset{\raisebox{-2pt}{$\scriptstyle #1$}}{#2}}
\newcommand{\oversetl}[3]{\oversetn{#1~\tikz[na] \coordinate (#2);}{#3}}
\newcommand{\oversetr}[3]{\oversetn{\tikz[na] \coordinate (#2);~#1}{#3}}


%% split frac
\newcommand{\splitfracm}[2]{<\genfrac{}{}{0pt}{1}{#1}{#2}}
% in text mode
% mathtools contains \splitfrac command
\renewcommand{\splitfrac}[2]{\ensuremath{\splitfracm{#1~}{#2}}}

%% Roman numbers
\newcommand{\RNum}[1]{\uppercase\expandafter{\romannumeral #1\relax}}

%% LSD
\newcommand{\poundsign}[1]{£}
\newcommand{\pound}[1]{\,£}
\newcommand{\usdsign}[1]{\$}
\newcommand{\usd}[1]{\,\$}
\newcommand{\shil}[1]{\,ш.}
\newcommand{\pens}[1]{\,п.}

%% misc
\newcommand{\Red}{\emph{Ред.}}
\newcommand{\stor}{cтор.~}

%% abbr
\newcommand{\abbr}[1]{\mbox{#1}}
\newcommand{\elli}[1]{\mbox{#1}}

%% Duplicate signs
\newcommand\duplicatemath[1]{#1\discretionary{}{\the\textfont0 #1}{}}
\newcommand\duplicate[1]{\relax
\ifmmode
\duplicatemath#1%
\else
\ifhmode\unskip\fi\nobreak\ $\duplicatemath#1$\nobreak%
\fi}

\newcommand{\deq}{\duplicate{=}}
\newcommand{\dplus}{\duplicate{+}}

% Do not break line at mdash
\usepackage{newunicodechar}
\newunicodechar{×}{\duplicate{\times}}
\newunicodechar{—}{\unskip\ifmmode\duplicatemath\minus\else~---\fi}

% linerule
\newcommand{\linerule}[1]{\rule[0.5ex]{#1em}{0.8pt}}

%% ======
%% Rotating + fix
%% https://tex.stackexchange.com/questions/23635/set-up-sidewaysfigure-to-have-the-bottom-of-the-figure-toward-the-spine
%% ======

\usepackage{rotating}

\renewcommand\end@rotfloat{%
   \end{minipage}\end{lrbox}%
   \stepcounter{r@tfl@t}%
   \rot@label{RF\ther@tfl@t}%
   \rot@pageref{RF\ther@tfl@t}{\R@@page}%
   \edef\@tempa{Adding my sideways \@captype\space on page \R@@page\space}
   \rot@mess@toks\expandafter{\@tempa}
   \wd\rot@float@box\z@
   \ht\rot@float@box\z@
   \dp\rot@float@box\z@
   \vbox to \textheight{%
    \setkeys{Grot}{units=360}%
    \if@rot@twoside
    \else
      \let\R@@page\rot@LR
    \fi
    \ifthenelse{\isodd{\R@@page}}{%
      \if@rot@twoside
        \rot@mess@toks\expandafter{\the\rot@mess@toks (my right hand page)}%
      \fi
      \@@line{%
        \hskip\rotFPbot
        \rotatebox{-90}{\box\rot@float@box}%
        \hskip\rotFPtop
      }%
      \vfill      
    }{%
      \if@rot@twoside
        \rot@mess@toks\expandafter{\the\rot@mess@toks (my left hand page)}%
      \fi
      \vfill
      \@@line{%
        \hskip\rotFPtop
        \rotatebox{90}{\box\rot@float@box}%
        \hskip\rotFPbot
      }%
    }%
    \rot@message{\the\rot@mess@toks}
  }%
  \end@float
}

\let\endsidewaysfigure\end@rotfloat
\let\endsidewaystable\end@rotfloat

%% ======
%% Tables
%% ======

\usepackage{caption}
\usepackage{here}
\DeclareCaptionFont{tablefont}{\tablefont}
\captionsetup{font=tablefont, textfont=bf}

\usepackage{makecell}
\usepackage{bigdelim}
\usepackage{multirow}
\usepackage{longtable}
\usepackage{ragged2e}



%% set font
\newcommand{\settablefont}{%
  \sisetup{group-minimum-digits=3,detect-all,text-rm=\tablefont}%
  \tablefont%
}

\AtBeginEnvironment{tabularx}{\settablefont}
\AtBeginEnvironment{tabular}{\settablefont}
\AtBeginEnvironment{longtable}{\settablefont}


%% default hangindent 
\newcommand{\indentdef}{\hspace{1em}}
\newcommand{\hangindentdef}{\hangindent=1em}

%% same width
%% \samewidth{of_what}{text}
\usepackage{calc}
\newcommand{\samewidth}[2]{\makebox[\widthof{#1}][c]{#2}}

%% ditto mark
\newcommand{\dittomark}{>>}
\newcommand{\ditto}[1]{\samewidth{#1}{\dittomark{}}}

%% temp length
\newlength{\myheight}

%% default tabcolsep
\newlength{\tabcolsepdef}
\setlength{\tabcolsepdef}{\tabcolsep}

%% cells
\newcommand{\makevertcell}[2]{
  \rotatebox[origin=c]{90}{\parbox[c]{#1}{#2}}%
}
%% paragrraph cell
\newcommand{\makehangcell}[1]{
 \noindent\parbox[b]{\hsize}{\strut\raggedright\hangindentdef{}#1\strut} %
}

%% hang out of align
\newcommand{\hang}[2]{\makebox[0pt][#1]{#2}}

\newcommand{\md}{\textemdash{}}
\newcommand{\emptycell}{\makecell{\textemdash{}}}

%% caption2
\newcommand{\captionnew}[1]{
{\bfseries\sffamily #1}%
}

%% line color 75%
\definecolor{gray75}{rgb}{0.75, 0.75, 0.75}
\definecolor{darkgray}{rgb}{0.25, 0.25, 0.25}
%% Set table line color
%% see p. 12 http://mirror.datacenter.by/pub/mirrors/CTAN/macros/latex/contrib/booktabs/booktabs.pdf
\newcommand{\CT@arc@}{\color{gray75}}


%% ======
%% Typography
%% ======

\usepackage[all]{nowidow}

\usepackage{microtype} % [tracking=true]
\frenchspacing

% % L e t t e r  s p a c e (\so)
% \RequirePackage{soul} 
% \makeatletter
% \font\SOUL@tt="PTserif"
% \setbox\z@\hbox{\SOUL@tt-}
% \SOUL@ttwidth\wd\z@
% \makeatother

%% no so
\newcommand{\so}[1]{\emph{#1}}

%
% numbers
%
\RequirePackage{siunitx}

%% Book I
\sisetup{
  detect-all,
  input-ignore={.},
  input-decimal-markers={,}
}

% footnotes 
\RequirePackage{bigfoot}

% fix bug in bigfoot 2015/08/30 2.1
% see https://tex.stackexchange.com/questions/471379/footnote-marks-missplaced-with-bigfoot/
\usepackage{xpatch}
\patchcmd\FN@allmarks{266}{256}{}{\fail}


% allow marks to be sans serif
\renewcommand{\@makefnmark}{\hbox{\@textsuperscript{\scriptsize\@thefnmark}\!}}


% 100 note
\DeclareNewFootnote{default}

\counterwithout{footnote}{chapter}
\@addtoreset{footnote}{part}

% ** note
\DeclareNewFootnote{Z}[fnsymbolsingle]
\MakeSortedPerPage{footnoteZ}


% 100a note
\newcounter{footalt}[footnote]
\def\thefootalt{\thefootnote \alph{footalt}}
\def\footnoteA{\refstepcounter{footalt}%
   \Footnotedefault{\thefootalt}}
\def\footnotemarkA{\refstepcounter{footalt}%
   \Footnotemarkdefault{\thefootalt}}
\def\footnotetextA{\Footnotetextdefault{\thefootalt}}

%% fix footnotes on minipage
\renewcommand\thempfootnote{\arabic{footnote}}

\WithSuffix\newcommand\footnote*[1]{\footnoteZ{#1}}

%% continuation marks
\renewcommand\FN@afterbreak{%
\noindent{}\hspace{-1em}\raisebox{-8pt}[0pt][0pt]{\footnotesize{\dots{}}}%
}
% \renewcommand\FN@afterbreak{\begingroup\nobreak%
%   \baselineskip\z@skip \lineskiplimit-\maxdimen%
%   \llap{\hspace{-1em}\dots}%
% \endgroup}

%%
%% https://tex.stackexchange.com/questions/550185/unwanted-vertical-space-with-fnbeforebreak-in-bigfoot
\renewcommand\FN@beforebreak{\begingroup\nobreak%
  \baselineskip\z@skip \lineskiplimit-\maxdimen%
  \rlap{\hspace\textwidth\footnotesize{}~~\dots}%
\endgroup}

%% indexes 
%% hack to prevent warning
\newcommand{\indexchap}[1]{}

\RequirePackage{amsmidx}
\makeindex{franko}
\makeindex{i}
\makeindex{ii}
\makeindex{iii1}
\makeindex{iii2}
\makeindex{complex}

%% fix spacing on index
\let\oldmyindex\index
\renewcommand*{\index}[2]{\unskip\oldmyindex{#1}{#2}}

%% tables index
\AtBeginEnvironment{tabularx}{\index{complex}{table}}
\AtBeginEnvironment{tabular}{\index{complex}{table}}
\AtBeginEnvironment{longtable}{\index{complex}{table}}

%% Breaks
\newcommand{\parbreak}{¬ \emph{(абзац продовжується на наступній сторінці)}}
\newcommand{\parcont}{\noindent \emph{(абзац починається на попередній сторінці) ¶}}

\newcommand{\manualpagebreak}{\newpage}

%% styling
\RequirePackage{style}

%% page numbering
\usepackage{pageslts}

\endinput
