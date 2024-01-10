\LoadClass[11pt,a4paper]{article}

\usepackage[parfill]{parskip}
\usepackage{array}
\usepackage{ifthen}

\def\namesize{\Large}
\def \addressSep {-}
\def\addressskip{\par}
\def\sectionlineskip{\medskip} 
\def\nameskip{\smallskip} 
\def\sectionskip{\medskip} 
\def\topicskip{\smallskip}
\def\expertiseskip{\smallskip}

\def \name#1 {\def\@name{#1}}
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


% Missing print functions
\def\printname{\centerline{\namesize\bfseries \@name}\nameskip}
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

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \printname     % Print the name specified with \name
  \printexpertise % Print the expertise if defined
  \printtopic    % Print the topics if defined
  \@ifundefined{@addressone}{}{\printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{\printaddress{\@addresstwo}}
  \@ifundefined{@addressthree}{}{\printaddress{\@addressthree}}
}

%-------------------------------------------------------------------------------
%	SECTION FORMATTING
%-------------------------------------------------------------------------------

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
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

%-------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%-------------------------------------------------------------------------------

\newenvironment{rSubsection}[4]{ % 4 input arguments - post, year(s) institution, job title and location
 {\bf #1} \hfill {#2} % Bold post and date on the right
 \ifthenelse{\equal{#3}{}}{}{ % If the third argument is not specified, don't print the job title and location line
  \\
  {#3} \hfill { #4} % Italic job title and location
  }
}

