#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes

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
  Uncertainty*],
  [Low],
  [High],

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
  node((4, 0), "Crisp Output"),
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
  [*Uncertainty Type*],
  [Vagueness from _indiscernibility_],
  [Vagueness via _partial truth_],

  [*Membership*], [Only set boundaries], [Degree of membership $in [0, 1]$],
  [*Data Dependency*],
  [Based on _data relations_],
  [Based on _membership functions_],
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
$
  mu(x) = cases(
    0 "if" x <= a or x >= d,
    (x- a)/(x- b) "if" a < x < b,
    1 "if" b <= x < c,
    (d-x)/(d-c) "if" c < x < d
  )
$
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
  T: [0, 1] times [0, 1] arrow [0, 1] = mu_(A inter B)(x) = mu_A (x) tilde(*) mu_B (x)
$
It follows the following properties:
- *Boundary Properties:* $T(0, 0) = 0$ and $T(a, 1) = T(1, a) = a$
- *Monotonicity:* $a <= c and b <= d => T(a, b) <= T(c, d)$
- *Commutativity:* $T(a, b) = T(b, a)$
- *Associativity:* $T(a, T(b, c)) = T(T(a, b), c)$

The types of T-Norms are:
- *Minimum T-Norm:* $T(mu_A (x), mu_B (x)) = mu_(A inter B) (x)$
- *Algebraic Product:* $T_("AP")(mu_A (x), mu_B (x)) = mu_A (x) mu_B (x)$
- *Bounded Difference:* $T_("BP")(mu_A (x), mu_B (x)) = "max"(0, mu_A (x) - mu_B (x))$
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
- *Drastic Sum:* $S_("DS")(mu_A (x), mu_B (x)) = display(
    cases(
      mu_A (x) "if" mu_B (x) = 0,
      mu_B (x) "if" mu_A (x) = 0,
      1 "if" mu_A (x) mu_B (x) > 0
    )
  )$

#theorem[Extension Principle][
  Let $X$ be a universe of discourse, $Y$ be the output space, $A$ be a fuzzy set and $f: X -> X$ be a function, then, the image of $A$ under $f$, denoted by $B = f(A)$ is,
  $ mu_B (y) = sup_(x in X, f(x) = y) mu_A (x) $
]
This is a fundamental concept that allows us to extend a crisp function to work with fuzzy sets.

#definition[Fuzzy Numbers][
  It is a special type of fuzzy set defined on $bb(R)$, which satisfy:
  - *Convexity:* The membership value does not decrease between any two points
  - *Normality:* At least one element has full membership value
  - *Continuity:* The membership function changes smoothly
]
The *Triangular Fuzzy Number* is the simplest and most common fuzzy number, defined by,
$ (a, b, c) $
where $a$ is the lower bound, $b$ is the peak and $c$ is the upper bound. It forms a triangle. The values near $a$ and $c$ are barely a part of the fuzzy set, while $b$ is fully included. These can be added and subtracted like vectors and multiplication is just multiplying individual components.

== Fuzzy Relations

#definition[Fuzzy Relation][
  If $X$ and $Y$ are universes, a fuzzy relation $R$ is a fuzzy set in $X times Y$,
  $ mu_R (x, y) in [0, 1] $
]
It is a fuzzy set defined on a Cartesian product of two or more universes. It represents the degree of relationship between two elements.

=== Relation Operations

The basic binary relation operations are:
- *Union:* $mu_(R_1 union R_2) (x, y) = max {mu_R_1 (x,y), mu_R_2 (x, y)}$
- *Intersection:* $mu_(R_1 inter R_2) = min {mu_R_1, mu_R_2}$
- *Composition:* $mu_(R_1 circle R_2)(x, z) = display(sup_y) min {mu_R_1 (x, y), mu_R_2 (y, z)}$

We also define another operation called *Min-Max Composition* which is defined as,
$ T(x, z) = max_(y in Y) min {R(x, y), S(y, z)} $
Another one is *Max-Product Composition*,
$ T(x, z) = max_(y in Y) R(x, y)S(y, z) $

Every fuzzy relation is _reflexive_ ($mu_R (x, x) = 1$), _symmetric_ ($mu_R (x, y) = mu_R (y, x)$) and _transitive_ ($mu_R (x, z) >= min {mu_R (x,y), mu_R (y, z)}$), meaning it is an equivalence relation.

== Rule Evaluation?

#definition[Linguistic Variables][
  It is a variable whose values are words/sentences in natural language rather than numbers. E.g. *temperature* as a variable and ${"Low", "Medium", "High"}$ as its values.
]

Thus, membership functions for linguistic variables is pretty similar, $mu_"Low" (20 degree C) = 0.8$.

The rules are of the form `IF x is A THEN y is B`, here, the `IF` part is the antecedent (condition) and the `THEN` part is the consequent (result). There are two main types of rules, *Sugeno* (the output is as a function) and *Mamdani* (the output is as a fuzzy set). To use a rule, we must first fuzzify our crisp inputs, then evaluate the antecedent (take the `AND` or `OR`), find the rule firing strength (result of antecedent evaluation) and then apply it to the consequent.

However, it is not as simple as that, there are generally conflicting rules#footnote[rules which fire simultaneously]. We use _aggregation_#footnote[combine outputs of all fired rules into single fuzzy output set] and then _defuzzification_.

To convert fuzzy output back to a crisp value, we use methods like *Centroid* method, *Mean of Maximum (MoM)* and *Bisector*.

