#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes

#set page(margin: (
  top: 0.5in,
  bottom: 0.5in,
  x: 0.5in,
))

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

#let solution(body) = {
  v(-1.5em)
  example(variant: "Solution")[
    #body
  ]
}

#show: ilm.with(
  title: [Financial Engineering],
  author: "Amita Sharma",
  abstract: [],
)

= Introduction to Financial Instruments, Interest Rates and Pricing of Bonds

#definition[Financial Systems][
  It refers to the system that enables the exchange of funds between lenders, investors and borrowers. It comprises of financial institutions, financial markets, financial instruments and financial services. It serves the following purposes:
  #columns(2)[
    - Channel savings into investments
    - Provide risk management through insurance and hedging
    #colbreak()
    - Enable liquidity and price discovery
    - Facilitate efficient allocation of resources
  ]
]

#definition[Financial Markets][
  These are platforms for buying and selling financial instruments. There are multiple types of financial markets like capital market (equity/stocks market and debt/bonds market), money market (short-term dept instruments), derivative market (futures, options, swaps), forex market (trading of currencies) and commodities market (trading of physical goods). There are also primary markets where securities are issued and secondary markets where previously issued securities are traded.
]

== Financial Instruments

The different types of financial instruments are:
- *Stocks/Equity:* represent ownership in a company. The shareholders may earn a dividend (part of profit) or capital gains (price appreciation). The two types of stocks are common and preferred stocks.
- *Bonds (Debt Instruments):* are loans made by an investor to a borrower (typically corporate/government). The borrower then pays periodic interest (coupon) and returns principal at maturity. The types of bonds are corporate, government, municipal and zero-coupon.
- *Derivatives:* are financial contracts whose value is derived from an underlying asset. These are used for hedging, speculation and arbitrage#footnote[Practice of exploiting price differences of the same asset in different markets to make a risk-free profit]. The types of derivatives are futures (obligation to buy/sell at a fixed price in future), options (right (not obligation) to buy/sell) and swaps (exchange of cash flows, e.g. interest rate swap).
- *Mutual Funds:* are investment vehicle that pools funds from investors to purchase a diversified portfolio. These are managed by professional fund managers. The types of mutual funds are equity funds, debt funds, hybrid funds and index funds. $ "Net Asset Value" = ("Total value of assets" - "Liabilites")/"Total units" $
- *Interest Rates:* The types of interest rates are nominal interest rate, real interest rate and effective interest rate.
- *Bond and Bond Pricing*

== Time Value of Money

Let the principal amount at $t=0$ be $P$ and the future value at time $t=t_n$ be $V$. Let the interest rate be $r%$ given annually.
=== Simple Interest

Here,
$ V_n = P(1 + n r) $
Thus, the growth rate#footnote[We can also define a discount factor $1/gamma$ which can be used to go back from $V$ to $P$] is $gamma = (1 + n r)$ which is linear.

=== Compound Interest

Here,
$
          V_n & = V_(n-1)(1 + r) \
  V_n/V_(n-1) & = 1 + r
$
Thus, this forms a geometric progression such that $V_0=P$,
$ therefore V_n = P(1 + r)^n $
The growth rate is $gamma = (1 + r)^n$ which is exponential.

However, if the interest is compounded $m$ times in an interval, then,
$ V_n = P(1 + r/m)^(n m) $

Now, if we consider the interest to be compounded continuously, i.e.
$ lim_(m arrow infinity) V_n = P e^(r n) $

#definition[Effective Rate][
  This is used to check which compounding method is more beneficial.
  $
            (1 + r/m)^m & = (1 + r_("eff")) \
    therefore r_("eff") & = (1 + r/m)^m - 1
  $
]

#definition[Inflation Rate][
  It measures how quickly the general level of prices for goods and services rises over time. It is denoted by $f$. The real interest rate is,
  $ 1+r_0 = (1 + r)/(1 + f) $
]

== Present & Future Value of a Cash Flow/Stream

Consider $(x_i)^n_1$ to be the deposit (deposits occur at the beginning of each interval) at time $i$ and $r$ to be the constant interest rate across each interval, then the final value is,
$ V = sum x_i (1 + r)^(n-i) $
Similarly, we can find out the present value,
$ P = sum x_i/(1 + r)^i $

== Bonds

#definition[Bonds][
  It is a fixed-income instrument that represents a loan made by an investor to a buyer (typically a corporation, municipality or government).
]
A bond is an obligation by the issuer to pay the money to the holder according to the rules as mentioned in the legal document at the time when the bond is issued.
#definition[Maturity/Due/Redemption Date][
  It is the date of the termination of the bond deal.
]
#definition[Face/Par Value][
  It is the amount the issuer promises to pay at the maturity date.#footnote[It may be less than the bond price. This occurs when the coupon rate is higher than the prevailing market interest rate]
]
#definition[Coupon Rate][
  It is the percent of the face value paid periodically to the buyer.
]

If a bond is priced $P$ at a coupon rate of $c$ and has a face value of $F$ for some time interval $n$, then the total cash inflow is,
$ V = c n + F $

