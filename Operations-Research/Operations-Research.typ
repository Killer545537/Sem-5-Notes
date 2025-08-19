#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

#let algorithm = theorem.with(
  variant: "Algorithm",
)

#let theorem-counter = counter("theorem")
#show: sectioned-counter(theorem-counter, level: 2)
#let theorem = exercise.with(
  variant: "Theorem",
  counter: theorem-counter,
)

#show: ilm.with(
  title: [Operations Research],
  author: "Pooja Bansal",
  abstract: [],
)

= Network Flow Problem

#definition[Network][
  A network is described as $G=(N, L)$, where $N$ is the set of nodes and $L subset.eq N times N$ is the set of directed arcs/links.
  $ L = {(i, j) in N times N | "there is a directed arc from node i to j"} $
]
Consider $N = {1, 2, 3, 4, 5}$ and $L = {(1,2), (1,3), (1, 4), (2, 3), (3,5), (4, 3), (4, 5), (5, 4)}$,

#let nodes = ("1", "2", "3", "4", "5")
#let edges = (
  (0, 1), (0, 2), (0, 3), (1, 2), (2, 4), (3, 2), (3, 4), (4, 3)
)
#figure(
  diagram({
    for (i, n) in nodes.enumerate() {
      let θ = 90deg - i*360deg/nodes.len()
      node((θ, 18mm), n, stroke: 0.5pt, name: str(i))
    }
    for (from, to) in edges {
      let bend = if (to, from) in edges { 10deg } else { 0deg }
      // refer to nodes by label, e.g., <1>
      edge(label(str(from)), label(str(to)), "-|>", bend: bend)
    }
  }),
  caption: [Example Network]
)

#definition[Directed Link][
  A link is said to be directed if it allows positive flow in one direction and zero flow in the other direction. E.g. $3 arrow 5$.
]
#definition[Undirected Link][
  A link is said to be directed if it allows flow in both directions. E.g. $4 arrow 5$.
]
#definition[Directed Network][
  A network is said to be directed if all its links are directed.
]
#definition[Undirected Network][
  A network is said to be undirected if it contains a mixture of directed and undirected links.
]
The above example is an undirected network.
#definition[Path][
  A path is a sequence of distinct links that join any two nodes through some other nodes. E.g. $1 arrow 2 arrow 3$.
]
#definition[Directed Path][
  A directed path from node $i$ to node $j$ is a sequence of connected links having flow towards $j$. E.g. $1 arrow 2 arrow 3$.
]
#definition[Undirected Path][
  An undirected path may allow flow in either direction. E.g. $3 arrow 1 arrow 4$.
]
#definition[Cycle][
  A path is said to be a cycle if it connects a node to itself through some other nodes.
]
A directed cycle is $4 arrow 5 arrow 4$. An undirected cycle is $1 arrow 3 arrow 5 arrow 4 arrow 1$.
#definition[Connected Network][
  A network where every pair of distinct nodes is connected by at least one path.
]
#definition[Tree][
  A tree is a connected network that may involve only a subset of all the nodes of the network without having any cycle in between.
]
If a tree has $n$ nodes, then it will have $n-1$ links.
#definition[Spanning Tree][
  A tree that links all the nodes of a network.
]
#definition[Minimum Spanning Tree][
  A tree with the minimum possible total edge weights.
]
#definition[Link Capacity][
  It is the maximum amount of flow that can pass through a directed link. The link capacity function is 
  $ u: L arrow bb(R)_(>= 0) $
]

#algorithm[Prim's Algorithm][
  + Start with any node and connect with the closest distinct node. Tick all the connected nodes
  + Identify the unconnected node that is closest to the ticked nodes and connect
  + Repeat step 1 and 2
]

#algorithm[Kruskal's Algorithm][
  + Sort all edges in ascending order of weights
  + Take the smallest edge not yet taken and add it to the tree if it does not create a cycle
  + Repeat step 2
]

#algorithm[Dijkstra's Algorithm][
  It is a fundamental algorithm to find the *shortest path* from a single source node to all other nodes in a weighted directed graph with non-negative edge weights.
  + Assign distance 0 to the source node, ∞ to all others; mark all nodes unvisited
  + While unvisited nodes remain:
    + Pick the unvisited node with the smallest distance
    + For each neighbor, update its distance if a shorter path is found via the current node
    + Mark the current node as visited (its shortest path is finalized)
]

