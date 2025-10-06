#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)
#show figure: set block(breakable: true)

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
#let explanation(body) = {
  v(-1fr)
  thmbox(
    title: "",
    variant: "Explanation",
    color: green,
    numbering: none,
  )[#body]
}

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
  (0, 1),
  (0, 2),
  (0, 3),
  (1, 2),
  (2, 4),
  (3, 2),
  (3, 4),
  (4, 3),
)
#figure(
  diagram({
    for (i, n) in nodes.enumerate() {
      let θ = 90deg - i * 360deg / nodes.len()
      node((θ, 18mm), n, stroke: 0.5pt, name: str(i))
    }
    for (from, to) in edges {
      let bend = if (to, from) in edges { 10deg } else { 0deg }
      // refer to nodes by label, e.g., <1>
      edge(label(str(from)), label(str(to)), "-|>", bend: bend)
    }
  }),
  caption: [Example Network],
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

#example[Prim's Algorithm][
  Find the minimum spanning tree for the graph.
]

#algorithm[Kruskal's Algorithm][
  + Sort all edges in ascending order of weights
  + Take the smallest edge not yet taken and add it to the tree if it does not create a cycle
  + Repeat step 2
]

#example[Kruskal's Algorithm][
  Find the minimum spanning tree for the graph.
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
    ),
  )
  Find the shortest distance and path from 1 to 7.
]
#v(-1fr)
#thmbox(
  title: "",
  variant: "Explanation",
  color: green,
  numbering: none,
)[
  #table(
    fill: none,
    columns: 8,
    table.header(
      [*Iteration\
        (Node Finalized)*],
      [*1*],
      [*2*],
      [*3*],
      [*4*],
      [*5*],
      [*6*],
      [*7*],
    ),
    [0], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [$infinity$], [$infinity$],
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

#definition[Merge Event][
  It is an event which represents the joint completion of more than one activity.
]

#definition[Burst Event][
  It is an event which represents the joint initiation of more than one activity.
]

The different types of activities are:
#definition[Predecessor Activity][
  An activity which is completed immediately before one or more activities start.
]
#definition[Successor Activity][
  An activity which is completed after before one or more activities start.
]
#definition[Dummy Activity][
  An activity which does not consume any resource/time. It implies the dependency of one activity on another.
]

We can create a network with activities and events where we either have the activity on the arrow or the event on the arrow. Both are inter-convertible and represent the same situations.

To number the events, we follow *Fukerson's Rule*, which states that if there is an activity $A$ from $i$ to $j$, then $i < j$.

#definition[Critical Activity][
  It is an activity in a network where delay in its start time will further delay the project completion time.
]
If the start time of the activity may be delayed within limits without effecting the completion time, it is said to be non-critical.
#definition[Critical Path][
  The critical activities of a network that constitute an uninterrupted path which spans the entire network from start to finish.
]

To find the critical activities, we find#footnote[$E_i$ is found on the forward pass as the max of the time taken to reach it from all paths]#footnote[$L_i$ is found on the backward pass as the minimum time to reach it (in reverse) from all paths] $"Earliest Start Time" = E_i$ and $"Latest Finish Time" = L_i$ for each node, and mark all nodes with $E_i = L_i$ as critical.

The critical path is the path with only critical nodes such that for two adjacent nodes $L_j - L_i = E_j - E_i = "Path Length/Resources"$. This is the *Critical Path Method*.

However, realistically, we do not have the exact time to complete for some projects, which is when we use *Project Evaluation Review Technique (PERT)*. This is used when we have the optimistic time estimate ($t_o$)#footnote[Shortest possible time to complete the activity if everything goes well], pessimistic time estimate ($t_p$) and most likely time estimate ($t_m$). Here, we can find the time estimate and variance with,
$ t_e = (t_o + 4t_m + t_p)/6 quad sigma^2 = ((t_p - t_o)/2)^2 $
Using the mean and the variance, we can use Critical Path Method to find $T_e$ which on using the standard normal variate, we can get the probability to complete a task with,
$ Z_e = (T_s - T_e)/sigma_e $
where, $sigma_e^2 = sum sigma^2_c$ and then finding $P(Z < Z_e)$.

= Multi-Objective Optimization

== Goal Programming

It is an approach for solving a multi-objective optimization problem that balances a trade-off in conflicting objectives. Since we cannot find the true optimal solution, we try to find a satisficing solution that meets the goals to an acceptable level.

It can be thought of as an extension or generalization of linear programming that allows for multiple, often conflicting objectives to be addressed simultaneously. Each of these objectives is associated with a goal, and the aim is to minimize the deviations from these goals.

#definition[Decision Maker][
  The individual or group responsible for making choices in the context of the optimization problem.
]
#definition[Decision Variables][
  It is a factor over which the decision maker has control and can adjust to influence the outcome of the optimization problem.
]
#definition[Criterion][
  It is a single measure by which the goodness of any solution to a decision problem can be evaluated.
]
#definition[Aspiration Level][
  The value specified by the decision maker the reflects their desire/satisfactory level for each criterion.
]
An objective function along with its aspiration level is called a goal.
#definition[Goal Deviation][
  It is the amount by which the actual performance of a solution deviates from the aspiration level for a particular goal. The deviation can be positive (overachievement) or negative (underachievement).

  - *Positive Deviation:* $f(x) >= a => f(x) - d^+ = a$
  - *Negative Deviation:* $f(x) <= a => f(x) + d^- = a$
  - *Both Deviations:* $f(x) = a => f(x) + d^- - d^+ = a$
]

In a Goal Programming Problem, our goal is to minimize the (weighted sum of) deviations from the aspiration levels for each criterion while satisfying any constraints imposed by the problem.

