# Compile main.pdf with bibtex (3-pass cross-ref resolution).
# `make`        produces main.pdf
# `make check`  runs the RTSC-claim attestation hook (PAPERS/_tools/check_rtsc_claim.sh)
# `make figs`   regenerates figures/*.pdf from figures/_scripts/*.py
# `make clean`  removes intermediates (keeps PDF)

DOC = main
LATEX = pdflatex -interaction=nonstopmode -halt-on-error
BIBTEX = bibtex
CHECK_RTSC = ../_tools/check_rtsc_claim.sh
PYTHON = python3

FIG_PDFS = figures/fig01_transient_series.pdf

.PHONY: all check figs clean distclean

all: check $(DOC).pdf

check:
	@bash $(CHECK_RTSC) .
	@echo "[paper] check_rtsc_claim PASS"

figs: $(FIG_PDFS)

figures/fig01_transient_series.pdf: figures/_scripts/fig01_transient_series.py
	$(PYTHON) figures/_scripts/fig01_transient_series.py

$(DOC).pdf: $(DOC).tex references.bib $(FIG_PDFS)
	$(LATEX) $(DOC).tex
	$(BIBTEX) $(DOC) || true
	$(LATEX) $(DOC).tex
	$(LATEX) $(DOC).tex
	@echo "[paper] $(DOC).pdf built at $$(date '+%Y-%m-%d %H:%M:%S')"

clean:
	rm -f $(DOC).aux $(DOC).bbl $(DOC).blg $(DOC).log $(DOC).out \
	      $(DOC).toc $(DOC).synctex.gz
	@echo "[paper] intermediates cleaned (PDF preserved)"

distclean: clean
	rm -f $(DOC).pdf
