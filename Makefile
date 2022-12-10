filename=main

pdf: ps
	@#ps2pdf ${filename}.ps

pdf-print: ps
	ps2pdf -dColorConversionStrategy=/LeaveColorUnchanged -dPDFSETTINGS=/printer ${filename}.ps

text: html
	html2text -width 100 -style pretty ${filename}/${filename}.html | sed -n '/./,$$p' | head -n-2 >${filename}.txt

html:
	@#latex2html -split +0 -info "" -no_navigation ${filename}
	htlatex ${filename}

ps:	dvi
	dvips -t letter ${filename}.dvi

dvi:
	@echo 1.latex compile * * * * *
	pdflatex ${filename}
	@echo 2.bibtex compile * * * * *
	bibtex ${filename}
	@echo 3.latex compile * * * * *
	pdflatex ${filename}
	@echo 4.latex compile * * * * *
	pdflatex ${filename}

read:
	evince ${filename}.pdf &

aread:
	acroread ${filename}.pdf

clean:
	rm -vf ${filename}.ps
	rm -vf ${filename}.pdf
	rm -vf ${filename}.log
	rm -vf ${filename}.aux
	rm -vf ${filename}.out
	rm -vf ${filename}.dvi
	rm -vf ${filename}.bbl
	rm -vf ${filename}.blg
