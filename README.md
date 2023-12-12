# optimiser
A set of functions to implement optimisation of models

## create_random_grid
Creates a random search grid.

Initialise `parameter_space` with a list of variables to optimise, eg
```r
bounds <- list(list(type = "integer", lower = 0, upper = 10, name = "param1"),
               list(type = "continuous", lower = 0, upper = 1, name = "param2"),
               list(type = "categorical", options = c("A", "B", "C"), name = "param3"),
               list(type = "categorical", options = c("A", "B", "D"), name = "param4"))
```
Variables:

* `parameter_space`: Definition of the variables you want to generate the grid for. Must be defined as a list of lists. Sublists must list `type = c("integer", "continuous", "categorical")` and name (character). Integers and continuous variables must have lower and upper values, categorical variables must have options given as a list. The function will correct lower and upper so these do not necessarily need to be in the correct order.
* `test_vals`: the number of rows on the grid (parameter sets to try).
* `name_of_output_variable`: the name you want to give the output variable, which is a placeholder for results. Setting `name_of_output_variable = NA` (default) skips this step. Column is always at the end of the dataframe.
* `random_seed`: the seed you want to run the function with, so you always get the same result. `NA` skips this step, which is advised for production runs.
