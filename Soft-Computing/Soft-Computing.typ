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

#show: ilm.with(
  title: [Soft Computing],
  author: "Shubhra Goyal",
  abstract: [],
)

= Introduction to Soft Computing

Soft computing#footnote[Hard computing on the other hand uses precise, deterministic and logical algorithms to produce exact solutions. It works on binary logic and requires structured input] is an approach to computing that deals with imprecision, uncertainty, partial truth and approximate reasoning inspired by the way humans solve problems. It has high tolerance for imprecision and noise, ability to learn and adapt and is inspired by biological systems and nature. It is used to solve problems where hard rules can't be defined, it reduces computation costs by approximating results, enables real-time adaptive systems and deals well with non-linear and dynamic systems.

#table(
  columns: 3,
  align: center,
  table.header([*Feature*], [*Hard Computing*], [*Soft Computing*]),
  [*Logic*], [Binary], [Fuzzy],
  [*Input Data*], [Precise], [Inexact],
  [*Problem Type*], [Structured], [Complex],
  [*Tolerance to \ 
  Uncertainty*], [Low], [High],
  [*Adaptability*], [Rigid Algorithms], [Adaptive],
)

The main components of soft computing are:
#columns(2)[
  - Fuzzy Logic
  - Neural Networks
  - Genetic Algorithms
  #colbreak()
  - Rough Sets
  - Optimization Techniques
]

== Fuzzy Logic

#definition[Fuzzy Logic][
  It is a form of logic that deals with reasoning that is approximate rather than fixed and exact. Unlike traditional binary (or "crisp") logic where variables must be either 0 or 1 (false or true), fuzzy logic allows for values between 0 and 1, representing degrees of truth.
]
#definition[Membership Function][
  These are mathematical functions used in fuzzy logic to map input values to their degree of membership in a fuzzy set — that is, how strongly an element belongs to a fuzzy category.
]

A *Fuzzy Inference System (FIS)* is the core framework in fuzzy logic that uses fuzzy set theory to map inputs to outputs using fuzzy rules. The components of a FIS are:
#columns(3)[
  - Fuzzification 
  #colbreak() 
  - Rule Evaluation 
  #colbreak() 
  - Defuzzification
]

#diagram(
  node-defocus: 0,
  spacing: (1cm, 2cm),
  edge-stroke: 1pt,
  crossing-thickness: 5,
	mark-scale: 70%,
  node-fill: luma(97%),

  node((0, 0), "Crisp Input"),
  edge((0, 0), "r", "-|>"),
  node((1, 0), "Fuzzifier"),
  edge((1, 0), "r", "-|>"),
  node((2, 0), "Rule Base
  &
  Inference Engine"),
  edge((2, 0), "r", "-|>"),
  node((3, 0), "Defuzzifier"),
  edge((3, 0), "r", "-|>"),
  node((4, 0), "Crisp Output")
)

#definition[Fuzzification][
  It is the process of converting crisp input to fuzzy values.
]
#definition[Rule Evaluation][
  This is the set of `IF-THEN` rules that define the system.
]
#definition[Defuzzification][
  This is the process of converting fuzzy outputs to crisp values.
]
These fuzzy systems can be used in air conditioners to control the temperature using fuzzy inputs and a lot more.

== Rough Sets

#definition[Rough Sets][
  These are a mathematical for handling imprecise, uncertain, or incomplete information, especially useful in data analysis, machine learning, and knowledge discovery. These were introduced by Zdzisław Pawlak in the early 1980s. It helps us work with approximations of sets based on indiscernibility.
]
#definition[Universe][
  It is the set of all objects under consideration. It is denoted by $U$.
]
#definition[Indiscernibility Relation][
  Two objects are indiscernible if they have the same attribute values. Formally, this is an equivalence relation over the universe. It is denoted by $tilde$.
]
#definition[Target Set][
  The set we want to classify or analyze — but we may not know exactly which elements are in it due to indistinguishability. It is denoted by $X$ and $X subset.eq U$.
]
#definition[Lower Approximation][
  This contains the objects that definitely belong to $X$. It is denoted by $underline(R)(X)$.
]
#definition[Upper Approximation][
  This contains the objects that possibly belong to $X$. It is denoted by $overline(R)(X)$.
]
The rough set boundary region is $overline(R)(X) - underline(R)(X)$ which contains the objects we cannot classify with certainty. If the boundary is empty, then $X$ is a crisp set otherwise if the boundary is non-empty, then $X$ is a rough set.

#table(
  columns: 3,
  align: center,
  table.header([*Feature*], [*Rough Sets*], [*Fuzzy Sets*]),
  [*Uncertainty Type*], [Vagueness from _indiscernibility_], [Vagueness via _partial truth_],
  [*Membership*], [Only set boundaries], [Degree of membership $in [0, 1]$],
  [*Data Dependency*], [Based on _data relations_], [Based on _membership functions_],
)

Rough sets are used in data mining for feature selection and rule generation. #footnote[We also use optimization techniques like PSO, GA in soft computing but since I am not a bitch I won't write this here]

== Neural Networks

A neural network is a computational model inspired by the brain, capable of learning patterns from data.#footnote[Semester 4 ML notes discuss these] The basic unit of a NN is a perceptron (neuron). It can learn from supervised or unsupervised data, can model non-linear functions and adapt through training. Some common NNs are:
- *Feedforward Neural Network* has a simple architecture and has no loops. It is used for classification and regression
- *Convolution Neural Network* is specialized for image recognition
- *Recurrent Neural Network* handles sequential data and has a feedback loop. It is used in time series and speech recognition
The most popular concept in NNs is the backpropagation algorithm. The steps are:
- *Forward Pass* where the output is computed
- *Compute Error* which is the difference between the calculated and expected
- *Backward Pass* which propagates the error backwards
- *Update Weights*

