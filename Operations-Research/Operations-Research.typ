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
      node-fill: gradient.radial(
        blue.lighten(80%),
        blue,
        center: (30%, 20%),
        radius: 80%,
      ),
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
    [0],
    [$infinity$],
    [$infinity$],
    [$infinity$],
    [$infinity$],
    [$infinity$],
    [$infinity$],
    [$infinity$],

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

= Queuing Theory

We will look at the flow of customers from inifinte/finite population towards a service facility into a queue and then being serviced.

We need queues because:
- The number of customers exceed the number of servers
- Servers do not work efficiently and take more than the prescribed time to serve a customer

#definition[Customer][
  It is an entity that requires service from the service facility.
]
#definition[Queue][
  It is a line of customers waiting for service. This does not include the customers being served.
]
#definition[Service Facility/Channel][
  It is the system that provides service to the customers.
]

== Queuing System

The four factors of a queuing system are:
- *Input/Arrival Pattern:* The customers may arrive in the system at known tmies or randomly#footnote[But a random distribution cannot be studied]. We assume that the arrivals follow a Poisson distribution.
- *Customer Behaviour:* The customers may either be patient#footnote[Mathematically uninteresting] or impatient. The impatient customers may be one of the following:
  - *Balking:* Customers who do not join the queue if it is too long
  - *Reneging:* Customers who leave the queue after joining it if the wait is too long
  - *Jockeying:* Customers who switch between queues to get served faster
- *Queue Discipline:* It is the order in which customers are served. Some disciplines are:
  - *First-Come-First-Served (FCFS):* Customers are served in the order they arrive
  - *Last-Come-First-Served (LCFS):* The most recent arrival is served first
  - *Service in Random Order (SIRO):* Customers are served in a random order
  - *Priority Service:* Customers with higher priority are served first. This can be pre-emptive#footnote[Higher priority customer can interrupt the service of a lower priority customer] or non-pre-emptive#footnote[Higher priority customer is placed ahead in the queue].
- *Service Pattern:* This represents the arrangement of service facilities. There may be infinite servers or finite servers#footnote[The customers must obviously be greater]. These are of the following types:
  - *Single Queue Single Servers*
  - *Single Queue Multiple Servers*
  - *Multiple Queue Single Servers*
  - *Several Servers:* These servers may be in parallel#footnote[All servers are identical] or in series#footnote[Customers must go through each server in a sequence].

== Characteristics of Queuing System

#definition[Mean Arrival Rate][
  It is the average number of customers arriving per time period. It is denoted by $lambda$.
]
#definition[Mean Service Rate][
  It is the average number of customers that can be served per time period by a single server. It is denoted by $mu$.
]
#definition[Queue Length][
  It is the number of customers in the queue waiting for service. It is denoted by $L_q$.
]
#definition[System Length][
  It is the number of customers in the system, including those being served. It is denoted by $L_s$.
]
#definition[Waiting Time in Queue][
  It is the average time a customer spends waiting in the queue before being served. It is denoted by $W_q$.
]
#definition[Waiting Time in System][
  It is the average time a customer spends in the system, including both waiting and service time. It is denoted by $W_s$.
]
#definition[Utilisation Factor/Traffic Intensity][
  It is the ratio of the mean arrival rate to the mean service rate. It is denoted by $rho = lambda/mu$.
  It is a measure of how busy the system is. For a stable system, $rho < 1$.
]
#definition[Steady State][
  It is a condition where the properties of the queuing system do not change over time. This occurs when the arrival rate is less than the service rate, allowing the system to reach equilibrium.
]
#pagebreak()
#definition[Transient State][
  It is a condition where the properties of the queuing system change over time. This occurs when the arrival rate is greater than or equal to the service rate, leading to an unstable system.
]

== Kendall's Notation
A queuing system is represented as $A\/S\/c : L\/D$, where:
- *A:* Arrival process distribution (e.g., M for Markovian/Poisson, D for Deterministic, G for General)
- *S:* Service time distribution (e.g., M for Markovian/Exponential, D for Deterministic, G for General)
- *c:* Number of servers ($c = 1$ or $c = N > 1$)
- *L:* Queue length (e.g., $infinity$ or $N$)
- *D:* Queue discipline (e.g., FCFS, LCFS, SIRO, Priority)

We will only look at:
- *M/M/1: $infinity$/FCFS* (Single Queue Single Server)
- *M/M/: $L$/FCFS* (Single Queue Multiple Servers)
- *M/M/1: $infinity$/FCFS* (Finite Population Single Queue Single Server)
- *M/M/: $L$/FCFS* (Finite Population Multiple Queue Single Server)

== M/M/1: $infinity$/FCFS
Consider the traffic intensity $rho = lambda/mu$. We can reason as to why $rho < 1$ for a stable system, because if $rho >= 1$, then the arrival rate is greater than or equal to the service rate, leading to an unstable system where the queue length grows indefinitely. Remember that the queue length does not mean how long the queue can be, but the average number of customers in the queue.

