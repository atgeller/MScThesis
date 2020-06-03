.PHONY: all main clean distclean

#export OUTPUT_DIR ?= $(abspath ./)
# Looks like some pathing in latex doesn't like an alternative outdir
export OUTPUT_DIR = $(abspath ./)
DRAFT ?= false

all: main

main: $(OUTPUT_DIR)/main.pdf

acmart.cls:
	curl http://www.sigplan.org/sites/default/files/acmart/current/acmart.cls -o $@

ACM-Reference-Format.bst:
	curl http://www.sigplan.org/sites/default/files/acmart/current/ACM-Reference-Format.bst -o $@

$(OUTPUT_DIR)/%.pdf: %.tex *.tex Chapters/*.tex Chapters/*/*.tex
ifeq ($(DRAFT), false)
		latexmk -latexoption="-interaction=errorstopmode" -latexoption="-halt-on-error" -auxdir=$(OUTPUT_DIR) -outdir=$(OUTPUT_DIR) -pdf $<
else
		pdflatex -halt-on-error -interaction=errorstopmode -output-directory=$(OUTPUT_DIR) $<
endif

clean:
	latexmk -auxdir=$(OUTPUT_DIR) -outdir=$(OUTPUT_DIR) -pdf -c

distclean: clean
	latexmk -auxdir=$(OUTPUT_DIR) -outdir=$(OUTPUT_DIR) -pdf -C
