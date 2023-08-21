BIBTEX=biber
LATEX=xelatex -interaction nonstopmode -halt-on-error -file-line-error -shell-escape
READER=zathura
SHELL=/bin/zsh

SRC=rl-2023.tex
PDF=$(SRC:.tex=.pdf)
TMP=$(wildcard *.aux *.bbl *.bcf *.blg *.dvi *.log *.nav *.out *.ps *.fls *.listing *.glo *.idx *.run.xml *.snm *.tns *.toc *.vrb)
SVG=$(wildcard figures/*.svg)
FIG_PDF=$(SVG:.svg=.pdf)
GENFIG=$(FIG_PDF:figures/%=genfig/%)

all: $(GENFIG) $(SRC)
	$(LATEX) $(SRC)
	$(BIBTEX) $(SRC:.tex=)

genfig/%.pdf: figures/%.svg
	inkscape -C -z --file=$< --export-pdf=$@

clean:
	-@rm -f $(PDF) $(TMP)

open:
	$(READER) $(PDF) &

install-ubuntu:
	sudo apt install texlive-xetex texlive-fonts-extra texlive-bibtex-extra

watch:
	while [ 1 ]; do; inotifywait $(SRC) $(SVG); make; done