The *bid price* is the highest price a buyer is willing to pay for a bond and the *ask price* is the lowest a seller is willing to accept for a bond. The difference is called a *spread* which reflects market liquidity and risk. Only once the prices meet, is a bond sold and bought.

#definition[Price of a Bond][
  It is the price at which the seller sells the bond to the buyer.
]
#definition[Bond Quality Rating][
  It is a grade assigned by credit rating agencies that reflects the risk of default, i.e. the chance that the issuer will fail to make scheduled payments.
]
Some major bond rating agencies are:
#columns(2)[
  - Standard & Poor's
  - Moody's
  - Fitch Ratings
  #colbreak()
  - CRISIL
  - ICRA
  - India Ratings (Fitch subsidiary)
]
The ratings#footnote[These ranks have no relation with the coupon rate] start from AAA and AA being the highest grade, with A and BB being medium grade and CCC, CC, C and D being default.

#definition[Yield To Maturity][
  It is the internal rate of return earned by an investor who buys a bond at its current market price and holds it until maturity, assuming all coupon payments are made as scheduled and reinvested at the same rate.
]

=== Bond Price Formula

Consider a standard bonus with face value $F$, $m$ coupon payments per year for $n$ years and $y$ TTM, then the price of the bond is,
$
  P & = sum_1^(m n) (c/ m)/ (1 + y/m)^i + F/(1 + y/m)^(m n) \
    & = F/(1 + y/m)^(m n) + c/ y [ 1- 1 / (1 + y/m)^(m n) ]
$

Now, if we consider the yield to be compounded continuously, we get,
$ P_t = F e^(-y(T- t)) + c((1-e^(-y(T-t)))/(e^((T-t)/n))) $

When the coupon rate is less than the yield, i.e. the price is less than the face value, we say that the bond is issued at a discount. When the price is more than the face value, the bond is issued at a premium. We can see this with the following,
$
  P & = sum (c F)/(1+c)^i + F/(1 + c)^n \
    & = F
$
Thus, if $c = y$, then the bond price is the same as the face value.

=== Price-Yield Curves

==== Effect of Coupon Rates

#figure(
  image("imgs/Effect-Of-Coupon-Rate.png", height: 25%),
  caption: [Effect of Coupon Rate on Price-Yield Curve],
)

==== Effect of Time of Maturity

#figure(
  image("imgs/Effect-Of-Maturity.png", height: 25%),
  caption: [Effect of Time of Maturity on Price-Yield Curve],
)

Thus, we can draw the following conclusions:
- Bond price is inversely proportional to the change in market interest rates
- All else equal, longer maturity bonds are more sensitive to interest rates compared to shorter maturity bonds
- All else equal, lower coupon bonds are more sensitive to interest rates compared to higher coupon bonds

=== Duration

It is the measure of a bond's sensitivity to changes in interest rates (yield). Realistically, it tells us when we effectively get our money back, accounting for coupons we receive before maturity.

Let the cash flow from a fixed income security be, $(x_0, x_1, dots.h, x_n)$ at times $(t_0, t_1, dots.h, t_n)$, thus we can define,
$ "Present value of cash received at t" = P_t $
thus the duration is given as,
$ D = (sum P_t t)/(sum P_t) in [t_0, t_n] $
If we find the present values $P_t$ via the yield (for bonds), then this duration is called the Macaulay Duration,
$ D_M = (sum_(t=0)^n t (c_t)/(1+y')^t + (n F)/(1+ y')^t)/(sum c_t/(1+y')^t + F/(1+y')^n) quad (y'=y/n) $
Obviously#footnote[Actually magic] this simplifies to,
$ D_M = (1 + y)/(n y) - (1 + y + n ( c - y))/(m c[(1 + y)^n - 1] + m y) $

==== Macaulay Duration & Sensitivity

Let us try to find out the relation between the change of yield on the price of a bond using $D_M$.

$
             P_t & = (c_t)/(1 + y)^t \
  => dd(P)/dd(y) & = -t/(1+y) P_t
$
Using the definition of the Macaulay Duration,
$
              D_M & = (sum t P_t)/(sum P_t) \
        sum t P_t & = D_M P quad (P = sum P_t) \
  1/P dd(P)/dd(y) & = -D_M/(1 + y) = -D_M '
$

=== Yield Curves

#figure(
  image("imgs/Yield-Maturity-Curves", height: 25%),
  caption: [Yield vs Time of Maturity Curves],
)

= Derivatives

#definition[Derivatives][
  It is a financial instrument whose value is derived from some other valuable asset called the _underlying_ asset.
]
These are generally used for hedging purposes.

== Forward Contract

This is a type of derivative.

#definition[Forward Contract][
  It is an obligation between two investors to buy or sell an underlying asset of a specific price $F$ called the forward price at a specific time in the future called the delivery date.
]
The investor who agrees to sell the asset is said to enter into a short position and the one who agrees to buy the asset is said to enter into a long position.

$F(0, T) = F$ is the forward price of the forward contract initiated at $t=0$ with delivery date $t=T$. $S(t)$ is the price of the underlying asset at $t$.