Take a small interval of time $h$, where only one arrival or one service can occur. The probabilities are:
- *Arrival:* $P("1 arrival in " h) = lambda h$
- *No Arrival:* $P("0 arrivals in " h) = 1 - lambda h$
- *Service:* $P("1 service in " h) = mu h$
- *No Service:* $P("0 services in " h) = 1 - mu h$ (This is only if there is at least one customer in the system)

Let $P_n (t)$ be the probability of having $n$ customers in the system at time $t$. This is given by,
$
  P_n (t + h) &= P_(n-1)(t) (lambda h)(1 - mu h) + P_(n+1) (t)(1- lambda h)(mu h) + P_n (t) (1 - lambda h)(1 - mu h) \
  => (P_n (t + h) - P_n (t))/(h) &= lambda P_(n-1)(t) + mu P_(n+1)(t) - (lambda + mu) P_n (t) quad ("Ignoring higher order terms in " h)
$
Studying the transient state is kinda pointless, so we look at the steady state where $t -> infinity$ and thus, $dd(P_n)/dd(t) = 0$. Thus,
$
  (lambda + mu) P_n = lambda P_(n-1) + mu P_(n+1)
$
This is a simple recurrence relation, which we can solve, if we get the base case $P_0$,
$
  P_0 (t + h) &= P_0 (t) (1- lambda h) (1) + P_1 (t) (1 - lambda h)(mu h) \
  => (P_0 (t + h) - P_0 (t))/(h) &= - lambda P_0 (t) + mu P_1 (t) \
  therefore P_1/P_0 &= rho
$
Knowing the common ratio $lambda/mu = rho$, say the solution is of the form $P_n = A rho^n$. Clearly, $sum P_n = 1$,
$
  sum P_n = sum A rho^n = A/(1 - rho) = 1 => A = 1 - rho \
  therefore P_n = (1 - rho) rho^n
$

From this, we can find the other characteristics of the queuing system as,
$
  L_s & = sum n P_n = (1 - rho) sum n rho^n = rho/(1 - rho) \
  L_q & = L_s - rho = rho^2/(1 - rho) \
$

Using Little's Equation, we get,
$
  W_s & = L_s/lambda = 1/(mu - lambda) \
  W_q & = L_q/lambda = lambda/(mu (mu - lambda))
$

#example[M/M/1: $infinity$/FCFS][
  A T.V. repairman finds that the time spent on this jobs is exponentially distributed with a mean of 30 minutes. If he repairs the sets in the order in which they arrive and if the arrival of sets is approximately a Poisson process with an average rate of 10 per 8 hour-day. Find:
  + Expected idle time each day
  + How many jobs are ahead of the average set just brought in
]
#explanation[
  Here, $lambda = 10$. Since he can repair 16 sets in an 8-hour day, $mu = 16$. Thus, $rho = 10/16 = 0.625$.
  + The repairman is idle when there are no sets to repair, which is $P_0 = 1 - rho = 0.375$. Thus, the expected idle time each day is $0.375 times 8 = 3$ hours.
  + The number of jobs ahead of the average set just brought in is the average number of jobs in the system, which is $L_s = rho/(1 - rho) = 5/3 approx 2 "TV sets"$.
]

== M/M/1: $L$/FCFS

The probabilities are in the same ratio as before, but now we have the constraint that the maximum number of customers in the system is $L$. Thus,
$
  sum_(n = 0)^(n = L) P_n & = 1 \
                   => P_0 & = (1 - rho)/(1 - rho^(L + 1)) \
$
Moreover, there is no constraint on $rho$ here. Thus, if $rho = 1$, $P_0 = 1/(L + 1)$.

The other characteristics are,
$
  L_s & = sum_(n = 0)^(n = L) n P_n = rho/(1 - rho) - ((L + 1) rho^(L + 1))/(1 - rho^(L + 1)) \
  L_q & = L_s - lambda_"eff"/mu quad (lambda_"eff" = lambda (1 - P_L))\
$

== M/M/C: $infinity$/FCFS

Let $mu_n$ denote the total service rate when there are $n$ customers in the system. Thus,
$
  mu_n = cases(
    n mu "if" n < c,
    c mu "if" n >= c
  )
$

Thus, the probability of having $n$ customers in the system is,
$
  P_n & = P_0 product_(k = 1)^n lambda/mu_k \
      & = cases(
          P_0 rho^n/n! "if" n < c,
          P_0 rho^n/(c! c^(n - c)) "if" n >= c
        )
$
Normalizing,
$
  1 &= sum P_n \
  1 &= P_0 [sum_(n = 0)^(c - 1) rho^n/n! + sum_(n = c)^infinity rho^n/(c! c^(n - c))] \
  therefore P_0 &= (sum_(n = 0)^(c - 1) rho^n/n! + rho^c/((c-1)! (c + rho)))^(-1)
$

= Simulation
