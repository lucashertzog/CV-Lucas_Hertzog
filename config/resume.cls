\LoadClass[11pt,a4paper]{article}

\usepackage[parfill]{parskip}
\usepackage{array}
\usepackage{ifthen}

\def \name#1 {\def\@name{#1}}
\def \@name {}
\def \expertise#1 {\def\@expertise{#1}}
\def \@expertise {}
\def \addressSep {-}

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

% \topic command can be used to set the first, second, and third topic (last 2 optional)
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
        % You can optionally handle more than three topics or print a warning here.
      }
    }
  }
}


% \printtopic is used to print a topic line (given as input)
\def\printtopic#1{
  \begingroup
    \centerline{#1}
  \endgroup
  \topicskip
}

% Missing print functions, assuming some formatting
\def\printname{\centerline{\namesize\bfseries \@name}\nameskip}
\def\printaddress#1{\centerline{#1}\addressskip}
\def\printexpertise{\centerline{\@expertise}\addressskip}

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \printname      % Print the name specified with \name
  \printexpertise % Print the expertise
  \@ifundefined{@topicone}{}{ % Print the first topic if specified
    \printtopic{\@topicone}}
  \@ifundefined{@topictwo}{}{ % Print the second topic if specified
    \printtopic{\@topictwo}}
  \@ifundefined{@topicthree}{}{ % Print the third topic if specified
    \printtopic{\@topicthree}}
  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
  \@ifundefined{@addressthree}{}{ % Print the third address if specified
    \printaddress{\@addressthree}}
}


% ... (rest of the code is unchanged)


% Whitespace after the topic lines
\def\topicskip{\par}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

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

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newenvironment{rSubsection}[4]{ % 4 input arguments - post, year(s) institution, job title and location
 {\bf #1} \hfill {#2} % Bold post and date on the right
 \ifthenelse{\equal{#3}{}}{}{ % If the third argument is not specified, don't print the job title and location line
  \\
  {#3} \hfill { #4} % Italic job title and location
  }
}

% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\namesize{\Large} % Size of the name at the top of the document
\def\addressskip{\par} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section 
\def\nameskip{\smallskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section
\def\topicskip{\smallskip} % The space after the topic
