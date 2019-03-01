%:
	cd ./cvs/objects/build/linux && $(MAKE) $@

xml:
	cd input/gcamdata && Rscript -e "devtools::load_all('.')" -e "driver(write_output=TRUE, write_xml=TRUE)"