#figure(
  image("imgs/Pay-Off-VS-S.png"),
  caption: [Pay-Off - Asset Price Relation for Long and Short Positions],
)

#theorem[No Arbitrage Principle][
  There is no investment with initial value $V(0) = 0$ such that $V(1) >= 0$ with absolute certainty (probability 1) or $V(1) > 0$ with non-zero probability.
]
This means that no investor can lock in a profit without risk and no initial endowment. Situations where this principle is violated are short-lived or the gains are extremely small compared to the volume of transactions. Thus, realistically arbitrage opportunities are solved naturally in the market.

We can easily see this with the following cases#footnote[We assume here that the delivery date is 1 year from now but the same shit applies],
- If the futures are overpriced, i.e. $F(0, 1) > S(0)(1 + r)$. Here, we take the following steps to create an arbitrage opportunity,
  + Borrow $S(0)$ at the risk-free rate $r$
  + Buy the asset in the spot market at $S(0)$
  + Short a futures contract (agree to sell at $F(0, 1)$ in 1 year)
  + At $t = 1$, deliver the asset into the futures contract, receiving $F(0, 1)$
  + Repay the loan $S(0)(1 + r)$
  + The profit is $F(0, 1) - S(0)(1 + r) > 0$
- If the futures are under priced, i.e. $F(0, 1) < S(0)(1 + r)$. Here, we take the following steps to create an arbitrage opportunity,
  + Short-sell#footnote[This means we borrow an asset toady from an investor and immediately sell it in the spot market at $S(0)$ though we will owe one unit of the asset to return later] the asset today, receiving $S(0)$
  + Invest it at the risk-free rate $r$
  + Long a futures contract (agree to buy at $F(0, 1)$)
  + At $t = 1$, the futures mature and we buy the asset at $F(0, 1)$
  + Return the asset to cover the short sale
  + The profit is $S(0)(1 + r) - F(0, 1) > 0$

Thus, with either of the cases we get an infinite money glitch#footnote[which is kinda crazy]. So, in order to avoid arbitrage opportunities, we can safely say that $F(0, T) = S(0)g(0, T)$.

=== Forward Price of Non-Dividend Paying Asset

Moreover, the forward price at some time $t$ can be given by,
$F(t, T) = S(0)g(t, T) = (S(0))/(d(t, T)) quad (d(t, T) " is the discount rate")$
This is the most basic kind of asset.

=== Forward Price with Carrying Cost

Consider an asset for which we have to pay carrying cost#footnote[This could be storing cost or anything which forces the holder of the asset to pay] $c_i$ in period $i$ at the beginning of each period,
$ F(0, T) = S(0)/d(0, T) + sum_0^(n - 1) c_t/(d(t, T)) $
Since the discount rate is a more common metric, we use that in contrast to the growth rate.

=== Forward Price of Dividend Paying Asset

Consider an asset which pays a dividend $d$ at some time in $tau in [0, T]$, then it will be discounted from the forward price,
$ F(0, T) = S(0)/d(0, T) - d/d(tau, T) $

=== Forward Price of Continuously Dividend Paying Asset

Consider an asset which pays a continuous dividend at some rate $r_d$, this _rate_ will be discounted,
$ F(0, T) = S(0)e^((r - r_d)T) $
If an asset continuously requires paying a carrying cost, the rate will be added#footnote[Kinda obvious].

=== Forward Contract on a Foreign Currency

Consider an importer in country $A$ with currency $A$ who aims to buy an asset from another country $B$ with currency $B$ at some future date. To hedge the $A->B$ currency exchange risk, he would prefer to long a future. Consider the forward contract to be written on currency $B$,
$ F(0, T) = P(0)e^((-r_B + r_A)T) $
where $P(0)$ is the exchange rate, i.e. $1 space A = P(0) space B$, $r_B$ is the interest rate in $B$ and $r_A$ is the interest rate in $A$.

=== Value of a Forward Contract

The value of a forward contract at some $tau in [0, T]$ is,
$ f(tau) = [F(tau, T) - F(0, T)] d(tau, T) $

To prove this, we can use the *No Arbitrage Principle*. Take a scenario, where at $tau$, we borrow $f(t)$ from the bank, long a forward with price $F(0, T)$ and short a forward with the same underlying asset at $F(tau, T)$. Closing the positions at $T$, our portfolio is,
$
              V(T) & = F(tau, T) - F(0, T) - f(tau)g(tau, T) \
                 0 & = F(tau, T) - F(0, T) - f(tau)g(tau, T) \
  therefore f(tau) & = [F(tau, T) - F(0, T)] d(tau, T)
$

== Futures Contract

#definition[Futures Contract][
  It is a standardized forward contract traded on an exchange, obligating the buyer to purchase (or the seller to sell) an asset at a predetermined price at a specified time in the future.
]

The main difference between a forward and a future is that the former is an OTC (over-the-counter) contract while the latter is exchange-traded. Thus, futures are more liquid and have lower counterparty risk#footnote[The risk that the other party will default on the contract]. However, futures require a margin account#footnote[An account where a trader deposits money as collateral to cover potential losses] and are marked to market daily#footnote[The process of adjusting the margin account to reflect gains/losses].

