# Developed by: Moazzam Hossain

# install lpSolveAPI
install.packages("lpSolveAPI")
# use libray
library(lpSolveAPI)

# Develop model named lpcom with 5 constraints and 2 decision variables
lpcom <- make.lp(5,2)

# develop objective function to maximize profit
lp.control(lpcom, sense="max")
set.objfn(lpcom, c(600,300))

# add constraints to the model
add.constraint(lpcom, c(1,1),"<=", 2000)
add.constraint(lpcom, c(1,0), ">=", 1000)
add.constraint(lpcom, c(1,0), "<=", 2000)
add.constraint(lpcom, c(0,1), ">=", 800)
add.constraint(lpcom, c(0,1), "<=", 1700)

# view the model
lpcom

# solve the model
solve(lpcom)

# get objective value (maximum profit)
get.objective(lpcom)

# get the values of decision variables
get.variables(lpcom)