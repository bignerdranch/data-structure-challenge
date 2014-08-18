# Ruby Data Structure Hack Night

Implement lists and dicts from Plain Ol' Ruby Objects. Their interfaces are a
compatible subset of Ruby Arrays and Hashes.

### Gold Challenge

Re-implement a Ruby `Array`, calling it a `List`. You may choose whatever
internal implementation you like, so long as it conforms to the built-in Array
interface and the specs pass.

### Diamond Challenge

Re-implement a Ruby `Hash`, calling it a `Dict`. This challenge depends on the
Gold Challenge having been completed already. All internals must rely on your
own `List` implementation, and not an `Array`.

## To Compete

0. Fork this repository
0. Use Ruby 2.1.2 (`rvm use 2.1.2` if you use RVM)
0. Run `bundle`
0. Run `bin/rspec` to see failing specs
0. Code until specs are passing
0. Open a pull request by the deadline. The last commit made before the
   deadline will be evaluated.

## Evaluation

Review pull request to make sure the qualification code and specs have not been
altered.

Qualify to ensure no built-in `Array` or `Hash` usage. Run the specs
to verify a working implementation:

```sh
bin/qualify
bin/rspec
```

Run the performance benchmarks to choose a winner:

```sh
bin/benchmark
```
