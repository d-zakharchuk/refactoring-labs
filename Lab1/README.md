#Lab 1: Lex&Yacc calculator
### Install requirements
<code>sudo apt-get install gcc flex bison</code>
<br><br>
<code>\# bison -d calc1.y produces calc1.tab.c<br>
\# bison -y -d calc1.y produces y.tab.c (the standard yacc output) <br>
\# for calc1 and calc2, you may have to <br>
\# include the following in the lex ".l" file: <br>
\#    extern int yylval;

#### \#calc1
bison -y -d calc1.y <br>
flex calc1.l <br>
gcc -c y.tab.c lex.yy.c <br>
gcc y.tab.o lex.yy.o -o calc1
#### \#calc2
bison -y -d calc2.y <br>
flex calc2.l <br>
gcc -c y.tab.c lex.yy.c <br>
gcc y.tab.o lex.yy.o -o calc2

#### \#calc3
bison -y -d calc3.y <br>
flex calc3.l <br>
gcc -c y.tab.c lex.yy.c <br>
gcc y.tab.o lex.yy.o calc3a.c -o calc3a <br>
gcc y.tab.o lex.yy.o calc3b.c -o calc3b<br>
gcc y.tab.o lex.yy.o calc3g.c -o calc3g
</code>

You can find all these commands in the [build shell script](build).
## Run
<code>./calc2</code>