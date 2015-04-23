# programs 
TEX    = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode --shell-escape" 
XETEX    = latexmk -pdf -pdflatex="xelatex -interaction=nonstopmode --shell-escape" 
PLTEPS = gnuplot -e 'set term epslatex size 5,3'

# figure directory
FIGDIR = fig

# sources
PAPER  = thesis
SLIDES = pres
PAPER_PRE = common.sty thesis.sty
SLIDES_PRE = common.sty pres.sty
BIBS   = thesis.bib
FIGS   = uhhLogoL.pdf
GPSRC  = spec256 spec1024 spec64
SVGSRC = 
TIKZS  = hmm vpipe apipe featuref decisionf featurefs decisionfs

# intermediate files
TEXMID = $(foreach p, $(GPSRC), $(FIGDIR)/$(p).tex)
EPSMID = $(foreach p, $(GPSRC), $(FIGDIR)/$(p).eps)
PDFMID = $(foreach p, $(SVGSRC), $(FIGDIR)/$(p).pdf)

MIDALL = $(TEXMID) $(EPSMID) $(PDFMID)

# all figures 
FIGALL = $(TEXMID) $(PDFMID) \
				 $(foreach p, $(TIKZS), $(FIGDIR)/$(p).tikz) \
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

$(PAPER).pdf : $(PAPER).tex $(PAPER_PRE) $(BIBS) $(FIGALL)
	$(TEX) $(PAPER)

slides : $(SLIDES).pdf

$(SLIDES).pdf : $(SLIDES).tex $(SLIDES_PRE) $(BIBS) $(FIGALL)
	$(XETEX) $(SLIDES)

.PHONY : clean
clean :
	rm -f $(PAPER).bbl $(PAPER).blg $(PAPER).log $(PAPER).aux \
		$(PAPER).toc $(PAPER).lof $(PAPER).fls $(PAPER).lot $(PAPER).out  $(PAPER).fdb_latexmk \
		$(SLIDES).toc $(SLIDES).lof $(SLIDES).fls $(SLIDES).lot $(SLIDES).out  $(SLIDES).fdb_latexmk \
		$(MIDALL)

