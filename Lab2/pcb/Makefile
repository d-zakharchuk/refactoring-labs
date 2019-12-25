all: parser

clean:
	rm -f pcb.yy.cpp pcb.tab.{cpp,hpp} parser example.txt

pcb.yy.cpp: pcb.l
	flex -o pcb.yy.cpp pcb.l

pcb.tab.cpp: pcb.y
	yacc -o pcb.tab.cpp -d pcb.y

parser: pcb.yy.cpp pcb.tab.cpp
	g++ -D_GLIBCXX_USE_CXX11_ABI=0 -w -o parser pcb.yy.cpp pcb.tab.cpp
