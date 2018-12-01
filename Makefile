filename=deedy_resume-openfont

pdf:
	latexdockercmd.sh xelatex --jobname=thiago_almeida_devops_$(shell date +"%Y%m") ${filename} && \
	latexdockercmd.sh xelatex --jobname=thiago_almeida_devops_$(shell date +"%Y%m") ${filename}

text: html
	latexdockercmd.sh html2text -width 100 -style pretty \
	${filename}/${filename}.html | sed -n '/./,$$p' | head -n-2 >${filename}.txt

html:
	@#latex2html -split +0 -info "" -no_navigation ${filename}
	latexdockercmd.sh htlatex ${filename}

view:
	while inotifywait --event modify,move_self,close_write ${filename}.tex; \
		do latexdockercmd.sh xelatex -halt-on-error --jobname=thiago_almeida_devops_$(shell date +"%Y%m") ${filename} && \
		latexdockercmd.sh xelatex -halt-on-error --jobname=thiago_almeida_devops_$(shell date +"%Y%m") ${filename}; done

clean:
	rm -f *.{ps,pdf,log,aux,out,dvi,bbl,blg,snm,toc,nav,html,txt}
