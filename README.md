# FROST

**Note.** Originally hosted on GitLab at XAIN Foundation.

Experimental implementation of the FROST access control policy language.

## Getting Started

To build the project from source, GHC (Glasgow Haskell Compiler) is required.
The recommended way to install it is via [Stack](https://www.haskellstack.org).

The command

```
$ stack build
```

compiles the project, including the `frostc` executable.

```
$ frostc --help
frostc - a compiler for FROST

Usage: frostc ((-i|--ifile INFILE) | (-x|--iexpr EXPRESSION)) [-p|--pretty]
              [-c|--oconsole] [-o|--ofile OUTFILE]
  Synthesize a circuit-pair from a policy EXPRESSION or INFILE

Available options:
  -i,--ifile INFILE        Input file
  -x,--iexpr EXPRESSION    FROST expression
  -p,--pretty              Whether to pretty-print output
  -c,--oconsole            Whether to only output to console
  -o,--ofile OUTFILE       Output file (default: "out.json")
  -h,--help                Show this help text
```

## Compiling Policies

The tools in the project allow two modes of operation for building FROST
policies: using `frostc`, or as an EDSL (embedded domain-specific language)
library. The former is easier to start with.

