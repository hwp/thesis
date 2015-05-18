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
FIGS   = uhhLogoL.pdf mug2v2.jpg mug2m.jpg \
				 mug2k.png mug2v11.png mug2v21.png mug2v22.png \
				 mug2v23.png mug2v31.png mug2v32.png mug2v33.png \
				 mug2v41.png mug2v42.png object1.jpg object2.jpg \
				 object3.jpg object4.jpg object5.jpg object6.jpg \
				 object7.jpg object9.jpg object10.jpg object11.jpg\
				 object12.jpg object13.jpg object14.jpg \
				 object16.jpg object17.jpg object18.jpg \
				 object19.jpg object20.jpg object21.jpg \
				 object22.jpg object23.jpg object24.jpg \
				 object25.jpg object26.jpg object27.jpg \
				 object28.jpg object29.jpg object30.jpg \
				 object31.jpg object32.jpg object33.jpg \
				 object34.jpg object35.jpg \
				 knock0.png knock1.png knock2.png \
				 push0.png push1.png push2.png \
				 shake0.png shake1.png shake2.png
GPSRC  = spec256 spec1024 spec64 roc \
				 mug bottle plastic metal fragile nonempty \
				 knock shake push
SVGSRC = 
TIKZS  = hmm vpipe apipe featuref decisionf featurefs decisionfs specific generic bow
				 
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

