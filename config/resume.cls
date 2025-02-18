\LoadClass[10pt,a4paper]{article}

\def\namesize{\LARGE}
\def\addressSep {-}
\def\addressskip{\par}
\def\sectionlineskip{\medskip} 
\def\nameskip{\smallskip} 
\def\sectionskip{\medskip} 
\def\topicskip{\smallskip}
\def\expertiseskip{\smallskip}

% \def \name#1 {\def\@name{#1}}
\def \name#1 {\def\@name{\textcolor{CustomRed}{#1}}}
\def \@name {}

\def \expertise#1 {\def\@expertise{#1}}
\def \@expertise {}

\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

\def \address #1{
  \@ifundefined{@addressone}{
    \def \@addressone {#1}
  }{
    \@ifundefined{@addresstwo}{
      \def \@addresstwo {#1}
    }{
      \@ifundefined{@addressthree}{
        \def \@addressthree {#1}
      }
    }
  }
}

\let \@topicone \relax
\let \@topictwo \relax
\let \@topicthree \relax

\def\topic#1{
  \@ifundefined{@topicone}{
    \def\@topicone{#1}
  }{
    \@ifundefined{@topictwo}{
      \def\@topictwo{#1}
    }{
      \@ifundefined{@topicthree}{
        \def\@topicthree{#1}
      }{
      }
    }
  }
}

\def \blurb#1 {\def\@blurb{#1}}
\def \@blurb {}

% Missing print functions
% \def\printname{\centerline{\namesize\bfseries \@name}\nameskip}

\def\printname{
  \noindent\hspace{0in}{\namesize\bfseries \@name}\nameskip
}

\def\printaddress#1{\centerline{#1}\addressskip}

\def\printexpertise{
  \@ifundefined{@expertise}{}{
    \ifx\@expertise\empty
    \else
      \centerline{\@expertise}
      \expertiseskip
    \fi
  }
}

\def\printtopic{
  \@ifundefined{@topicone}{}{\centerline{\@topicone}\topicskip}
  \@ifundefined{@topictwo}{}{\centerline{\@topictwo}\topicskip}
  \@ifundefined{@topicthree}{}{\centerline{\@topicthree}\topicskip}
}

\def\printblurb{
  \@ifundefined{@blurb}{}{
    \ifx\@blurb\empty
    \else
      \begin{center}
        \parbox{\textwidth}{%
          \centering
          \@blurb
        }
      \end{center}
      \medskip % Adjust spacing as needed
    \fi
  }
}


\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \printname     % Print the name specified with \name
  \printexpertise % Print the expertise if defined
  \printtopic    % Print the topics if defined
  \@ifundefined{@addressone}{}{\printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{\printaddress{\@addresstwo}}
  \@ifundefined{@addressthree}{}{\printaddress{\@addressthree}}
  \printblurb    % Print the blurb
}

%-------------------------------------------------------------------------------
%	SECTION FORMATTING
%-------------------------------------------------------------------------------

% % Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \pdfbookmark[1]{#1}{#1} % Automatically creates a bookmark
  \sectionskip
  \MakeUppercase {\bf #1} % Section title
    \sectionlineskip
\hrule % Horizontal line
  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{0.5em} % Margin within the section
  }
  \item[]
}{
  \end{list}
}

% Define \Vhrulefill
\newcommand{\Vhrulefill}{%
    \leavevmode{\leaders\hrule height 2.4pt depth -2pt \hfill \kern 0pt}%
}

%-------------------------------------------------------------------------------
%	SUBSECTIONS FORMATTING
%-------------------------------------------------------------------------------
\newenvironment{rSubsection}[4]{ % 4 input arguments - post, year(s), institution, job title, and location
    {#1}\hfill {#2} % post and date on the right
    \ifthenelse{\equal{#3}{}}{}{ % If the third argument is not specified, don't print the job title and location line
        \\
        \textit{#3} \hfill {#4} % Italic job title and location
    }
}{} 

%-------------------------------------------------------------------------------
% OLDER ENVIRONMENT WITHOUT THE LINE AND USING LEFT HAND SIDE SECTION TITLES
%-------------------------------------------------------------------------------
% Command to output section title headings
% \newcommand{\cvsect}[1]{% The only parameter is the section text
%     \vspace{\baselineskip} % Whitespace before the section title
%     \hspace{-0.5in}% Move to the left into the margin
%     \begin{minipage}{1in}
%     \hyphenpenalty=10000
%     \sloppy
%     {\barlow\textcolor{CustomRed}{\textbf{#1}}} % Section title
%     \end{minipage}
%     \vspace{-0.280in} % Adjust space between section title and content
%     % \Vhrulefill % Section title
%     %\newline % Starts a new line after the title and horizontal rule
% }

% Redefines the rSection environment for the large sections within the CV
% \newenvironment{rSection}[1]{ % 1 input argument - section name
%     \cvsect{#1} % Use the cvsect command for the section title
%     %\vspace{-0.275in}
%     %\vspace{0in}
%     % Start of the list for each individual item in the section
%     \begin{list}{}{
%         \setlength{\leftmargin}{0.5in} % Margin within the section
%     }
%     \item[]
% }{
%     \end{list} % End of the list
% }


