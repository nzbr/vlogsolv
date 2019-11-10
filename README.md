# <div align=center>vlogsolv</div>

<p align=center>
	<img alt="GitHub" src="https://img.shields.io/github/license/nzbr/vlogsolv">
	<a href="https://actions-badge.atrox.dev/nzbr/vlogsolv/goto"><img alt="Build Status" src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fnzbr%2Fvlogsolv%2Fbadge&style=flat" /></a>
	<a href="https://aur.archlinux.org/packages/vlogsolv/"><img alt="AUR version" src="https://img.shields.io/aur/version/vlogsolv"></a>
</p>

vlogsolv is a small command line program that calculates value tables for logical expressions.
It is completely written in [V](https://github.com/vlang/v)

## Building

1. Install V
2. run `v .`

To get an optimized build (translated to C, then built) you can use `v -prod .`

## Usage

`./vlogsolv <expression>`

The following operators are available

- `!` Not
- `&` And
- `|` Or
- `=` Equivalence
	- `(a & b) | (!a & !b)`
- `>` Implication
	- `!a | (a & b)`
- `<` Converse Implication
	- `b > a`
- `^` Exclusive Or
	- `(a | b) & !(a & b)`
- `T` True
- `F` False

All other symbols are interpreted as variables
You may need to escape some of the symbols depending on your shell. Spaces are ignored

## Example
`./vlogsolv '(a | !b) & c'`

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
