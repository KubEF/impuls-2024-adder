IVERILOG = "iverilog"
VVP = "vvp"

all: run

build:
	git submodule update --init --recursive ; \
	$(IVERILOG) -s add_tb -g2012 -o add_tb add.sv add_tb.sv fpu/adder/adder.v

run: build
	$(VVP) add_tb

clean:
	$(RM) add_tb