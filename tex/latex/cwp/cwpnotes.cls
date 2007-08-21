\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cwpslides}[2007/4/15 v0.1 CWP slides]

\LoadClass[notes]{beamer}
\usefonttheme{structurebold}
          \setbeamerfont{title}        {size=\huge}
          \setbeamerfont{section}      {size=\huge}
          \setbeamerfont{outline}      {size=\huge}
          \setbeamerfont{frametitle}   {size=\huge}
          \setbeamerfont{framesubtitle}{size=\large}
          \setbeamerfont{author}       {size=\Large,     series=\bfseries}
          \setbeamerfont{institute}    {size=\normalsize,series=\bfseries}
          \setbeamerfont{date}         {size=\normalsize,series=\bfseries}

\RequirePackage{ifthen}
\DeclareGraphicsExtensions{.pdf,.png}

% path to figures
\newcommand{\@path}{.}
\newcommand{\inputdir}[1]{\renewcommand{\@path}{#1}}
\providecommand{\figdir}{Fig}
\providecommand{\fig@file}[1]{\@path/\figdir/#1}

% plot command
\newcommand{\plot}[4][htbp]{
  \begin{figure}[#1]
    \centering
    \includegraphics[#3]{\fig@file{#2}}
  \end{figure}
}

% sideplot command
\newcommand{\sideplot}[4][htbp]{
  \begin{figure}[#1]
    \makebox{
      \begin{minipage}{0.4\textwidth}
	#4
      \end{minipage}
      \hfill
      \begin{minipage}{0.6\textwidth}
	\centering
	\includegraphics[#3]{\fig@file{#2}}
    \end{minipage}}
\end{figure}}

% multiplot
\RequirePackage{subfigure}

\def\next@item#1,#2?{#1}
\def\rest@item#1,#2?{#2}
\newcounter{sub@fig}
\newcommand{\multiplot}[5][htbp]{
  \begin{figure}[#1]
    \centering
    \setcounter{sub@fig}{0}
    \edef\list@i{#3}
    \loop
    \edef\item@i{\expandafter\next@item\list@i,\empty?}
    \edef\list@i{\expandafter\rest@item\list@i,\empty?}
    \ifx\item@i\empty
    \else
    \stepcounter{sub@fig}
    \subfigure[]{\includegraphics[#4]{\fig@file{\item@i}}%
      \label{fig:\item@i}
      \label{fig:\@path-\item@i}
    }
    \ifthenelse{\value{sub@fig} = #2}{\\ \setcounter{sub@fig}{0}}{}
    \repeat
%    \caption{#5}
    \label{fig:#3}
    \label{fig:\@path-#3}
  \end{figure}
}

% ------------------------------------------------------------
% generate title page
\newcommand{\cwpcover}{
  \begin{frame}
    \titlepage
  \end{frame}
}

% generate outline slides
\newcommand{\cwpoutline}{
  \AtBeginSection[]{
    \begin{frame}<beamer> \frametitle{}             
      \tableofcontents[currentsection] % highlight current section
    \end{frame}
  }
}

% add note to slides
\def\cwpnote#1{ 
\note{
  \begin{multicols}{2} 
    \tiny{ #1 }
  \end{multicols}
}}

% ------------------------------------------------------------