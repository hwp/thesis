TEX    = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode --shell-escape" 
PLOT   = gnuplot -e 'set term svg'

PAPER  = thesis
CHAPS  = 1introduction.tex 2related.tex 3approach.tex \
				 4results.tex 5conclusions.tex appA.tex 
BIBS   = thesis.bib
FIGDIR = fig
PLOTS  = 

PLOTP  = $(foreach p, $(PLOTS), $(FIGDIR)/$(p).svg)

$(FIGDIR)/%.svg : $(FIGDIR)/%.gp
	$(PLOT) $< > $@

.PHONY : pdf 
pdf : $(PAPER).pdf

$(PAPER).pdf : $(PAPER).tex $(CHAPS) $(PLOTP) $(BIBS) $(PLOTP)
	$(TEX) $(PAPER)

.PHONY : clean
clean :
	rm -f *.bbl *.blg *.log *.aux *.toc *.lof *.fls \
		$(FIGDIR)/*.tex  $(FIGDIR)/*.pdf_tex $(FIGDIR)/*.pdf