The two main types of Goal Programming are:
- *Non Pre-emptive Goal Programming:* All goals are treated equally, and the objective is to minimize the total weighted sum of all undesirable deviation from all goals simultaneously.
- *Pre-emptive Goal Programming:* Goals are prioritized, and the objective is to minimize the deviations from the highest priority goal first, then the next highest, and so on. Lower priority goals are only considered after higher priority goals have been satisfied to the extent possible.

= Dynamic Programming

It divides the problem into a series of overlapping subproblems.

The most important features are *Optimal Substructure* and *Overlapping Subproblems*.
#definition[Stages][
  These are the sequences of smaller subproblems of the overall problem to be analysed. The number of stages is the number of decisions/variables.
]
#definition[Return Function][
  It is an algebraic expresssion/equation that represents the benefits associated with the decision taken at each stage.
]

#example[Continuous Case][
  $
          "Min" Z & = x_1^2 + x_2^2 + x_3^2 \
    "subject to:" & x_1 + x_2 + x_3 = 15 \
              x_i & >= 0
  $
]
#explanation[
  We can break this into 3 stages, with each stage having a decision variable $x_i$.
  + *Stage 1:* $S_1 = x_1$ with return function $f_1(S_1) = display(min_(0 <= x_1 <= S_1) {x_1^2})$
  + *Stage 2:* $S_2 = x_1 + x_2$ with $f_2(S_2) = display(min_(0 <= x_2 <= S_2) {x_1^2 + x_2^2})$
  + *Stage 3:* $S_3 = x_1 + x_2 + x_3$ with $f_3(S_3) = display(min_(0 <= x_3 <= S_3) {x_1^2 + x_2^2 + x_3^2})$

  For $S_1$,
  $
    f_1(S_1) = min_(0 <= x_1 <= S_1) {x_1^2} = x_1^2 = S_1^2
  $
  For $S_2$,
  $
    f_2(S_2) = min_(0 <= x_2 <= S_2) {x_1^2 + x_2^2} = min {(S_2 - x_2)^2 + x_2^2})
  $
  Differentiating and equating to 0, we get $x_2 = S_2/2$ and $f_2(S_2) = S_2^2/2$.
  For $S_3$,
  $
    f_3(S_3) = min_(0 <= x_3 <= S_3) {x_1^2 + x_2^2 + x_3^2} = min {S_2^2/2 + x_3^2} = min {(S_3 - x_3)^2/2 + x_3^2}
  $
  Again, differentiating and equating to 0, we get $x_3 = S_3/3$ and $f_3(S_3) = S_3^2/3$.

  Since we have $S_3 = 15$, we get, $x_3 = 5$, $x_2 = 5$ and $x_1 = 5$ with $Z_min = 75$.
]

#example[Discrete Case][
  $
          "Max" Z & = x_1^2 + x_2^2 + x_3^2 \
    "subject to:" & x_1 + x_2 + x_3 = 6 \
              x_i & >= 0 \
              x_i & in bb(Z)
  $
]
#explanation[
  Here,
  #columns(2)[
    $
      S_1 & = x_1 = S_2 / x_2 \
      S_2 & = x_1 x_2 = S_3 / x_3 \
      S_3 & = x_1 x_2 x_3
    $
    #colbreak()
    $
      f_1(S_1) & = max {x_1^2} \
      f_2(S_2) & = max {f_1(S_1) + x_2^2} \
      f_3(S_3) & = max {f_2(S_2) + x_3^2}
    $
  ]
  We can tabulate the values as follows,
  #align(center)[
    #table(
      columns: 5,
      [*$x_1$*], [1], [2], [3], [6],
      [*$f_1(S_1)$*], [1], [4], [9], [36],
    )
  ]
  Now for $f_2(S_2)$,
  #align(center)[
    #table(
      columns: 5,
      [], table.cell(colspan: 4, align: horizon)[$x_1 x_2$],
      [*$x_2^2$*], [1], [2], [3], [6],
      [1], [2], [5], [10], [37],
      [4], [5], [X], [13], [X],
      [9], [10], [13], [X], [X],
      [36], [37], [X], [X], [X],
    )
  ]
  Thus, taking the maximum value for each diagonal, we get,
  #align(center)[
    #table(
      columns: 5,
      [*$x_2$*], [1], [2], [3], [6],
      [*$f_2(S_2)$*], [2], [5], [10], [37],
    )
  ]
  Finally, for $f_3(S_3)$,
  #align(center)[
    #table(
      columns: 5,
      [], table.cell(colspan: 4, align: horizon)[$x_1 x_2 x_3$],
      [*$x_3^2$*], [1], [2], [3], [6],
      [1], [3], [6], [11], [38],
      [2], [6], [X], [14], [X],
      [10], [11], [14], [X], [X],
      [37], [38], [X], [X], [X],
    )
  ]
  Thus, taking the maximum value for each diagonal, we get,
  #align(center)[
    #table(
      columns: 5,
      [*$x_3$*], [1], [2], [3], [6],
      [*$f_3(S_3)$*], [3], [6], [11], [38],
    )
  ]
  Thus, the maximum value of $Z$ is 38 when $x_3 = 6$, $x_1 = x_2 = 1$ (or some permutation).
]

== Bellman's Principle of Optimality

An optimal policy or set of decisions has the property that whatever the intitial stage and decision are, the remaining decisions must constitute an optimal policy with regard to the state resulting from the first decision.

$
  f_i(S_i) = max {gamma(S_i) + f_(i-1)(T(S_(i-1)))}
$
where $f_i(S_i)$ is the optimal return function at stage $i$ with state $S_i$, $gamma(S_i)$ is the return from the decision at stage $i$ and $T(S_(i-1))$ is the transition function that gives the state at stage $i-1$ based on the state at stage $i$.
