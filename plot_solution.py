import argparse
import json
import numpy as np

# import seaborn as sns
import networkx as nx
import matplotlib.pyplot as plt
import matplotlib as mpl


def fatal_error(msg):
    print(f"\x1b[31;1m[FATAL]\x1b[0m {msg}")
    quit(1)


def eval_solution(permu, C, s):
    s_total = np.sum(s)  # total length of the program
    n = s.shape[0]  # length of solutions

    f = 0  # initialize fitness value
    for i in range(n - 1):
        for j in range(i + 1, n):
            # compute the amount of calls from i->j and j->i
            c_ij = C[permu[i]][permu[j]]
            c_ji = C[permu[j]][permu[i]]

            # distance from i to j in the program
            s_ij = np.sum(s[permu[i : (j + 1)]])

            f += (c_ij + c_ji) * (s_total - s_ij)
    return f


parser = argparse.ArgumentParser(description="PGO-CO solution visualization")

parser.add_argument(
    "-i",
    "--instance",
    metavar="INST",
    nargs=1,
    required=True,
    type=str,
    help="Path to the input instance",
)
parser.add_argument(
    "-f",
    "--function",
    metavar="FN",
    nargs=1,
    required=True,
    type=str,
    help="Name of the function to visualize",
)
parser.add_argument(
    "-s",
    "--solution",
    metavar="SOL",
    nargs=1,
    required=False,
    type=str,
    help="The solution to visualize. If not provided, identity is used",
)


args = parser.parse_args()

## read and parse the input instance
inst_path = args.instance[0]
f = open(inst_path, "r")
instance = json.loads(f.read())
f.close()

## get the data of the function to visualize
func_name = args.function[0]
if func_name in instance:
    c = np.array(instance[func_name]["c"])
    s = np.array(instance[func_name]["s"])
    n = s.shape[0]
else:
    fatal_error(
        f"invalid function {func_name}, valid functions are: {', '.join(instance.keys())}."
    )

## parse or generate the solution to visualize
if args.solution == None:
    solution = np.arange(n, dtype=int)
else:
    try:
        solution = [int(v) for v in args.solution[0].strip("][").split(",")]
    except Exception as e:
        fatal_error(f"Failed to convert solution to list:\n\n\t{e}")


def weighted_call_graph():
    G = nx.DiGraph()
    s_total = np.sum(s)
    dist_labels = {}
    for i in range(n):
        G.add_node(i)
        for j in range(i + 1, n):
            v = c[i][j]
            d = np.sum(s[solution[i : (j + 1)]])
            dist_labels[(i, j)] = d
            # larger means stronger attractive force (thus the rest)
            G.add_edge(i, j, weight=v, distance=(s_total - d))
    pos = nx.spring_layout(G, k=n, weight="distance", iterations=100)
    nx.draw(G, pos, with_labels=True)
    nx.draw_networkx_edge_labels(G, pos, edge_labels=dist_labels)


def block_layout(permu, C, s):
    s_total = np.sum(s)
    n = s.shape[0]

    f = []
    for elem in permu:
        accum = 0
        for j in range(n):
            # compute the amount of calls from i->j and j->i
            c_ij = C[permu[elem]][permu[j]]
            c_ji = C[permu[j]][permu[elem]]

            if elem == j:
                s_ij = 0
            elif j > elem:
                s_ij = np.sum(s[permu[elem : (j + 1)]])
            else:
                s_ij = np.sum(s[permu[j : (elem + 1)]])

            accum += (c_ij + c_ji) * (s_total - s_ij)
        f.append(accum)

    sizes = np.log(np.array(s))
    sizes /= sizes.max()
    print(sizes)
    colors = plt.cm.BuPu(sizes)

    plt.bar(range(n), f, 0.8, align="center", log=False, color=colors)
    fitness = eval_solution(solution, C, s)
    plt.title(f"Block layout (fitness: {fitness})")
    # plt.ylabel('Call frequency (log scale)')
    plt.ylabel("Call frequency")
    plt.xlabel("Block")
    plt.xticks(range(n), permu)
    plt.colorbar(mpl.cm.ScalarMappable(norm=None, cmap="BuPu"))


print("*** Block layout ***")
block_layout(solution, c, s)
plt.show()

print("*** Block graph ***")
weighted_call_graph()
plt.show()
