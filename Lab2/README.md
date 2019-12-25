# Lab 2: Parser
### Install requirements
<code>sudo apt-get install g++ make flex bison</code>

## How to run
<code>cp dataset/* .<br>
make<br>
cat input | ./parser
</code>

## How to make parser for other commands
(pcb parser based on dataset parser)<br><br>
<code>cp dataset/* .<br>
mv dataset.l pcb.l<br>
mv dataset.y pcb.y<br>
sed -i 's/dataset/pcb/g' Makefile pcb.l<br>
sed -i 's/DATASET/PCB/g' Makefile pcb.l pcb.y
</code>

You can generate these terminal commands using [tools/generate_terminal_commands.py](tools/generate_terminal_commands.py).<br>

Take a look at the attribute grammar. <br>
Check [grammar/dbd-gram-mi.txt](grammar/dbd-gram-mi.txt) for DATASET grammar. <br>
Check [grammar/psb-gram-mi.txt](grammar/psb-gram-mi.txt) for PCB grammar. <br>
    
    dataset: [dataset-name:*label* => symbol!  
        "DATASET"
    [ "DD1"    "="    dataset-dd1      => key-value  
    | "DD2"    "="    dataset-dd2      => key-value  
    | "OWFLW"  "="    dataset-owflw    => key-value        
    | "BLOCK"  "="    dataset-block    => key-value
    | "RECORD" "="    dataset-record   => key-value
    | "SIZE"   "="    dataset-size     => key-value
    | "RECFRM" "="    dataset-recfrm   => key-value
    | "REL"    "="    dataset-rel      => key-value
    | "SCAN"   "="    dataset-scan     => key-value
    | "DEVICE" "="    dataset-device   => key-value
    | "RMNAME" "="    dataset-rmname   => key-value
    | "FRSPC"  "="    dataset-frspc    => key-value
    | "SEGM"   "="    dataset-segm     => key-value
    | "MINLEN" "="    dataset-minlen   => key-value
    | "LOGICAL"   
    | ","  
    ]+ ""
       dataset-eline:*eol*=>symbol ;

    -----------------------------------------------------
    pcb-unit::= pcb-head => pcb [sens => sens-stm] * "" ;  
    pcb::= [pcb-label: *label* => symbol]! 
	"pcb"
    [
       "type"    "=" pcb-type     => key-value
     | "lterm"   "=" pcb-lterm    => key-value
     | "dbdname" "=" pcb-dbdname  => key-value
     | "name"    "=" pcb-name     => key-value
     | "procopt" "=" pcb-procopt  => key-value
     | "altresp" "=" pcb-altresp  => key-value
     | "sametrm" "=" pcb-sametrm  => key-value
     | "sb"      "=" pcb-sb       => key-value
     | "keylen"  "=" pcb-keylen   => key-value
     | "procseq" "=" pcb-procseq  => key-value
     | "view"    "=" pcb-view     => key-value
     | "pos"     "=" pcb-pos      => key-value
     | "modify"  "=" pcb-modify   => key-value
     | "express" "=" pcb-express  => key-value
     | "pcbname" "=" pcb-pcbname  => key-value
     | "list"    "=" pcb-list     => key-value
     | ","
     ] + ""
	pcb-eol :*eol*=>symbol ;

Open **pcb.l** file and  replace DATASET attributes with PCB attributes. <br>
For example, replace

    DD1 {
        offset += yyleng;
        if (offset > startOfPunchedCard) {
            BEGIN STR;
        }
       return DD1;
    }
with:

    TYPE {
        offset += yyleng;
        if (offset > startOfPunchedCard) {
            BEGIN STR;
        }
       return TYPE;
    }
You can easily do this using [tools/generate_lex_yacc.py](tools/generate_lex_yacc.py) with the 
folowing command: <br>
<code>python3 tools/generate_lex_yacc.py</code> <br>
It will produce a txt file with attributes inside <code>tools/out</code> directory. <br>

Open **pcb.y** file and find the following lines:

    %token DD1 DD2 OWFLW BLOCK RECORD SIZE RECFRM REL SCAN DEVICE RMNAME FRSPC SEGM MINLEN LABEL LOGICAL PCB PUNCHEDCARD
    %token STAR_EXPR NUM ID
    
    %type<str> STAR_EXPR NUM ID PCB LOGICAL PUNCHEDCARD
    %type<oper> OPS TERM ARG LIST_OP OP PCB_MAIN_OP LABEL_RULE
    %type<expr> DD1 DD2 OWFLW BLOCK RECORD SIZE RECFRM REL SCAN DEVICE RMNAME FRSPC SEGM MINLEN 
    %type<args> ARGS

Replace <code>DATASET</code> attributes with <code>PCB</code> attributes. <br>

    %token TYPE LTERM DBDNAME NAME PROCOPT ALTRESP SAMETRM SB KEYLEN PROCSEQ VIEW POS MODIFY EXPRESS PCBNAME LIST LABEL PCB PUNCHEDCARD
    %token STAR_EXPR NUM ID
    
    %type<str> STAR_EXPR NUM ID PCB PUNCHEDCARD
    %type<oper> OPS TERM ARG LIST_OP OP PCB_MAIN_OP LABEL_RULE
    %type<expr> TYPE LTERM DBDNAME NAME PROCOPT ALTRESP SAMETRM SB KEYLEN PROCSEQ VIEW POS MODIFY EXPRESS PCBNAME LIST 
    %type<args> ARGS
Be careful! The first <code>%token</code> should contain <code>LABEL PCB PUNCHEDCARD</code> tokens. <br>
Attributes like <code>LOGICAL</code> from **Dataset** should be added to <code>%type\<str\></code>section. <br>
Don't forget to remove <code>LOGICAL</code> attribute from <code>PCB.y</code> Yacc file.<br> 
Take a look at the **Yacc** grammar rules.<br>
Replace <code>DATASET</code> grammar rules<br>

    OP: DD1'='TERM			{ $$ = new ParserExpression("DD1", NULL , $3 , true); }
    |	DD2'='TERM		{ $$ = new ParserExpression("DD2", $3, NULL, true); }
    |	OWFLW'='TERM		{ $$ = new ParserExpression("OWFLW", $3, NULL, true); }
    |	BLOCK'='TERM		{ $$ = new ParserExpression("BLOCK", $3, NULL, true); }
    |	RECORD'='TERM		{ $$ = new ParserExpression("RECORD", $3, NULL, true); }
    |	SIZE'='TERM		{ $$ = new ParserExpression("SIZE", $3, NULL, true); }
    |	RECFRM'='TERM		{ $$ = new ParserExpression("RECFRM", $3, NULL, true); }
    |	REL'='TERM		{ $$ = new ParserExpression("REL", $3, NULL, true); }
    |	SCAN'='TERM		{ $$ = new ParserExpression("SCAN", $3, NULL, true); }
    |	DEVICE'='TERM		{ $$ = new ParserExpression("DEVICE", $3, NULL, true); }
    |	RMNAME'='TERM		{ $$ = new ParserExpression("RMNAME", $3, NULL, true); }
    |	FRSPC'='TERM		{ $$ = new ParserExpression("FRSPC", $3, NULL, true); }
    |	SEGM'='TERM		{ $$ = new ParserExpression("SEGM", $3, NULL, true); }
    |	MINLEN'='TERM		{ $$ = new ParserExpression("MINLEN", $3, NULL, true); }
    ;
with <code>PCB</code> grammar rules:<br>

    OP:     TYPE'='TERM		{ $$ = new ParserExpression("TYPE", NULL , $3 , true); }
    |	LTERM'='TERM		{ $$ = new ParserExpression("LTERM", $3, NULL, true); }
    |	DBDNAME'='TERM		{ $$ = new ParserExpression("DBDNAME", $3, NULL, true); }
    |	NAME'='TERM		{ $$ = new ParserExpression("NAME", $3, NULL, true); }
    |	PROCOPT'='TERM		{ $$ = new ParserExpression("PROCOPT", $3, NULL, true); }
    |	ALTRESP'='TERM		{ $$ = new ParserExpression("ALTRESP", $3, NULL, true); }
    |	SAMETRM'='TERM		{ $$ = new ParserExpression("SAMETRM", $3, NULL, true); }
    |	SB'='TERM		{ $$ = new ParserExpression("SB", $3, NULL, true); }
    |	KEYLEN'='TERM		{ $$ = new ParserExpression("KEYLEN", $3, NULL, true); }
    |	PROCSEQ'='TERM		{ $$ = new ParserExpression("PROCSEQ", $3, NULL, true); }
    |	VIEW'='TERM		{ $$ = new ParserExpression("VIEW", $3, NULL, true); }
    |	POS'='TERM		{ $$ = new ParserExpression("POS", $3, NULL, true); }
    |	MODIFY'='TERM		{ $$ = new ParserExpression("MODIFY", $3, NULL, true); }
    |	EXPRESS'='TERM		{ $$ = new ParserExpression("EXPRESS", $3, NULL, true); }
    |	PCBNAME'='TERM		{ $$ = new ParserExpression("PCBNAME", $3, NULL, true); }
    |	LIST'='TERM		{ $$ = new ParserExpression("LIST", $3, NULL, true); }
    ;


<code>python3 tools/generate_lex_yacc.py</code> also produces **Yacc** grammar rules.

Please, check your parser for the following input (depends on grammar):

    CD2      DATASET DD1=CDED2,                                            *00720000
                   DEVICE=3350,FRSPC=(99,10),BLOCK=6140,SCAN=0              00730000
               
When there are many attributes, they don't fit in a single 80-char string. <br>
To fix this, place STAR "*" symbol at the 72th position of the line, and 
continue with other attributes on the next line.<br>
##Issues
- Both <code>DATASET</code> and <code>PCB</code> include <code>LABEL RULE</code>.
- Need to remove <code>LABEL RULE</code> for grammars that don't have <code>LABEL RULE</code>.
- When removing <code>LABEL RULE</code>, also remove <code>MAIN_OP</code>.
- DO NOT place the newline symbol <code>\n</code> at the end of <code>input</code> file.
- <code>SEGM</code> parser problem with grammar rule <code>RULES(,HERE)</code>
- <code>PSBGEN</code> parser problem with parsing symbol <code>/</code>
- <code>XDFLD</code> parser problem with parsing symbol <code>/</code> and text between quotes <code>' '</code>

### Solution for <code>SEGM</code>
+ Open Yacc file **segm.y**
+ Find Yacc grammar rules under <code>ARGS</code> section


    ARGS:                                   { }
    |       ARG                             { $$ = new ParserExpression($1, true, false, true); }
    |       ARG ',' ARGS                    { $$ = new ParserExpression($1, true, false, false, $3); }
+ Add this rule:

       | ',' ARGS { $$ = new ParserExpression($2, true, false, false, true); }
### Solution for <code>PSBGEN, XDFLD</code>
+ Open Lex file **psbgen.l, xdfld.l**.
+ Find **ID** token regex
    
    
    [a-zA-Z_][a-zA-Z0-9_]* {
        yylval = yytext;
        offset += yyleng;
        if (offset > startOfPunchedCard) {
            BEGIN STR;
        }    
        return ID;
    }
+ modify the regex to include <code>/</code> symbol as follows: <br>
<code>[a-zA-Z_/][a-zA-Z0-9_/]* </code>
+ find regex for other symbols


    [-{};()<>=+*/!,] {
        offset += yyleng;
        if (offset > startOfPunchedCard) {
            BEGIN STR;
        }
        return *yytext;
    }
+ remove <code>/</code> symbol from this regex.
### Solution for <code>XDFLD</code>
+ Perform steps described under section **Solution for <code>PSBGEN, XDFLD</code>**
+ Add quotes matching pattern to **ID** token regex as follows:<br>
    
    
    [a-zA-Z_/][a-zA-Z0-9_/]*('([^']*)')* {
        yylval = yytext;
        offset += yyleng;
        if (offset > startOfPunchedCard) {
            BEGIN STR;
        }   
        return ID;
    }
