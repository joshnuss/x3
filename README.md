# X3

A tiny functional language with pattern matching & tail recursion

## Example

```
# fibonacci.x3
fn fib
  0 -> 0
  1 -> 1
  n -> fib(n-1) + fib(n-2)
end

print fib(100)
```

Run it:

```
x3 fibonacci.x3
```