The standardized features of a futures contract are:
- Contract Size: The amount of the underlying asset covered by one futures contract.
- Expiration Date: The date when the contract expires and the asset must be delivered or settled.
- Mark to Market

If $f(n, T)$ is the futures price at time $n$ for delivery at time $T$, then for each day,
$
  "Day 1": f(1, T) - f(0, T) \
  "Day 2": f(2, T) - f(1, T) \
  dots.h \
  "Day n": f(T, T) - f(T-1, T) \
  "Total": f(T, T) - f(0, T) = S(T) - f(0, T)
$
Thus, the futures price at time $n$ is the same as the forward price at time $n$ for delivery at time $T$, i.e. $f(n, T) = F(n, T)$. This is because of the daily settlement which eliminates the interest on the gains/losses.

#definition[Initial Margin][
  It is the amount of money that must be deposited in a margin account to open a futures position.
]
#definition[Maintenance Margin][
  It is the minimum amount of equity that must be maintained in a margin account.
]
#definition[Marking to Market][
  It is the daily adjustment of the margin account to reflect gains or losses based on the settlement price.
]

#example[
  Suppose that the inital margin is set at $10 percent$ of the future value and maintenance of $5 percent$ of the future value. Suppose $n = 0, 1, 2, 3, 4$, the future prices are 140, 138, 130, 140 and 150 respectively. Show the working of of marking to market.
]
#solution[
  #figure[
    #table(
      columns: 6,
      table.header(
        [$n$],
        [$f(n, T)$],
        [*Cash Flow*],
        [*Margin - 1\
          (Beginning of Day)*],
        [*Payment*],
        [*Margin - 2\
          (End of Day)*],
      ),
      [0], [140], [], [], [-14], [14],
      [1], [138], [-2], [12], [0], [12],
      [2], [130], [-8], [4], [-2.5], [6.5],
      [3], [140], [10], [16.5], [9.5], [7],
      [4], [150], [10], [17], [9.5], [7.5],
    )
  ]
]

== Options

#definition[Option][
  It is a financial derivative that gives the holder the right, but not the obligation, to buy or sell an underlying asset at a specified price on or before a specified date.
]
Options are used for hedging, speculation, and income strategies. The two main types are:
- *Call Option*: Right to buy the underlying asset.
- *Put Option*: Right to sell the underlying asset.
The buyer pays a premium for this right. If the option is not exercised, it expires worthless.

#definition[Premium][
  It is the price paid by the buyer to the seller for the rights conveyed by the option. This payment is made upfront and is non-refundable.
]
#definition[Strike/Exercise Price][
  It is the predetermined price at which the underlying asset can be bought or sold if the option is exercised.
]
#definition[Expiration/Delivery/Exercise Date][
  It is the date on which the option expires and can no longer be exercised.
]

=== Call Option

The buyer has the right to buy the underlying asset at the strike price on or before the expiration date#footnote[The on or before part is different for different types of options]. The buyer pays a premium for this right.

The seller has an obligation to sell the underlying asset at the strike price ($k$) if the buyer exercises the option.

Thus, at $T$, if $S(T) > k$, the buyer will execute his call option to lock the payoff of $S(T) - k - P$, where $P$ is the premium paid for the option.
$
   "Call Option Value" & = max(S(T) - K, 0) equiv (S(T) - K)^+ \
  "Call Option Payoff" & = (S(T) - K)^+ - C e^(r T)
$

=== Put Option

The buyer has the right to sell the underlying asset at the strike price on or before the expiration date. The buyer pays a premium for this right.

The seller has an obligation to buy the underlying asset at the strike price ($k$) if the buyer exercises the option.

Thus, at $T$, if $S(T) < k$, the buyer will execute his put option to lock the payoff of $k - S(T) - P$, where $P$ is the premium paid for the option.
$
   "Put Option Value" & = max(K - S(T), 0) equiv (K - S(T))^+ \
  "Put Option Payoff" & = (K - S(T))^+ - P e^{r T}
$

#align(center)[
  #grid(
    columns: 2,
    figure(
      image("imgs/Long-Call-Option.png"),
      caption: [Call Option Pay-Off Curve],
    ),
    figure(
      image("imgs/Long-Put-Option.png"),
      caption: [Put Option Pay-Off Curve],
    ),
  )
]

#definition[Convex Function][
  If the secant lies above the tangent for any pair of points.
]

There are two types of options:
- *European Options*: These can only be exercised at expiration.
- *American Options*: These can be exercised at any time before expiration.

#lemma(numbering: none)[Put-Call Parity][
  Let $C^E (0)$ and $P^E (0)$ be the prices of European call and put options, respectively, with the same strike price $K$ and expiration date $T$. Then the put-call parity relationship is given by:
  $ C^E (0) - P^E (0) = S(0) - K e^(-r T) $
]

