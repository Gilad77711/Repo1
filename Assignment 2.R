makeCacheMatrix <- function(x = matrix()) {
  inversed <- NULL
  set <- function(y) {
    x <<- y
    inversed <<- NULL
  }
  get <- function() x
  setreverse <- function(reverse) inversed <<- reverse
  getmean <- function() inversed
  list(set = set, get = get, setreverse = setreverse, getreverse = getreverse)
}

cachesolve <- function(x, ...) {
  inversed <- x$getreverse()
  if(!is.null(inversed)) {
    message("Getting Cached Data")
    return(inversed)
  }else{
  data <- x$get()
  inversed <- solve(data)
  x$setreverse(inversed)
  inversed
  }
}