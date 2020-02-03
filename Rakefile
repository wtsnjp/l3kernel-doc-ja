# Rakefile for wtsnjp/l3kernel-doc-ja
require 'pathname'

# basics
PKG_NAME = "l3kernel-doc-ja"

# directories
REPO_ROOT = Pathname.pwd
TMP_DIR = REPO_ROOT / "tmp"
BUILD_DIR = TMP_DIR / "build"
TARGET_DIR = TMP_DIR / PKG_NAME

LATEX3_ROOT = Pathname(Dir.home) / "repos/github.com/latex3/latex3"

desc "Remove any temporary products"
task :clean do
  Dir.glob("*.tex").each do |f|
    sh "llmk --clean #{f}", verbose: false
  end
end

desc "Remove any generated files"
task :clobber do
  Dir.glob("*.tex").each do |f|
    sh "llmk --clobber #{f}", verbose: false
  end
end

desc "Setup a new module document file"
task :init, :module do |task, args|
  new_file = REPO_ROOT / "#{args[:module]}-ja.tex"
  fail "File #{new_file} already exists" if new_file.exist?

  src_file = LATEX3_ROOT / "l3kernel/#{args[:module]}.dtx"
  lines = File.open(src_file) {|f| f.read.split("\n")}

  header = <<~'EOF'
    % +++
    % sequence = ["latex", "dvipdf"]
    % latex = "uplatex"
    % clean_files = [
    %   "%B.aux", "%B.dvi", "%B.glo", "%B.hd", "%B.idx", "%B.ind",
    %   "%B.ilg", "%B.log", "%B.out", "%B.synctex.gz",
    % ]
    % +++
    \documentclass[uplatex,dvipdfmx,full,kernel]{wtpl3doc}
    \usepackage{interface3-ja}

    \begin{document}

    %\title{}
    \title{}
    %\author{%
    % The \LaTeX3 Project\thanks
    %   {%
    %     E-mail:
    %       \href{mailto:latex-team@latex-project.org}
    %         {latex-team@latex-project.org}%
    %   }%
    %}
    \author{%
     \LaTeX3プロジェクト\thanks
       {%
         E-mail:
           \href{mailto:latex-team@latex-project.org}
             {latex-team@latex-project.org}%
       }%
    }
    %\date{Released 2020-01-22}
    \date{バージョン 2020-01-22}

    %% !! 本文ここから !!
  EOF
  footer = <<~'EOF'


    %% !! 本文ここまで !!
    \end{document}
  EOF

  doc_part = false
  contents = []
  lines.each do |l|
    if doc_part
      doc_part = false if l == '% \end{documentation}'
      if l.size > 2
        contents << l[2 .. -1]
      elsif l == '%'
        contents << ""
      end
    elsif l == '% \title{^^A'
      contents << '\title{^^A'
      doc_part = true
    end
  end

  doc = header + contents.join("\n") + footer

  File.open(new_file, 'w') {|f| f.puts(doc)}
end