#example[Dijkstra's Algorithm][
  #figure(
    diagram(
      node-stroke: .1em,
      node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),
      spacing: 2em,
      node((0, 0), "1", radius: 2em),
      edge((0, 0), (1, -1), 2, "|->"),
      edge((0, 0), (1, 1), 4, "|->"),
      edge((0, 0), (2, 0), 10, "|->"),
      node((1, -1), "2", radius: 2em),
      edge((1, -1), (3, -1), 5, "|->"),
      edge((1, -1), (2, 0), 11, "|->"),
      node((3, -1), "5", radius: 2em),
      edge((3, -1), (4, 0), 5, "|->"),
      node((2, 0), "4", radius: 2em),
      edge((2, 0), (3, -1), 8, "|->"),
      edge((2, 0), (3, 1), 7, "|->"),
      node((4, 0), "7", radius: 2em),
      node((1, 1), "3", radius: 2em),
      edge((1, 1), (2, 0), 3, "|->"),
      edge((1, 1), (3, 1), 1, "|->"),
      node((3, 1), "6", radius: 2em),
      edge((3, 1), (4, 0), 9, "|->"),
    )
  )
Find the shortest distance and path from 1 to 7.
]
#v(-1fr)
#thmbox(
  title: "",
  variant: "Explanation",
  color: green,
  numbering: none
)[
  #table(
    fill: none,
    columns: 8,
    table.header([*Iteration\
    (Node Finalized)*], [*1*], [*2*], [*3*], [*4*], [*5*], [*6*], [*7*]),
    [0], [$infinity$], [$infinity$], [$infinity$],[$infinity$],[$infinity$],[$infinity$],[$infinity$],
    [1 (1)], [0], [2], [4], [10], [$infinity$], [$infinity$], [$infinity$],
    [2 (2)], [0], [2], [4], [10], [7], [$infinity$], [$infinity$],
    [3 (3)], [0], [2], [4], [7], [7], [5], [$infinity$],
    [4 (6)], [0], [2], [4], [7], [7], [5], [14],
    [5 (5)], [0], [2], [4], [7], [7], [5], [12],
    [6 (4)], [0], [2], [4], [7], [7], [5], [12],
    [7 (7)], [0], [2], [4], [7], [7], [5], [12],
  )

  Now, to find the path, we retrace the path we took to get to the shortest distance, i.e., we got 12 after finalising node 5, and so on, thus getting the path,
  $ 1 arrow 2 arrow 5 arrow 7 $
]

#definition[Source Node][
  It is the node where the flow originates. It only has outward edges.
]
#definition[Sink Node][
  It is the node where the flow ends. It only has inward edges.
]
#definition[Bottleneck Capacity][
  It is the minimum capacity of any edge in a path.
]
#definition[Residual Capacity][
  Every edge of a residual network has a value called residual capacity which is equal to the difference between the original flow capacity and the current flow.
]
#definition[Residual Network][
  It is the network obtained after some residuals have been assigned to the links.
]
#definition[Augmenting Path][
  It is a path from the source to the sink in a residual graph along which additional flow can be pushed.
]

#algorithm[Ford-Fulkerson's Algorithm][
  + Start with all flows equal to 0
  + While there exists an augmenting path from source to sink in the residual geaph:
    + Find the minimum residual capacity (bottleneck) along that path
    + Increase the flow along the path by the bottleneck value
    + Update the residual graph (reduce forward capacities, increase backward capacities)
]

#definition[Cut][
  It is a set of directed links which when deleted from the network will cause a complete disruption of flow between source and sink.
]
A cut helps us analyse the amount of flow disruption by cutting all the supplies midway.
#theorem[Maximum Flow Minimum Cut Method][
  For any network with a single source and sink, the maximum possible flow from the source to the sink is equal to the minimum cut capacity for all the cuts of the network.
]

#definition[Critical Activity][
  It is an activity in a network where delay in its start time will further delay the project completion time.
]
If the start time of the activity may be delayed within limits without effecting the completion time, it is said to be non-critical.
#definition[Critical Path][
  The critical activities of a network that constitute an uninterrupted path which spans the entire network from start to finish.
]