#proof[
  At $t = 0$, buy 1 call option at $C^E (0)$, sell 1 put option at $P^E (0)$ and deposit $K e^(-r T)$ at an interest rate $r$. Thus, our portfolio at $t = 0$ is,
  $
    V(0) = C^E (0) - P^E (0) + K e^(-r T)
  $
  At $t = T$, if $S(T) > K$, exercise the call option to buy the stock at $K$ making $V(T) = S(T)$, however, if $S(T) < K$, the other person exercises the put option to sell the stock at $K$ making $V(T) = K$.

  Moreover, we can see that simply holding the asset $S(0)$ makes our portfolio $S(T)$. Since, two different investments have the same value at $t = T$ (with absolute certainty), then the present values must also be equal:
  $
                           V(0) & = S(0) \
    therefore C^E (0) - P^E (0) & = S(0) - K e^(-r T)
  $
]

=== Pay Off Curves

Here, we will draw the pay-off curves for the combination of several options or a portfolio of options.

==== Bull Spread

Consider a portfolio of two options, $V = C_(K_1) - C_(K_2)$, where $K_2 > K_1$.#footnote[This just means that we are the holder of $C_(K_1)$ and the seller of $C_(K_2)$]

This strategy is viable when the underlying asset price is expected to rise moderately. The maximum loss occurs if the asset price falls below $K_1$, while the maximum gain is capped at $K_2 - K_1$.

==== Bear Spread

Consider a portfolio of two options, $V = C_(K_1) - C_(K_2)$, where $K_1 > K_2$.

This strategy is viable when the underlying asset price is expected to fall moderately. The minimum loss occurs if the asset price rises above $K_1$, while the maximum loss is capped at $K_1 - K_2$.

#grid(
  columns: 2,
  figure(
    image("imgs/Bull-Spread.png"),
    caption: [Bull Spread Pay-Off Curve],
  ),
  figure(
    image("imgs/Bear-Spread.png"),
    caption: [Bear Spread Pay-Off Curve],
  ),
)

==== Butterfly Spread

Consider a portfolio of three options, $V = C_(K_1) - 2 C_(K_2) + C_(K_3)$, where $K_1 < K_2 < K_3$. Here, we see an inverted triangle like graph.

=== Option Pricing

==== Single Period Binomial Lattice Model for European Options

We will model the price of a European call option using a single period binomial lattice with the following assumptions in mind:
- The price of the underlying stock is $S(0)$ at $t = 0$
- At the end of a period, the price will either be $u S(0)$ with probability $p$ or $d S(0)$ with probability $1 - p$, where $u > 1$ and $d < 1$ are the up and down factors, respectively.
- At every period, it is possible to borrow or lend at a risk-free interest rate $r$
- Moreover, $u > R > d > 0$ to avoid arbitrage opportunities, where $R = 1 + r$
#align(center)[
  #grid(
    columns: 2,
    gutter: 10em,
    figure(
      diagram(
        node(
          (1, 1),
          $t = T\
          u S(0)$,
        ),
        edge($p$, "<-"),
        node((0, 0), [$t = 0$\
          $S(0)$]),
        edge($1-p$, "->"),
        node(
          (1, -1),
          $t = T\
          d S(0)$,
        ),
      ),
    ),
    figure(
      diagram(
        node((1, 1), $1 + r = R$),
        edge("<-"),
        node((0, 0), $1$),
        edge("->"),
        node((1, -1), $1 + r = R$),
      ),
    ),
  )
]

#figure(
  diagram(
    node((1, 1), $C_u = (u S(0) - K)^+$),
    edge($p$, "<-"),
    node((0, 0), $C(T)$),
    edge($1-p$, "->"),
    node((1, -1), $C_d = (d S(0) - K)^+$),
  ),
  caption: [Call Option Pay-Off at Maturity],
)

Now, let us design a replicating portfolio of bonds#footnote[This is the same as investing the money in the bank here and represents a fixed-income security] and stocks such that its future value is equal to the value of the all option. Let the number of bonds be $a$ and the number of stocks be $b$, i.e. $p = (a, b)$.
$
  V_p(T) = C(T)
$
The present value of the portfolio is,
$
  V_p(0) = a B(0) + b S(0)
$
Moreover, using the above diagram, we can say that the value of $V_p$ at $t = T$ is,
$
  V_p(T) = cases(
    a R B(0) + b u S(0) "with" p,
    a R B(0) + b d S(0) "with" 1 - p,
  )
$

Since the future value of the portfolio must equal the future value of the option, we have

$
                                                V_p(T) & = C(T) \
                       a R B(0) + b u S(0) = C_u space & and space a R B(0) + b d S(0) = C_d \
  therefore a = (u C_d - d C_u)/(R (u - d) B(0)) space & and space b = (C_u - C_d)/(S(0) (u - d))
$

To make the market arbitrage free,
$
          V_p(0) & = C(0) \
         => C(0) & = a B(0) + b S(0) \
  therefore C(0) & = 1/R [C_u ((R- d)/(u - d)) + C_d ((u - R)/(u - d))]
$
Clearly, if $hat(p) = (R - d)/(u - d)$ and $hat(q) = (u - R)/(u - d)$, then we can express the option price as a risk-neutral expectation:

