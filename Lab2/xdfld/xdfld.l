%{
    #include <string>
    #define YYSTYPE std::string
    #include "xdfld.tab.hpp"
    void yyerror(char *s);
    
    char m_invalidEscape[] = "Invalid escape sequence";
    char m_newline[] = "Newline in string literal";
    char m_invalidCharacter[] = "Invalid character";
    
    
    int offset = 0;
    int startOfPunchedCard = 79;
    
%}

%option yylineno
%option noyywrap


%x STR

%%

XDFLD {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return XDFLD;
    }
NAME {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return NAME;
}
SEGMENT {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return SEGMENT;
}
CONST {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return CONST;
}
SRCH {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return SRCH;
}
SUBSEQ {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return SUBSEQ;
}
DDATA {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return DDATA;
}
NULLVAL {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return NULLVAL;
}
EXTRN {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return EXTRN;
}
PUNCHEDCARD {
    return PUNCHEDCARD;
}


[0-9]+          {
    yylval = yytext;
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    } else {
        return NUM;
    }
//    if (yyleng == 8)
//    return PUNCHEDCARD;
//    else

}
[*0-9]+          {
    yylval = yytext;
    offset += yyleng;
    startOfPunchedCard += 80;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    } else {
        BEGIN STR;
    }

}
[a-zA-Z_/][a-zA-Z0-9_/]*('([^']*)')* {
    yylval = yytext;
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    
    return ID;
}
<STR>[^\\\n"]+  {

        ///*
        
        for (int i = 0; i < yyleng; i++) {
            yytext[i] = ' ';
        }
        BEGIN 0;
        //*/
        
        ///*
            //strncat(yyval, yytext, 72);
        //*/
        
        yylval += yytext;
}

<STR>\\n        yylval += '\n';
<STR>\\         yyerror(m_invalidEscape);
<STR>\n         {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }

    for (int i = 0; i < yyleng; i++) {
    yytext[i] = ' ';
    }
    BEGIN 0;
    //yyerror(m_newline);
}
[ \t\r\n]       {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
}; // whitespace
[-{};()<>=+*!,] {
    offset += yyleng;
    if (offset > startOfPunchedCard) {
        BEGIN STR;
    }
    return *yytext;
}
.               yyerror(m_invalidCharacter);

%%
