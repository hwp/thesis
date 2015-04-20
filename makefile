# programs 
TEX    = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode --shell-escape" 
PLTEPS = gnuplot -e 'set term epslatex size 5,3'

# figure directory
FIGDIR = fig

# sources
PAPER  = thesis
SLIDES = pres
BIBS   = thesis.bib
FIGS   = uhhLogoL.pdf
GPSRC  = spec256 spec1024 spec64
SVGSRC = 
TIKZS  = hmm vpipe apipe featuref decisionf

# intermediate files
TEXMID = $(foreach p, $(GPSRC), $(FIGDIR)/$(p).tex)
EPSMID = $(foreach p, $(GPSRC), $(FIGDIR)/$(p).eps)
PDFMID = $(foreach p, $(SVGSRC), $(FIGDIR)/$(p).pdf)

MIDALL = $(TEXMID) $(EPSMID) $(PDFMID)

# all figures 
FIGALL = $(TEXMID) $(PDFMID) \
				 $(foreach p, $(TIKZS), $(FIGDIR)/$(p).tex) \
				 $(foreach p, $(FIGS), $(FIGDIR)/$(p))

# rules
$(FIGDIR)/%.tex: $(FIGDIR)/%.gp
	$(PLTEPS) -e "set output '$@'" $<
	
$(FIGDIR)/%.pdf : $(FIGDIR)/%.svg
	inkscape -D -z --file=$< --export-pdf=$@

# targets
.PHONY : all pdf slides
all : pdf slides

pdf : $(PAPER).pdf

$(PAPER).pdf : $(PAPER).tex $(BIBS) $(FIGALL)
	$(TEX) $(PAPER)

slides : $(SLIDES).pdf

$(SLIDES).pdf : $(SLIDES).tex $(BIBS) $(FIGALL) beamerthemebjeldbak.sty
	$(TEX) $(SLIDES)

.PHONY : clean
clean :
	rm -f $(PAPER).bbl $(PAPER).blg $(PAPER).log $(PAPER).aux \
		$(PAPER).toc $(PAPER).lof $(PAPER).fls $(PAPER).lot $(PAPER).out  $(PAPER).fdb_latexmk \
		$(SLIDES).toc $(SLIDES).lof $(SLIDES).fls $(SLIDES).lot $(SLIDES).out  $(SLIDES).fdb_latexmk \
		$(MIDALL)

