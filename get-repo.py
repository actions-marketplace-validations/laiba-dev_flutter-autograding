import sys


def main(argv):
    args = sys.argv
    name = args[1]
    # namearr = name.split('-')
    # namearr.pop()
    name = name.replace(args[2], 'test')
    print(name)


if __name__ == "__main__":
    main(sys.argv[1:])
