NAME=installation_guide

. default_target: all

.PHONY: pdf html all

help:
	@echo "help   # Shows this help message"
	@echo "all    # Builds everything"
	@echo "pdf    # Builds the PDF version"
	@echo "html   # Builds the HTML version"
	@echo "clean  # Removes generated files"
	@echo "upload # Uploads files to S3"

all: html pdf

pdf:
	pandoc src/guide.md -o build/${NAME}.pdf -N \
		--variable mainfont=Georgia \
		--latex-engine=xelatex \
		--toc

html:
	pandoc src/guide.md -o build/${NAME}.html \
		--toc --self-contained \
		--template ./template/template.html \
		--css template/bootstrap.css \
		--css template/style.css

clean:
	rm -f build/*

upload: all
	aws s3 sync build s3://opener/installation_guide/
