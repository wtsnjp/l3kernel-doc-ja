%%
%% This is file `wtpl3doc.cls'.
%%
%% Copyright 2020 Takuto ASAKURA (wtsnjp)
%%   GitHub:   https://github.com/wtsnjp
%%   Twitter:  @wtsnjp
%%
%% This class is distributed under the MIT License.
%%

%% Note: このファイルは日本語文字を含みます.

%% 依存パッケージ
\RequirePackage{expl3,xparse,bxghost,tcolorbox}
\tcbuselibrary{skins,breakable,xparse}

%% クラス宣言
\NeedsTeXFormat{pLaTeX2e}
\ProvidesExplPackage {wtpl3doc} {2020/01/26} {0.1.0}
  {L3 Experimental documentation class for pLaTeX}

%% l3doc を読み込む
\DeclareOption*
  {
    \PassOptionsToClass { \CurrentOption } { l3doc }
  }
\ProcessOptions \scan_stop:
\LoadClass { l3doc }

%% 日本語用設定
\setlength \parindent { 1zh }
\DeclareTextFontCommand { \emph } { \sffamily\gtfamily }

%% 専用マクロ
\NewExpandableDocumentCommand { \eghost } {} { \eghostguarded {} }
\DeclareDocumentCommand { \code } { m }
  { \eghostguarded { \texttt {#1} } }

%% マクロの上書き
\cs_new_eq:NN \__wtpl_codedoc_cmd:nn \__codedoc_cmd:nn
\cs_set_protected:Npn \__codedoc_cmd:nn #1#2
  { \eghostguarded { \__wtpl_codedoc_cmd:nn {#1} {#2} } }

%% 枠
\DeclareTColorBox { texnote } {}
  {
    empty, left=2mm, right=2mm, top=-1mm,
    attach~boxed~title~to~top~left={xshift=1.2zw},
    boxed~title~style={
      empty, left=-1mm, right=-1mm,
    },
    colframe=black, coltitle=black, coltext=black, breakable,  
    underlay~unbroken={
      \draw [black, line~width=.5pt]
        (title.east) -- (title.east-|frame.east) -- (frame.south~east)
          -- (frame.south~west) -- (title.west-|frame.west) -- (title.west);
    },
    underlay~first={
      \draw [black, line~width=.5pt] (title.east) -- (title.east-|frame.east)
        -- (frame.south~east);
      \draw [black, line~width=.5pt] (frame.south~west)
        -- (title.west-|frame.west) -- (title.west);
    },
    underlay~middle={
      \draw [black, line~width=.5pt]
        (frame.north~east) -- (frame.south~east) ;
      \draw [black, line~width=.5pt] (frame.south~west) -- (frame.north~west) ;
    },
    underlay~last={
      \draw [black, line~width=.5pt] (frame.north~east) -- (frame.south~east)
        -- (frame.south~west) -- (frame.north~west) ;
    },
    fonttitle=\sffamily\gtfamily,
    title={\TeX 言語者向けノート},
  }

% vim: ft=expl3 nospell:
%% EOF
