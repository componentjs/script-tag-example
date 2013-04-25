
build: components
	@component build

components:
	@component install

clean:
	@rm -fr components

.PHONY: clean
