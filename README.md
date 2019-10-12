# vlogsolv

vlogsolv is a small command line program that calculates value tables for simple logical expressions.
It is written completely in [V](https://github.com/vlang/v)

## Building

1. Install V
2. run `v .`

To get an optimized build (translated to C, then built) you can use `v -prod .`

## Usage

`./vlogsolv <expression>`

The following operators are available

- `!` Not
	- `!<exp>`
- `&` And
	- `<exp> & <exp>`
- `|` Or
	- `<exp> | <exp>`
- `=` Equivalence
	- `<exp> = <exp>`
- `>` Implication
	- `<expr> > <expr>`
- `T` True
- `F` False

All other symbols are interpreted as variables
You may need to escape some of the symbols depending on your shell. Spaces are ignored

## Example
`./vlogsolv (a | !b) & c`

```
Input:	(a | !b) & c
Prefix:	&|a!bc
Atoms:	["a", "b", "c"]

 a | b | c | value
---+---+---+-------
 1 | 1 | 1 | true
 1 | 1 | 0 | false
 1 | 0 | 1 | true
 1 | 0 | 0 | false
 0 | 1 | 1 | false
 0 | 1 | 0 | false
 0 | 0 | 1 | true
 0 | 0 | 0 | false
```
