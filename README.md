Simple Linear Programming Model
================

Business Problem
----------------

XYZ computer company produces laptop and desktop computers. The expected demand for laptops to be at least 1,000, and for desktops to be at least 800 per day. (Assumption: production is in accordance with the demand) The production facility has a limited capacity of no more than 2,000 laptops and 1,700 desktops per day. At most 2,000 computers per day must be satisfied. Each laptop computer generates $600 net profit and each desktop computer generates $300 net profit.

The company wants to determine how many of each type should be made daily to maximize net profits.

Solution
--------

This is an Optimization (a type of prescriptive modeling) problem. Since the objective is to maximize (optimize) profit, optimization using Linear Programming (LP) may be used to solve this problem.

### Problem Summary:

|                    |   Laptop  |    Desktop|      Total|
|--------------------|:---------:|----------:|----------:|
| Demand/day         | &gt;=1000 |   &gt;=800|           |
| Capacity/day       | &lt;=2000 |  &lt;=1700|           |
| Profit($)/computer |    600    |        300|   Maximize|
| Computers          |     X     |          Y|  &lt;=2000|
|                    |           |           |           |

#### Decision Variables:

**X**: number of laptops made daily

**Y**: number of desktops made daily

#### Objective Function:

**600*X + 300*Y = Z (Maximum Profit)**

#### Constraints:

1.  Total production of laptop and desktop per day must be less than or equal to 2000: **X+Y &lt;=2000**

2.  Production facility has the limitation of maximum 2000 laptops: **X&lt;=2000**

3.  Production facility has the limitation of maximum 1700 desktops: **Y&lt;=1700**

4.  The demand for laptops is at least 1000: **X&gt;=1000**

5.  The demand for desktops is at least 800 respectively: **Y&gt;=800**

``` r
# install lpSolveAPI
if(!require(lpSolveAPI)){install.packages("lpSolveAPI")}
```

    ## Loading required package: lpSolveAPI

    ## Warning: package 'lpSolveAPI' was built under R version 3.5.2

``` r
# use libray
library(lpSolveAPI)

# Develop model named lpcom with 5 constraints and 2 decision variables
lpcom <- make.lp(5,2)

# develop objective function to maximize profit
lp.control(lpcom, sense="max")
```

    ## $anti.degen
    ## [1] "fixedvars" "stalling" 
    ## 
    ## $basis.crash
    ## [1] "none"
    ## 
    ## $bb.depthlimit
    ## [1] -50
    ## 
    ## $bb.floorfirst
    ## [1] "automatic"
    ## 
    ## $bb.rule
    ## [1] "pseudononint" "greedy"       "dynamic"      "rcostfixing" 
    ## 
    ## $break.at.first
    ## [1] FALSE
    ## 
    ## $break.at.value
    ## [1] 1e+30
    ## 
    ## $epsilon
    ##       epsb       epsd      epsel     epsint epsperturb   epspivot 
    ##      1e-10      1e-09      1e-12      1e-07      1e-05      2e-07 
    ## 
    ## $improve
    ## [1] "dualfeas" "thetagap"
    ## 
    ## $infinite
    ## [1] 1e+30
    ## 
    ## $maxpivot
    ## [1] 250
    ## 
    ## $mip.gap
    ## absolute relative 
    ##    1e-11    1e-11 
    ## 
    ## $negrange
    ## [1] -1e+06
    ## 
    ## $obj.in.basis
    ## [1] TRUE
    ## 
    ## $pivoting
    ## [1] "devex"    "adaptive"
    ## 
    ## $presolve
    ## [1] "none"
    ## 
    ## $scalelimit
    ## [1] 5
    ## 
    ## $scaling
    ## [1] "geometric"   "equilibrate" "integers"   
    ## 
    ## $sense
    ## [1] "maximize"
    ## 
    ## $simplextype
    ## [1] "dual"   "primal"
    ## 
    ## $timeout
    ## [1] 0
    ## 
    ## $verbose
    ## [1] "neutral"

``` r
set.objfn(lpcom, c(600,300))

# add constraints to the model
add.constraint(lpcom, c(1,1),"<=", 2000)
add.constraint(lpcom, c(1,0), ">=", 1000)
add.constraint(lpcom, c(1,0), "<=", 2000)
add.constraint(lpcom, c(0,1), ">=", 800)
add.constraint(lpcom, c(0,1), "<=", 1700)

# view the model
lpcom
```

    ## Model name: 
    ##             C1    C2            
    ## Maximize   600   300            
    ## R1           0     0  free     0
    ## R2           0     0  free     0
    ## R3           0     0  free     0
    ## R4           0     0  free     0
    ## R5           0     0  free     0
    ## R6           1     1    <=  2000
    ## R7           1     0    >=  1000
    ## R8           1     0    <=  2000
    ## R9           0     1    >=   800
    ## R10          0     1    <=  1700
    ## Kind       Std   Std            
    ## Type      Real  Real            
    ## Upper      Inf   Inf            
    ## Lower        0     0

``` r
# solve the model
solve(lpcom)
```

    ## [1] 0

``` r
# get objective value (maximum profit)
get.objective(lpcom)
```

    ## [1] 960000

``` r
# get the values of decision variables
get.variables(lpcom)
```

    ## [1] 1200  800

Results:
--------

1.  Optimal number of laptop is 1200 and desktop is 800
2.  The value of the objective function (total net profit) is : $960,000
