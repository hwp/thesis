TEX    = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode --shell-escape" 
PLOT   = gnuplot -e 'set term svg'

PAPER  = thesis
BIBS   = thesis.bib
FIGDIR = fig
FIGS   = uhhLogoL.pdf tour_eiffel.jpg turing.jpg themug.jpg mugs.jpg
PLOTS  = 
TIKZS  = hmm

PLOTP  = $(foreach p, $(PLOTS), $(FIGDIR)/$(p).svg) \
				 $(foreach p, $(TIKZS), $(FIGDIR)/$(p).tex) \
				 $(foreach p, $(FIGS), $(FIGDIR)/$(p))

$(FIGDIR)/%.svg : $(FIGDIR)/%.gp
	$(PLOT) $< > $@

.PHONY : pdf 
pdf : $(PAPER).pdf

$(PAPER).pdf : $(PAPER).tex $(PLOTP) $(BIBS) $(PLOTP)
	$(TEX) $(PAPER)

.PHONY : clean
clean :
	rm -f $(PAPER).bbl $(PAPER).blg $(PAPER).log $(PAPER).aux \
		$(PAPER).toc $(PAPER).lof $(PAPER).fls $(PAPER).lot $(PAPER).out \
		$(PAPER).fdb_latexmk \
		$(foreach p, $(PLOTS), $(FIGDIR)/$(p).svg) 

