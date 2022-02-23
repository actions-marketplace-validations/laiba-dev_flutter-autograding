import sys


def main(argv):
    args = sys.argv
    name = args[1]
    namearr = name.split('-')
    namearr.pop()
    namearr.append('test')
    print('-'.join(namearr))


if __name__ == "__main__":
    main(sys.argv[1:])
