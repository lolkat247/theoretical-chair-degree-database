#!/usr/bin/env fish

set dir (path dirname (status filename))/latex

pdflatex -interaction=nonstopmode -output-directory=$dir $dir/main.tex > /dev/null 2>&1
and pdflatex -interaction=nonstopmode -output-directory=$dir $dir/main.tex > /dev/null 2>&1
and echo "Rendered: $dir/main.pdf"
and open $dir/main.pdf

or echo "Build failed. Run without redirect to see errors:"
and echo "  pdflatex -output-directory=$dir $dir/main.tex"
