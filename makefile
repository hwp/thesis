# programs 
TEX    = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode --shell-escape" 
PLOT   = gnuplot -e 'set term svg'

# figure directory
FIGDIR = fig

# sources
PAPER  = thesis
BIBS   = thesis.bib
FIGS   = uhhLogoL.pdf tour_eiffel.jpg turing.jpg themug.jpg mugs.jpg hann.svg hamming.svg
GPSRC  = 
SVGSRC = hann hamming window spec256 spec1024 spec64
TIKZS  = hmm

# temporary files
SVGMID = $(foreach p, $(GPSRC), $(FIGDIR)/$(p).svg)
PDFMID = $(foreach p, $(GPSRC) $(SVGSRC), $(FIGDIR)/$(p).pdf)
# LTXMID = $(foreach p, $(GPSRC) $(SVGSRC), $(FIGDIR)/$(p)pdf_tex)

# all figures 
FIGALL = $(PDFMID) \
				 $(foreach p, $(TIKZS), $(FIGDIR)/$(p).tex) \
				 $(foreach p, $(FIGS), $(FIGDIR)/$(p))

# rules
$(FIGDIR)/%.svg : $(FIGDIR)/%.gp
	$(PLOT) $< > $@

$(FIGDIR)/%.pdf : $(FIGDIR)/%.svg
	inkscape -D -z --file=$< --export-pdf=$@

# targets
.PHONY : pdf 
pdf : $(PAPER).pdf

$(PAPER).pdf : $(PAPER).tex $(BIBS) $(FIGALL)
	$(TEX) $(PAPER)

.PHONY : clean
clean :
	rm -f $(PAPER).bbl $(PAPER).blg $(PAPER).log $(PAPER).aux \
		$(PAPER).toc $(PAPER).lof $(PAPER).fls $(PAPER).lot $(PAPER).out \
		$(PAPER).fdb_latexmk \
		$(SVGMID) $(PDFMID)

