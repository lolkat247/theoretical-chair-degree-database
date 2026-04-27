#!/usr/bin/env fish

set dir (path dirname (status filename))/latex

# Export EERD from draw.io to PDF when draw.io is available. If not,
# use the checked-in/generated eerd.pdf.
set drawio_cmd ""
if test -x /Applications/draw.io.app/Contents/MacOS/draw.io
    set drawio_cmd /Applications/draw.io.app/Contents/MacOS/draw.io
else if type -q drawio
    set drawio_cmd drawio
end

if test -n "$drawio_cmd"
    $drawio_cmd --export --format pdf --crop --output $dir/eerd.pdf $dir/eerd.drawio 2>/dev/null
    and echo "Exported EERD"
else if test -f $dir/eerd.pdf
    echo "Using existing EERD PDF: $dir/eerd.pdf"
else
    echo "Build failed. No draw.io executable and no existing EERD PDF."
    exit 1
end

# Compile LaTeX twice for references.
pdflatex -interaction=nonstopmode -output-directory=$dir $dir/main.tex > /dev/null 2>&1
and pdflatex -interaction=nonstopmode -output-directory=$dir $dir/main.tex > /dev/null 2>&1
if test $status -eq 0
    echo "Rendered: $dir/main.pdf"
    if test -n "$DISPLAY"; and type -q xdg-open
        xdg-open $dir/main.pdf >/dev/null 2>&1 &
    end
else
    echo "Build failed. Run without redirect to see errors:"
    echo "  pdflatex -output-directory=$dir $dir/main.tex"
    exit 1
end
