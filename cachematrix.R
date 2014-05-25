## The function, makeCacheMatrix is a function that creates a vector object that
## does the following:
## 
## 1. set the value of the matrix to be solved (caches the matrix)
## 2. get the value of the matrix to be solved (retrieves the cached matrix)
## 3. set the value of the inverted matrix (cache the inversed matrix)
## 4. get the value of the inverted matrix (retrieves the inversed matrix)

## This assignment uses the Package R.cache and assumes that R.cache is
## installed on the local computer.
## 
## Bengtsson, H. The R.oo package - Object-Oriented Programming with References 
## Using Standard R Code, Proceedings of the 3rd International Workshop on 
## Distributed Statistical Computing (DSC 2003), ISSN 1609-395X, 
## Hornik, K.; Leisch, F. & Zeileis, A. (ed.), 2003
## ----------------------------------------------------------------------------


makeCacheMatrix <- function (x, ...) {
    m <- as.matrix
    y <- as.matrix
    x <- as.matrix
    
    cacheDir <- getCacheRootPath                # Get the path
                                                # of the directory where the 
                                                # cache file is stored or
                                                # sets a default directory
                                                # if no cache directory is 
                                                # set.
    
    m <- NULL                                   # Set up to determine if the matrix was 
                                                # previously called.    
    
    setmatrix <- function(y){                   # Function to cache the matrix for                       
 #      x <<- y                                 # subsequent retrieval
        m <<- NULL
    }
    
    evalWithMemoization(setmatrix)              # R.cache function to evaluate
                                                # a matirx to determine if
                                                # it has already been evaulated.
                                                
    getmatrix <- function() {                   # Function to retrieve cached 
        x                                       # matrix.
    }
    
    setinverse <- function() {                  # Function to solve for the 
        x                                       # inverse of the matrix 
        rootPath <- getCacheRootPath()          #   Retrives the local 
                                                #   directories where the 
                                                #   cache files are stored.
                                                
        m <- memoizedCall(dirs=rootPath, "cacheSolve") # The R.cache 
                                                #   memoizedCall calls the  
                                                #   function and captures the 
                                                #   results to be retrieved
                                                #   if the function is called
                                                #   again with the exact
                                                #   arguments.    
    }                                           # 
    
    getinverse <- function()    {               # Function to retrieve cached     
                                                # inverse matrix.
        m <- memoizedCall(dirs=rootPath, "cacheSolve") # This R.cache function  
    }                                           #   also loads saved data resuts
                                                #   from the file cache if  
                                                #   the same arguments are being
                                                #   reevaluated.
    
    list(setmatrix = setmatrix,                 # List to assign labels to 
         getmatrix = getmatrix,                 # the function for easy
         setinverse = setinverse,               # identification.
         getinverse = getinverse)
}

# ------------------------------------------------------------------------
# The cacheSolve funtion takes a square matrix as input and computes
# its inverse. This function is called from the R.cache function
# memoizedCall. The memoizedCall performs a check to determine
# if a previous calcuation for cacheSolve exists for the same 
# agruments. If there is cached results, the memoizedCall function
# retrieves the previous results and does not call this function.
# If there are no previous calls, the memoizedCall function calls this
# function to compute the values. The memoizedCall function also 
# saves the function for subsequent calls with the same arguments.
# The R.cache saveCache function is included here in the event an
# alternate method for retrieving results is needed.
# This function assumes that all square matricies input are can be
# inversed.

cacheSolve <- function(x, ...) {
    m <- solve(x)                              # Exeucte the solve function 
                                               # to compute the inverse        
    saveCache (m, dir=rootPath, "cacheSolve", key==NULL ) # inverse in memory.
    m                                          # Cache the results of the
                                               # computation.      
}
