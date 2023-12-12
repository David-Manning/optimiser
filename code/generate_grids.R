# Generate random grid
create_random_grid <- function(parameter_space, 
                               test_vals = 10,
                               name_of_output_variable = "response",
                               sequence_type = "random",
                               random_seed = NA)
{
    # Do checks
    if(test_vals < 0) return("Error: test_val should be non-negative")
    if(!sequence_type %in% c("random", "sobol", "halton")) return("Error: sequence_type should be one of random, sobol, halton") 
    if(
  
    # Set seed if applicable
    if(!is.na(random_seed)) set.seed(random_seed)
    
    # Initialise grid
    random_grid <- data.frame(matrix(nrow = test_vals, ncol = length(bounds)))
    
    # Generate column
    for(i in seq_along(bounds))
    {
        # Assign column name - should take this out
        colnames(random_grid)[i] <- bounds[[i]][["name"]]
        
        # Decide what to do for each type of input and put this value in the right column
        if(bounds[[i]][["type"]] == "integer") 
        {
            random_grid[i] <- sample(x = bounds[[i]][["lower"]]:bounds[[i]][["upper"]], size = test_vals, replace = TRUE)
        } else if(bounds[[i]][["type"]] == "continuous") 
        {
            random_grid[i] <- runif(n = test_vals, min = bounds[[i]][["lower"]], max = bounds[[i]][["upper"]])
        } else if(bounds[[i]][["type"]] == "categorical") 
        {
            random_grid[i] <- sample(x = bounds[[i]][["options"]], size = test_vals, replace = TRUE)
        } 
        
    }

    # Generate output variable column
    random_grid$response <- NA
    colnames(random_grid)[length(bounds) + 1] <- name_of_output_variable
    return(random_grid)
}
