document=poster
PDFLATEX=pdflatex -synctex=1 -interaction=nonstopmode -file-line-error -pdf

pdf:
	${PDFLATEX} ${document}
	bibtex ${document}
	${PDFLATEX} ${document}
	${PDFLATEX} ${document}

clean:
	for suffix in .ps .log .aux .out .dvi .bbl .blg -blx.bib .run.xml .synctex.gz ; do \
		rm -f ${document}$$suffix ; \
	done