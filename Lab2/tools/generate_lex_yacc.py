import os


def main():
    dataset = ["LOGICAL", "DD1", "DD2", "OWFLW", "BLOCK", "RECORD", "SIZE", "RECFRM", "REL", "SCAN", "DEVICE", "RMNAME",
               "FRSPC", "SEGM", "MINLEN"]
    field = ["NAME", "BYTES", "START", "TYPE"]
    lchild = ["NAME", "PTR", "PAIR", "RULES", "INDEX", "RKSIZE"]
    pcb = ["type", "lterm", "dbdname", "name", "procopt", "altresp", "sametrm", "sb", "keylen", "procseq", "view",
           "pos", "modify", "express", "pcbname", "list"]
    senseg = ["name", "parent", "procopt", "ssptr", "indices"]
    dbd = ["NAME", "ACCESS", "RMNAME", "FRSPC", "PSNAME", "PASSWD", "DATXEXIT", "EXIT", "VERSION"]
    segm = ["NAME", "PARENT", "BYTES", "PTR", "FREQ", "RULES", "EXIT", "DSGROUP", "SSPTR", "COMPRTN", "SOURCE", 
            "RMNAME"]
    xdfld = ["NAME", "SEGMENT", "CONST", "SRCH", "SUBSEQ", "DDATA", "NULLVAL", "EXTRN"]
    psbgen = ["psbname", "lang", "maxq", "cmpat", "ioasize", "ssasize", "ioeropn", "olic", "gsrolbok", "lockmax"]
    senfld = ["name", "start", "replace"]
    generate_lex_attributes(senfld, "senfld")
    generate_yacc_rules(senfld, "senfld")
    print(" ".join([a.upper() for a in senfld]))


def generate_lex_attributes(grammar, grammar_name):
    temp = """\
    {0} {{
        offset += yyleng;
        if (offset > startOfPunchedCard) {{
            BEGIN STR;
        }}
        return {0};
    }}"""
    attributes = [temp.format(a.upper()) for a in grammar]
    attributes_str = "\n".join(attributes)
    write_to_file(attributes_str, "lex_", grammar_name)


def generate_yacc_rules(grammar, grammar_name):
    temp = """{0}'='TERM		{{ $$ = new ParserExpression("{0}", NULL , $3 , true); }}"""
    attributes = [temp.format(a.upper()) for a in grammar]
    attributes_str = "\n|\t".join(attributes)
    write_to_file(attributes_str, "yacc_", grammar_name)


def write_to_file(text, filename, grammar_name):
    root = "tools/out"
    try:
        os.makedirs(root)
    except OSError:
        pass
    with open(os.path.join(root, "{0}{1}.txt".format(filename, grammar_name)), "w", encoding='utf-8') as f:
        f.write(text)


if __name__ == '__main__':
    main()