$
  C(0) & = 1/R [hat(p) C_u + hat(q) C_d]
$

Here, $hat(p)$ is a risk-neutral probability measure. Moreover,
$
         E[C(1)] & = hat(p) C_u + hat(q) C_d \
  therefore C(0) & = 1/R [E[C(1)]]
$
Thus, the present value is the expected value discounted at the risk-free rate.

==== Multi-Period Binomial Lattice Model for European Options

We can extend the single period binomial lattice to a multi-period binomial lattice with $n$ periods. Here, at each period, the stock price can either go up by a factor of $u$ or down by a factor of $d$. Thus, at the end of $n$ periods, the stock price can take $n + 1$ possible values.

For simplicity, let us consider a 2-period binomial lattice with the same assumptions as before.
#figure(diagram(
  node(
    (2, 2),
    $t = 2\
    u^2 S(0)$,
  ),
  edge($p$, "<-"),
  node(
    (1, 1),
    $t = 1\
    u S(0)$,
  ),
  edge((1, 1), (2, 0), $1-p$, "->"),
  edge($p$, "<-"),
  node((0, 0), [$t = 0$\
    $S(0)$]),
  edge($1-p$, "->"),
  node(
    (1, -1),
    $t = 1\
    d S(0)$,
  ),
  edge($p$, "->"),
  node(
    (2, 0),
    $t = 2\
    u d S(0)$,
  ),
  node(
    (1, -1),
    $t = 1\
    d S(0)$,
  ),
  edge($1-p$, "->"),
  node(
    (2, -2),
    $t = 2\
    d^2 S(0)$,
  ),
)),

#figure(diagram(
  node((2, 2), $C_(u u) = (u^2 S(0) - K)^+$),
  edge($p$, "<-"),
  node((1, 1), $C_u = display(1/R [hat(p)C_(u u) + (1- hat(p))C_(u d)])$),
  edge((1, 1), (2, 0), $1-p$, "->"),
  edge($p$, "<-"),
  node((0, 0), [$C(0)$]),
  edge($1-p$, "->"),
  node(
    (1, -1),
    $C_d = display(1/R [hat(p)C_(u d) + (1- hat(p))C_(d d)])$,
  ),
  edge($p$, "->"),
  node(
    (2, 0),
    $C_(u d) = (u d S(0) - K)^+$,
  ),
  node(
    (1, -1),
    $C_d = display(1/R [hat(p)C_(u d) + (1- hat(p))C_(d d)])$,
  ),
  edge($1-p$, "->"),
  node(
    (2, -2),
    $C_(d d) = (d^2 S(0) - K)^+$,
  ),
))

Thus, we can see that the option price at any node is the discounted expected value of the option prices at the next nodes.
$
  therefore C(0) = 1/R^2 [hat(p)^2 C_(u u) + 2 hat(p)(1 - hat(p)) C_(u d) + (1 - hat(p))^2 C_(d d)]
$
Generalising this to $n$ periods, we get,
$
  C(0) = 1/R^n sum_(i=0)^n binom(n, i) hat(p)^i (1 - hat(p))^(n-i) C_(u^i d^(n-i))
$

#lemma(numbering: none)[
  If $u > R > d$ does not hold, then the no arbitrage principle is violated.
]
#proof[
  Let $R >= u > d$, then we construct a portfolio, $p = (a = -1/(S(0)), b = 1/(B(0)))$.
  $
    V_p(0) & = a B(0) + b S(0) = 0 \
    V_p(T) & = cases(
      -u/(S(0)) S(0) + R/(B(0)) B(0) = R - u >= 0 "with" p,
      -d/(S(0)) S(0) + R/(B(0)) B(0) = R - d >= 0 "with" 1 - p,
    ) \
    & = cases(
      R - u > 0 "with" p,
      R - d >= 0 "with" 1 - p,
    ) \
    therefore V_p(T) & >= 0 "with absolute certainty"
  $
  Thus, we have an arbitrage opportunity which violates the no arbitrage principle.

  Let $u > d >= R$, then we construct a portfolio, $p = (a = 1/(S(0)), b = -1/(B(0)))$.
  $
    V_p(0) & = a B(0) + b S(0) = 0 \
    V_p(T) & = cases(
      u/(S(0)) S(0) - R/(B(0)) B(0) = u - R >= 0 "with" p,
      d/(S(0)) S(0) - R/(B(0)) B(0) = d - R >= 0 "with" 1 - p,
    ) \
    & = cases(
      u - R >= 0 "with" p,
      d - R > 0 "with" 1 - p,
    ) \
    therefore V_p(T) & >= 0 "with absolute certainty"
  $
  Thus, we have an arbitrage opportunity which violates the no arbitrage principle.
]

