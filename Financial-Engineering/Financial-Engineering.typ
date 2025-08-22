#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#set page(margin: (
  top: 0.5in,
  bottom: 0.5in,
  x: 0.5in
))

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

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
$ V_n &= V_(n-1)(1 + r) \
V_n/V_(n-1)&= 1 + r $
Thus, this forms a geometric progression such that $V_0=P$,
$ therefore V_n = P(1 + r)^n $
The growth rate is $gamma = (1 + r)^n$ which is exponential.

However, if the interest is compounded $m$ times in an interval, then,
$ V_n = P(1 + r/m)^(n m) $

Now, if we consider the interest to be compounded continuously, i.e.
$ lim_(m arrow infinity) V_n = P e^(r n) $

#definition[Effective Rate][
  This is used to check which compounding method is more beneficial.
  $ (1 + r/m)^m &= (1 + r_("eff")) \
  therefore r_("eff") &= (1 + r/m)^m - 1 $
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
$ V = c  n + F $

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
$ P &= sum_1^(m n) (c/ m)/ (1 + y/m)^i + F/(1 + y/m)^(m n) \ 
  &= F/(1 + y/m)^(m n) + c/ y [ 1- 1 / (1 + y/m)^(m n) ]
$

Now, if we consider the yield to be compounded continuously, we get,
$ P_t = F e^(-y(T- t)) + c((1-e^(-y(T-t)))/(e^((T-t)/n))) $

When the coupon rate is less than the yield, i.e. the price is less than the face value, we say that the bond is issued at a discount. When the price is more than the face value, the bond is issued at a premium. We can see this with the following,
$
P &= sum (c F)/(1+c)^i + F/(1 + c)^n \
&= F
$
Thus, if $c = y$, then the bond price is the same as the face value.

=== Price-Yield Curves

==== Effect of Coupon Rates

#figure(
  image("imgs/Effect-Of-Coupon-Rate.png", height: 25%),
  caption: [Effect of Coupon Rate on Price-Yield Curve]
)

==== Effect of Time of Maturity

#figure(
  image("imgs/Effect-Of-Maturity.png", height: 25%),
  caption: [Effect of Time of Maturity on Price-Yield Curve]
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
P_t &= (c_t)/(1 + y)^t \
=> dd(P)/dd(y) &= -t/(1+y) P_t
$
Using the definition of the Macaulay Duration,
$
D_M &= (sum t P_t)/(sum P_t) \
sum t P_t &= D_M P quad (P = sum P_t) \
1/P dd(P)/dd(y) &= -D_M/(1 + y) = -D_M '
$

=== Yield Curves

#figure(
  image("imgs/Yield-Maturity-Curves", height: 25%),
  caption: [Yield vs Time of Maturity Curves]
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
  caption: [Pay-Off - Asset Price Relation for Long and Short Positions]
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
$ F(t, T) = S(0)g(t, T) = (S(0))/(d(t, T))  quad (d(t, T) " is the discount rate")$
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
