import sys
from itertools import combinations


def reduced(a,b,s):
    return [c for c in s if c == a or c ==b]

def alternated(s):
    return len(set(s[::2])) == 1 and len(set(s[1::2])) == 1

def alternate(s):
    rs = [reduced(a,b,s) for a,b in combinations(set(s), 2)]
    return max([0]+[len(r) for r in rs if alternated(r)])

if __name__ == "__main__":

    lines = sys.stdin.readlines()
    #print("Counted {} lines.".format(len(lines)))
    
    print(alternate(lines[1].rstrip()))