#theorem[First Fundamental Theorem of Asset Pricing][
  A market is arbitrage-free if and only if there exists at least one risk-neutral probability measure.
]
#definition[Risk-Neutral Probability Measure][
  It is a probability measure under which the discounted price processes of tradable assets are martingales. It is a vector $hat(p) = (hat(p_1), hat(p_2), \ldots, hat(p_n))$, where
  - $sum hat(p_i) = 1$
  - $hat(p_i) >= 0 forall i$
  - $forall$ security $k$ we have $S^k (0) = display((E_hat(p)[S^k (T)])/R)$ where $S^k (T)$ is the value of the $k^"th"$ security at time $T$.
]

==== Option Pricing on Dividend Paying Stock

If the stock pays a dividend $D$ at time $tau in [0, T]$, then we subtract $D$ from the values of all the nodes at point $tau$ and then calculate the option price as before.

==== Multi-Period Binomial Lattice Model for American Options

We can use the same multi-period binomial lattice model for American options with a slight modification. Here, at each node, we check if exercising the option immediately is more profitable than holding it till maturity.

= Advanced Pricing Models

Option Theory was revolutionized by the Black-Scholes-Merton Model#footnote[Given by Fischer Black, Myron Scholes, and Robert Merton] (which also got a Nobel Prize) in 1973. This model provides a theoretical estimate of the price of European-style options and is widely used in the financial industry. Another great model is the CRR Model#footnote[Given by Cox, Ross and Rubinstein] which is a discrete-time model for option pricing.

The Black-Scholes-Merton Model is the limiting case of the CRR Model as the number of time steps approaches infinity.

== CRR Model

The CRR Model is a multi-period binomial lattice model with the following assumptions:
- The underlying stock pays no dividend
- No transaction costs or taxes are involved
- It is possible to borrow and lend at a risk-free interest rate $r$
- The no arbitrage principle holds and thus a risk-neutral probability measure exists
- The stock price follows a binomial distribution with up and down factors $u$ and $d$ respectively
- Divide the interval $[0, T]$ into $n$ subintervals of equal length $Delta t = T/n$. Take,
$
  E_k = cases(
    u "with" p,
    d "with" 1 - p,
  )
$
Where $k in [1, n]$ and $E_k$ follows the Bernoulli distribution#footnote[We remember that $sum "Bernoulli" = "Binomial"$].

The stock price at $T$ is given by,
$
  S(T) &= S(0) product_(k=1)^n E_k \
  => ln S(T) &= ln S(0) + H quad (H = sum_(k=1)^n ln E_k)
$

#thmbox(numbering: none, title: "Useful Results", variant: "")[
  $
    E[ln E_k] &= p ln u + (1 - p) ln d \
    "Var"(ln E_k) &= p (1 - p) (ln u - ln d)^2 \
  $
  Thus we see that $ln E_k$ follows,
  $
    ln E_k tilde D(p ln u + (1 - p) ln d, p (1 - p) (ln u - ln d)^2)
  $
  Which we can standardize as,
  $
    Z_k = (ln E_k - E[ln E_k])/sqrt("Var"(ln E_k)) tilde D(0, 1) => ln E_k = sqrt("Var"(ln E_k)) Z_k + E[ln E_k]
  $
]

Here, we can also define _drift_ $mu$ and _volatility_ $sigma$ as,
$
  E[ln E_k] = mu Delta t quad and quad "Var"(ln E_k) = sigma^2 Delta t
$
Thus, we also see that,
$
  ln E_k &= sigma sqrt(Delta t) Z_k + mu Delta t \
  => sum ln E_k & = sigma sqrt(Delta t) Y_k + mu T quad (Y_k = sum Z_k)
$
Here, $Y_k$ is a simple random walk.

#definition[Simple Random Walk][
  A random walk is a stochastic process where the random variable at each step is independent and identically distributed. $S_0 = 0$ and $S_n = sum_(i=1)^n X_i$ where $X_i$ is the random variable at the $i^"th"$ step.
]

#lemma(numbering: none)[
  For a CRR model with probability $p$ of going up and $1-p$ of going down, the stock price at time $T$ is given by,
  $
    S(T) = S(0) e^(mu T + sigma sqrt(T) Y_n)
  $
  where $mu$ is the drift and $sigma$ is the volatility.
]

#footnote[If $Y tilde N(mu, sigma^2)$, then, $e^Y tilde "LN"(mu, sigma^2)$]

$
  ln S(T)/S(0) = mu T + sigma sqrt(Delta t) Y_n tilde N(mu T, sigma^2 T)
$

#definition[Return][
  The return is any measure of the growth of an asset. Typically, it is the log return,
  $
    "Total Return" = ln S(T)/S(0) tilde N(mu T, sigma^2 T)
  $
  which is normally distributed with mean $mu T$ and variance $sigma^2 T$.

  The return at some time $t$ is given by,
  $
    R(T) = ln S(T)/S(T-1)
  $
]

Since, we were pretty stupid back then, we used $R(T) = (S(T) - S(T-1))/S(T-1)$ instead of $R(T) = ln S(T)/S(T-1)$.

== Mathing of CRR Model with Multi-Period Binomial Lattice Model

Using,
$
  E[ln E_k] = p ln u + (1 - p) ln d &= mu Delta t \
  "Var"(ln E_k) = p (1 - p) (ln u - ln d)^2 &= sigma^2 Delta t \
