# Function

Functions are created using the `function()` directive and are stored as R objects just like anything else. They are R objects of class "function".

```R
f <- function(<arguement>) {
		## Do something interesting
}
```

Functions in R are "first class objects", which means that they can be treated much like any other R object. Importantly,

- Functions can be passed as arguments to other function
- Functions can be nested, so that you can define a function inside of another function. The return value of a function is the last expression in the function body to be evaluated.

## Function Arguments

Functions have *named arguments* which potentially have *default* values.

- The *formal arguments*  are arguments included in the function definition
- The `formals` function returns a list of the formal arguments of a function
- Not every function call in R makes use of all the formal arguments.
- Function arguments can be missing or might have default values.

## Argument Matching

R functions arguments can be matched positionally or by name. So the following calls to `sd` are equivalent

```R
> mydata <- rnorm(100)
> sd(mydata)
[1] 1.124079
> sd(x = mydata)
[1] 1.124079
> sd(x = mydata, na.rm = FALSE)
[1] 1.124079
> sd(na.rm = FALSE, x = mydata)
[1] 1.124079
> sd(na.rm = FALSE, mydata)
[1] 1.124079
```

Even though it is equivalent, it is not recommended messing around with the order of the arguments too much, since it can lead to some confusion.

We can mix positional matching with matching by name. When an argument is match by name, it is "taken out" of the argument list and the remaining unnamed arguments are matched in the order that they are listed in the function definition

```r
> args(lm) ## linear model
function(formula, data, subset, weights, na.action, method = "qt", model = TURE, x= FALSE, y = FALSE, qr = TURE, singular.ok = TURE, contrasts = NULL, offset, ...)
```

The following two calls are equivalent

```r
la(data = mydata, y - x, model = FALSE, 1:100)
la(y -x, mydata, 1:1000, model = FALSE)
```

- Most of the time, named arguments are useful on the command line when you have a long argument list and you want to use the defaults for everything except for an argument near the end of the list
- Named arguments also help if we remember the name of the argument and not its position on the argument list(plotting is a good example)

Function arguments can also be *particularly* matched which is useful for interactive work. The order of operations when given argument is

1. Check for exact match for a named argument
2. Check for a partial match
3. Check for a positional match

## Defining A Function

```r
f <- function(a, b = 1, c = 2, d = NULL) {

}
```

In addition to not specifying a default value, you can also set an argument value to `NULL `

## Lazy Evaluation

Arguments to functions are evaluated *easily*, so they are evaluated only as needed.

```r
f <- function(a, b) { ## Never use b, so wont do anything to b
	a^2
}
f(2)
```

```r
## [1] 4
```

This function never actually uses the argument `b` , so calling `f(2)` will not produce an error because the 2 gets positionally matched to `a`.

```r
f <- function(a, b) {
	print(a)
	print(b)
}
f(45)
```

``` r
## [1] 45
## Error: argument 'b' is missing, with no default
```

Notice that "45" got printed first before the error was triggered. This is because `b` did not have to be evaluated until after `print(a)`. Once the function tried to evaluate `print(b)`, it had to throw an error.

##  The "..." Argument

The `...` argument indicate a variable number of arguments that are usually passed on to other functions.

- .., is often used when extending another function and you don't want to copy the entire argument list of the original function

```r
myplot <- function(x, y, type = "1", ...){
		plot(x, y, type = type, ...)
}
```

- Generic functions(itself do nothing, dispatch methods to put, according to different types of data ) use ... so that extra arguments can be passed to methods(more on this later)

```r
> mean
function(x, ...)
UseMethod("mean")
```

The ... argument is also necessary when the number of arguments passed to the function cannot be known in advance.

```r
> args(paste)
function(..., sep = " ", collapse = NULL)
    
> args(cat)
function(..., file = " ", sep = " ", fill = FALSE, labels = NULL, append = FALSE)
```

 One catch with .. is that any arguments that appear *after* ... on the argument list must be named explicitly and cannot be partially matched.

```r
> args(paste)
function(..., sep = "", collapse = NULL)

> paste("a". "b", sep = "i")
[1] "a:b"

> paste("a", "b", se = "i")
[1] "a b :"
```

