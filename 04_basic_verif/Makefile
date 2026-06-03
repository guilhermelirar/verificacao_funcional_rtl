FILES = files.f
SRC_CODE = tb/adderNbit_tb.sv rtl/adderNbit.sv 
TOP ?= adderNbit_tb

build/vlogan.log: $(SRC_CODE)
	mkdir -p build
	cd build && vlogan -kdb -sverilog $(patsubst %,../%,$(SRC_CODE)) -l vlogan.log -q
	
build/vcs.log: build/vlogan.log
	cd build && vcs -kdb -debug_access \
	-Mdir=csrc -o simv $(TOP) -l vcs.log -q 

analyze: build/vlogan.log

elaborate: build/vcs.log

all: analyze elaborate

clean:
	rm -rf build
