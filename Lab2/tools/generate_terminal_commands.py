def main():
    f = "dataset"
    t = "senfld"
    cmd = commands(f, t)
    print(cmd)


def commands(f, t):
    c = ""
    c += "cp {0}/* . && ".format(f)
    c += "mv {0}.l {1}.l && ".format(f.lower(), t.lower())
    c += "mv {0}.y {1}.y && ".format(f.lower(), t.lower())
    c += "sed -i 's/{0}/{1}/g' Makefile {1}.l && ".format(f.lower(), t.lower())
    c += "sed -i 's/{0}/{1}/g' Makefile {2}.l {2}.y".format(f.upper(), t.upper(), t.lower())
    return c


if __name__ == '__main__':
    main()