NNs are used in healthcare, finance and much more#footnote[Literally every fucking shit now].

Due to all these great strategies, the best thing to do is to combine them, thus, giving rise to neuro-fuzzy systems and genetic-fuzzy systems.

Some emerging trends are:
- *Edge Computing + Soft Computing:* Real time intelligent systems
- *Explainable AI (XAI):* Making neural models interpretable
- *Federated Learning:* Privacy-preserving distributed learning

= Fuzzy Systems

A fuzzy system is a rule-based system that uses fuzzy set theory to model uncertainty, vagueness, and imprecise information that use degrees of freedom $in [0, 1]$.

#definition[Fuzzy Set][
  A fuzzy set $A$ in a universe of discourse $X$ is characterized by a membership function $mu_A: X arrow [0, 1]$ which represents the degree of membership of $x$ in $A$. Here $A = {(x, mu_A (x)) | x in X}$.
]
These sets can be ordered or unordered and discrete or continuous.

#definition[Membership Function][
  It defines how each input value maps to its degree of membership in a fuzzy set.
]
Some common membership functions are:
- *Triangular Membership Function:* It is defined by a triplet $(a, b, c)$ where $a$ is the lower limit, $b$ is the peak point and $c$ is the upper limit. It is defined as,
$ mu(x) = max(0, min((x-a)/(b-a), (c-x)/(c-b))) $
- *Trapezoidal Membership Function:* It is defined by a four-tuple $(a, b, c, d)$ such that,
$ mu(x) = cases(
  0 "if" x <= a or x >= d,
  (x- a)/(x- b) "if" a < x < b,
  1 "if" b <= x < c,
  (d-x)/(d-c) "if" c < x < d
) $
- *Gaussian Membership Function:* This has a bell shaped curve,
$ mu(x) = e^(-(x-c)^2/(2 sigma^2)) $

== Properties of Membership Functions

- $"support"(A) = {x | mu_A (x) > 0 }$
- $"core"(A) = {x | mu_A (x) = 1}$
- The *height* is the maximum membership value assigned to any of its elements
- A fuzzy set is *normal* if its core is non-empty or $exists x in X (mu_A (x) = 1)$
- $"crossover"(A) = {x | mu_A (x) = 0.5}$
- A fuzzy set if *convex* iff for any $x_1, x_2 in X$ and any $lambda in [0, 1]$, $mu_A (lambda x_1 + (1- lambda)x_2) >= min {mu_A (x_1), mu_A (x_2)}$

#definition[$alpha$-Cuts][
  It converts a fuzzy set to a crisp set by selecting only those elements that meet or exceed a specified confidence level.
  $ A_alpha = {x in X | mu_A >= alpha} $
]
$alpha$-cuts are used to simplify fuzzy sets for analysis or computation by isolating parts of the set with stronger membership.

== Set Operations

The three basic set of operations are:
- *Union (OR):* $mu_(A union B) (x) = "max"(mu_A (x), mu_B (x))$
- *Intersection (AND):* $mu_(A inter B) (x) = "min"(mu_A (x), mu_B (x))$
- *Complement (NOT):* $mu_(A^c) (x) = 1 - mu_A (x)$

=== Triangular Norm

The *T-Norm* is defined as,
$
T: [0, 1] times [0, 1] arrow [0, 1] = mu_(A inter B)(x)
$
It follows the following properties:
- *Boundary Properties:* $T(0, 0) = 0$ and $T(a, 1) = T(1, a) = a$
- *Monotonicity:* $a <= c and b <= d => T(a, b) <= T(c, d)$
- *Commutativity:* $T(a, b) = T(b, a)$
- *Associativity:* $T(a, T(b, c)) = T(T(a, b), c)$

The types of T-Norms are:
- *Minimum T-Norm:* $T(mu_A (x), mu_B (x)) = mu_(A inter B) (x)$
- *Algebraic Product:* $T_("AP")(mu_A (x), mu_B (x)) = mu_A (x) mu_B (x)$
- *Bounded Product:* $T_("BP")(mu_A (x), mu_B (x)) = "max"(0, mu_A (x) + mu_B (x) - 1)$
- *Drastic Product:* $T_("DP")(mu_A (x), mu_B (x)) = cases(
  mu_A(x) "if" mu_B(x) = 1,
  mu_B(x) "if" mu_A(x) = 1,
  0 "if" "max"(mu_A (x), mu_B (x)) < 1
)$

=== Supremum Norm

The *S-Norm* is defined as,
$
S: [0, 1] times [0, 1] arrow [0, 1] = mu_(A union B)(x)
$
It follows the following properties:
- *Boundary Properties:* $S(1, 1) = 1$ and $S(a, 0) = S(0, a) = a$
- *Non-Decreasing Property:* $b <= c => S(a, b) <= S(a, c)$
- *Commutativity:* $S(a, b) = S(b, a)$
- *Associativity:* $S(a, S(b, c)) = S(S(a, b), c)$

The types of S-Norm are:
- *Maximum S-Norm* $S(mu_A (x), mu_B (x)) = mu_(A union B) (x)$
- *Algebraic Sum:* $S_("AS")(mu_A (x), mu_B (x)) = mu_A (x) + mu_B (x) - mu_A (x) mu_B (x)$
- *Bounded Sum:* $S_("BC")(mu_A (x), mu_B (x)) = "min"(1, mu_A (x) + mu_B (x))$
- *Drastic Sum:* $S_("DS")(mu_A (x), mu_B (x)) = cases(
  mu_A (x) "if" mu_B (x) = 0,
  mu_B (x) "if" mu_A (x) = 0,
  1 "if" mu_A (x) mu_B (x) > 0
)$