== Mamdani-Type Fuzzy Inference System

Here, fuzzy sets are used for both the antecedent and consequent. The steps are:
+ *Fuzzification:* Convert crisp inputs into fuzzy sets.
+ *Rule Evaluation:* Evaluate the fuzzy rules using the fuzzified inputs. The rules are of the form `IF Temperature is High THEN FanSpeed is Fast`.
+ *Aggregation:* Combine the outputs of all fired rules into a single fuzzy output set.
+ *Defuzzification:* Convert the fuzzy output back into a crisp value.

This is great for systems where interpretability is important, as the rules are easy to understand and explain.

== Sugeno-Type Fuzzy Inference System

Here, fuzzy sets are used for the antecedent, but the consequent is a crisp function. The steps are:
+ *Fuzzification:* Convert crisp inputs into fuzzy sets.
+ *Rule Evaluation:* Evaluate the fuzzy rules using the fuzzified inputs. The rules are of the form `IF Temperature is High AND Humidity is High THEN FanSpeed = 0.5 * TEMP + 0.2 * Humidity + 5`.
+ *Aggregation:* Combine the outputs of all fired rules into a single fuzzy output set.
+ *Defuzzification* is not needed as the output is already a crisp number.

This is great for systems where interpretability is important, as the rules are easy to understand and explain.

= Rough Sets

Rough Set Theory (RST) is a mathematical approach to deal with uncertainty and vagueness in data analysis and knowledge discovery. It was introduced by Zdzisław Pawlak in the early 1980s. The main idea behind RST is to approximate a set using two precise sets called the lower and upper approximations.

#definition[Lower Approximation][
  The lower approximation of a set $X$ is the set of all objects that definitely belong to $X$ based on the available information. It is denoted by $underline(R)(X)$.
]

#definition[Upper Approximation][
  The upper approximation of a set $X$ is the set of all objects that possibly belong to $X$ based on the available information. It is denoted by $overline(R)(X)$.
]

#grid(
  columns: 2,
  gutter: 10pt,
  figure(
    image("imgs/Rough-Set-Boundary.png"),
  ),
  [
    The region between the lower and upper approximations is called the boundary region, which contains objects that cannot be classified with certainty. It is given by,
    $
      "BND"_R (X) = overline(R)(X) - underline(R)(X)
    $
  ],
)

Moreover, if the boundary region is empty, then the set $X$ is considered a crisp set. If the boundary region is non-empty, then $X$ is considered a rough set.

Simply speaking, a rough set is just a tuple of two crisp sets $<underline(R)(X), overline(R)(X)>$.

== Information System/Table

It is a structured way to represent knowledge about objects, basically a spreadsheet where rows are objects and columns are attributes and the values can be categorical or numerical. Formally,
$
  S = (U, A, V)
$
where, $U$ is the finite set of objects called the universe#footnote[Just like her (200 IQ reference)], $A$ is the finite set of attributes and $V$ is the set of values that attributes can take. Each attribute $a in A$ maps each object $x in U$ to a value $v in V$.

#align(center)[
  #table(
    columns: 4,
    table.header([*Object*], [*Height*], [*Weight*], [*Disease*]),
    [$x_1$], [170 cm], [60 kg], [Yes],
    [$x_2$], [160 cm], [55 kg], [No],
    [$x_3$], [170 cm], [55 kg], [Yes],
  )
]
== Indiscernibility Relation

It tells us which pair of objects are indistinguishable based on the available attributes. Formally, for a subset of attributes $P subset.eq A$, the indiscernibility relation $tilde_P$ is defined as,
$
  p tilde_P q & <=> forall a in P (a(p) = a(q)) \
     "IND"(P) & = {(p, q) in U times U | p tilde_P q} \
$

For the above example, the indiscernibility relations are:
$
            "IND"("Height") & = {{x_1, x_3}, {x_2}} \
            "IND"("Weight") & = {{x_2, x_3}, {x_1}} \
  "IND"("Height", "Weight") & = {{x_1}, {x_2}, {x_3}} \
$

#definition[Equivalence Class][
  For an object $x in U$ and a subset of attributes $P subset.eq A$, the equivalence class of $x$ under the indiscernibility relation $tilde_P$ is defined as,
  $
    [x]_P = {y in U | x tilde_P y}
  $
]

For the above example, the equivalence classes are:
#columns(2)[
  $
    [x_1]_"Height" & = {x_1, x_3} \
    [x_2]_"Height" & = {x_2} \
    [x_3]_"Height" & = {x_1, x_3} \
  $
  #colbreak()
  $
    [x_1]_"Weight" & = {x_1} \
    [x_2]_"Weight" & = {x_2, x_3} \
    [x_3]_"Weight" & = {x_2, x_3} \
  $
]

== Reducts and Core

#definition[Reduct][
  A reduct is a minimal subset of attributes that can be used to represent the same indiscernibility relation as the full set of attributes. Formally, a subset $R subset.eq A$ is a reduct if,
  $
	"IND"(R) = "IND"(A) \
	forall S subset R ("IND"(S) != "IND"(A)) \
  $
]
This is basically the smallest _feature set_ that acheieves the same grouping as we get with all attributes.

#definition[Core][
  The core is the intersection of all reducts. It contains the most essential attributes that cannot be removed without losing information. Formally,
  $
	"CORE"(A) = inter.big {R | R "is a reduct of" A} \
  $
]
The core attributes are those that are present in every reduct, meaning they are absolutely necessary for maintaining the indiscernibility relation.
