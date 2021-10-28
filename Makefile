help:
	@echo "Usage:"
	@echo "    make jupyter-lab"

jupyter-lab:
	./pythonw -m jupyter lab --no-browser --ip 0.0.0.0