$

Assume#footnote[*This is a pretty big assumption*],
$
  u d &= 1 \
  => ln u + ln d &= 0 \
  therefore U + D &= 0 \
$

Using the above assumption, we get,
$
  U^2 &= (mu Delta t)^2 + sigma^2 Delta t \
  p &= 1/2 ((mu Delta t)/U + 1)
$
For sufficiently large $n$, we can use $(Delta t)^2 approx 0$, thus,
$
  U &= sigma sqrt(Delta t) \
  p &= 1/2 (mu/sigma sqrt(Delta t) + 1)
$
#footnote[It is to be noted that the above $p$ is not the RNPM but the actual probability of going up]
Thus, we can see that the CRR Model is a multi-period binomial lattice model with the up and down factors $u$ and $d$ respectively.

== Black-Scholes-Merton Model

Now, consider a counter on the up and down tick movements on the stock price at a time $k in [1, n]$ as a Bernoulli random variable.

$
  Y_k = cases(
    1 "with" p "if stock goes up",
    0 "with" 1 - p "if stock goes down",
  )
$
Then,
$
  S(T) &= S(0) u^(sum Y_k) d^(n - sum Y_k) \
  => ln S(T)/S(0) &= T/(Delta t) ln d + (ln u - ln d) sum_(k = 1)^(T/(Delta t)) Y_k
$
From the *CRR Model*, we know that $ln u = sigma sqrt(Delta t)$, $ln d = -sigma sqrt(Delta t)$ and $p = 1/2 (mu/sigma sqrt(Delta t) + 1)$. Thus, replacing these values, we get,
$
  ln S(T)/S(0) = (-sigma T)/(sqrt(Delta t)) + 2 sigma sqrt(Delta t) sum_(k = 1)^(T/(Delta t)) Y_k
$
Clearly, $E[Y_k] = p$ and $"Var"[Y_k] = p (1 - p)$, hence#footnote[Pretty obvious tbh, just put $n -> infinity$ for variance],
$
  E[ln S(T)/S(0)] &= mu T \
  "Var"[ln S(T)/S(0)] &= sigma^2 T \
$
Thus, we see that $ln S(T)/S(0) tilde N(mu T, sigma^2 T)$ under market probability measure $p$.

However, this is not the risk-neutral probability measure we need to price this shit. The RNPM is given by,
$
  hat(p) &= (R - d)/(u - d)
$
where $u = e^(sigma sqrt(Delta t)$, $d = u^(-1)$ and $R = e^(r Delta t)$. Plugging the first order approximations, we get,
$
  hat(p) = 1/2((2r - sigma^2)/(2 sigma) sqrt(Delta t) + 1)
$
Again, finding the mean and variance of the log return using RNPM we have,
$
  E[ln S(T)/S(0)] &= (r - sigma^2/2) T \
  "Var"[ln S(T)/S(0)] &= sigma^2 T \
$
Thus, we see that $ln S(T)/S(0) tilde N((r - sigma^2/2) T, sigma^2 T)$ under risk neutral probability measure $hat(p)$.

Finally, for the grand final, we calculate the price of the option,
$
  C(0) &= e^(r T) E_hat(p) [C(T)] \
  &= e^(r T) E_hat(p) [(S(0)e^w - k)^+] quad (w = ln S(T)/S(0)) \
  &= e^(r T) integral (S(0)e^w - k)^+ f_w (w) dd(w) quad (f_w (w) "is the PDF") \
  &= e^(r T) integral_(w >= w_1) (S(0)e^w - k) f_w (w) dd(w) quad (S(0)e^w - k >= 0 => w >= ln k/S(0) = w_1) \
$
If $X tilde N(mu, sigma^2)$, then,
$
  "PDF"(x) = (1/(sigma sqrt(2 pi))) e^(-1/2 ((x - mu)/sigma)^2)
$
$
  C(0) = e^(r T)/(sigma sqrt(2 pi T)) integral_(w >= w_1) (S(0)e^w - k) e^(-1/2 [(w - (r - sigma^2/2) T)/(sigma sqrt(T))]^2) dd(w)
$
Taking,
$
  y &= (w - (r - sigma^2/2) T)/(sigma sqrt(T)) => w = sigma sqrt(T) y + (r - sigma^2/2) T => dd(w) = sigma sqrt(T) dd(y) \
  w_1 &= ln k/S(0) => y_1 = 1/(sigma sqrt(T))[ln k/S(0) - (r - sigma^2/2) T] \
$
$
  C(0) &= e^(r T)/(sqrt(2 pi)) integral_(y >= y_1) (S(0)e^(sigma sqrt(T) y + (r - sigma^2/2) T) - k) e^(-y^2/2) dd(y) \
  &= e^(-r T)/(sqrt(2 pi)) integral_(y >= y_1) S(0) e^(y sigma sqrt(T) + (r - sigma^2/2)T - y^2 / 2) dd(y) - (k e^(-r T))/(sqrt(2 pi)) integral_(y >= y_1) e^(-y^2/2) dd(y) \
$
