# programs 
TEX    = latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode --shell-escape" 
XETEX  = latexmk -pdf -pdflatex="xelatex -interaction=nonstopmode --shell-escape" 
PLTEPS = gnuplot -e 'set term tikz'

# figure directory
FIGDIR = fig

# sources
PAPER  = mfi2015_he
PAPER_PRE = ieeeconf.cls
BIBS   = thesis.bib
FIGS   = knock0.png knock1.png knock2.png \
				 push0.png push1.png push2.png \
				 shake0.png shake1.png shake2.png
GPSRC  = mug bottle plastic metal fragile nonempty \
				 knock shake push
SVGSRC = 
TIKZS  = apipe vpipe featurefs decisionfs 
				 
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

.PHONY : clean
clean :
	rm -f $(PAPER).bbl $(PAPER).blg $(PAPER).log $(PAPER).aux \
		$(PAPER).toc $(PAPER).lof $(PAPER).fls $(PAPER).lot $(PAPER).out  $(PAPER).fdb_latexmk \
		$(MIDALL)

