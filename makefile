# programs 
TEX    = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode --shell-escape" 
XETEX    = latexmk -pdf -pdflatex="xelatex -interaction=nonstopmode --shell-escape" 
PLTEPS = gnuplot -e 'set term tikz'

# figure directory
FIGDIR = fig

# sources
PAPER  = thesis
SLIDES = pres
PAPER_PRE = common.sty thesis.sty
SLIDES_PRE = common.sty pres.sty
BIBS   = thesis.bib
FIGS   = uhhLogoL.pdf mug1.jpg mug2.jpg mug3.jpg mug3.jpg \
				 mug4.jpg box1.jpg glass1.jpg mug2v2.jpg mug2m.jpg
GPSRC  = spec256 spec1024 spec64 roc \
				 mug bottle plastic metal fragile nonempty
SVGSRC = 
TIKZS  = hmm vpipe apipe featuref decisionf featurefs decisionfs
				 
# intermediate files
TIKZMI = $(foreach p, $(GPSRC), $(FIGDIR)/$(p).tikz)
PDFMID = $(foreach p, $(SVGSRC), $(FIGDIR)/$(p).pdf)

MIDALL = $(TIKZMI) $(PDFMID)

# all figures 
FIGALL = $(TIKZMI) $(PDFMID) \
				 $(foreach p, $(TIKZS), $(FIGDIR)/$(p).tikz) \
				 $(foreach p, $(FIGS), $(FIGDIR)/$(p))

# rules
$(FIGDIR)/%.tikz : $(FIGDIR)/%.gp
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
		$(SLIDES).bbl $(SLIDES).blg $(SLIDES).log $(SLIDES).aux \
		$(SLIDES).toc $(SLIDES).lof $(SLIDES).fls $(SLIDES).lot $(SLIDES).out  $(SLIDES).fdb_latexmk \
		$(MIDALL)

