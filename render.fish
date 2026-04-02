#!/usr/bin/env fish

set dir (path dirname (status filename))/latex

# Export EERD from draw.io to PDF
/Applications/draw.io.app/Contents/MacOS/draw.io --export --format pdf --crop --output $dir/eerd.pdf $dir/eerd.drawio 2>/dev/null
and echo "Exported EERD"

# Compile LaTeX (twice for references)
and pdflatex -interaction=nonstopmode -output-directory=$dir $dir/main.tex > /dev/null 2>&1
and pdflatex -interaction=nonstopmode -output-directory=$dir $dir/main.tex > /dev/null 2>&1
and echo "Rendered: $dir/main.pdf"
and open $dir/main.pdf

or echo "Build failed. Run without redirect to see errors:"
and echo "  pdflatex -output-directory=$dir $dir/main.tex"
