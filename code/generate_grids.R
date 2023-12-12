# Generate random grid
create_random_grid <- function(parameter_space, 
                               test_vals = 10,
                               name_of_output_variable = NA,
                               random_seed = NA)
{
    # Do checks
    if(test_vals < 0) return("Error: test_val should be non-negative")
    if(length("response") != 1) return("Error: response should be a string")
    if(nchar("response") < 1) return("Error: response should have at least one character")
    
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
            # Check that lower and upper are the right way round
            lower_bound <- min(bounds[[i]][["lower"]], bounds[[i]][["upper"]])
            upper_bound <- max(bounds[[i]][["lower"]], bounds[[i]][["upper"]])
            
            # Generate vector
            random_grid[i] <- runif(n = test_vals, min = lower_bound, max = upper_bound)
        
        } else if(bounds[[i]][["type"]] == "categorical") 
        {
            random_grid[i] <- sample(x = bounds[[i]][["options"]], size = test_vals, replace = TRUE)
        } 
        
    }

    # Generate output variable column
    if(!is.na(name_of_output_variable))
    {
        random_grid$response <- NA
        colnames(random_grid)[length(bounds) + 1] <- name_of_output_variable
    }
    return(random_grid)
}
