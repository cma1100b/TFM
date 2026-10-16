# SPDX-License-Identifier: CC-BY-4.0
#
# Makefile for the documents
#

LATEX       = latexmk
LATEXFLAGS  = -lualatex -interaction=nonstopmode -file-line-error

CFGD        = config
OUTD        = out
OBJD        = build
SRCD        = src

export TEXINPUTS := $(CFGD)//:

SRCS        = $(shell find $(SRCD) -name "*.tex" -type f)
OBJS        = $(SRCS:$(SRCD)/%.tex=$(OBJD)/%.pdf)
STYF        = $(wildcard $(CFGD)/*.sty)

TARGET      = $(OUTD)/main.pdf

.PHONY: all clean

all: $(TARGET)

$(TARGET): main.tex $(OBJS) $(STYF)
	mkdir -p $(dir $@)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OUTD) main.tex

$(OBJD)/%.pdf: $(SRCD)/%.tex $(STYF)
	mkdir -p $(dir $@)
	$(LATEX) $(LATEXFLAGS) -output-directory=$(OBJD) $<

clean:
	$(LATEX) -c
	rm -rf $(OBJD) $(OUTD)
