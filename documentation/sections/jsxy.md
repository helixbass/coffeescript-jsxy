## JSXY

JSXY aims to provide a nicer, whitespace-indented JSX syntax that fits well into
CoffeeScript's existing whitespace-indented style.
Its syntax is heavily inspired by [Haml](http://haml.info).
Standard JSX syntax is also supported,
but here we'll look at the whitespace-indented syntax
(compiled JS output on right)
#### Elements
Create JSX elements with `%element`.
An `import React from react` will automatically be included
at the top of the compiled JavaScript module.
It's your responsibility to include `react` in your project

```
codeFor('jsxy_elements')
```

Attributes/props can be supplied using `{}` or `()`.
`{}` attributes are parsed as CoffeeScript objects
so you can use eg object literal shorthands

```
codeFor('jsxy_attributes')
```

You can use Haml-style `#id` and `.class` shorthands

```
codeFor('jsxy_shorthand_elements')
```

With a `.class` element that's directly preceded by CoffeeScript code,
be careful to leave a blank line to distinguish it from a chained method call

```
codeFor('jsxy_leading_dot_class_vs_chain')
```

Since JSX allows element names like `Form.Field`, the second half is
interpreted as part of the element name if it's capitalized

```
codeFor('jsxy_dotted_element_name')
```

If you want to use a capitalized class name, use dynamic class name
syntax (see below) or a non-shorthand `className` attribute

```
codeFor('jsxy_capitalized_class_name')
```

If you want to use a non-capitalized dotted component name,
dereference it first

```
codeFor('jsxy_dereference_noncapitalized_component_name')
```

For dynamic class names, use `.()` shorthand.
This will compile to a call to `classNames()`,
so picture the parentheses as surrounding the arguments to `classNames()`.
It will also automatically include an `import classNames from classnames`
at the top of the compiled JavaScript module.
It's your responsibility to include `classnames` in your project

```
codeFor('jsxy_dynamic_class_names')
```

Nest child elements using indentation

```
codeFor('jsxy_nested_elements')
```

#### Text content
Text content can be indented or inline

```
codeFor('jsxy_text_content')
```

#### Expressions
To include expressions, use JSX-style `{}` or Haml-style `=`

```
codeFor('jsxy_expressions')
```

Since (in React) expressions/elements on adjacent lines won't be
separated by any whitespace by default, there's a `^` operator to 
force an expression or element to include a surrounding space between
itself and preceding/following siblings

```
codeFor('jsxy_whitespace_operator')
```

Since in CoffeeScript "everything is an expression", you get some
much nicer/more natural ways of doing things than in straight JSX/ES6.
To conditionally render a subcomponent, use `if`

```
codeFor('jsxy_if')
```

You can use any of the CoffeeScript conditional syntaxes, like `unless`

```
codeFor('jsxy_unless')
```

And inline postfix `if`/`unless`

```
codeFor('jsxy_postfix_if')
```

For alternatives, use `else`/`else if`.
As of now, when using `=` syntax, you must
indent your `else`/`else if` lines relative to the initial `= if` line

```
codeFor('jsxy_else')
```

Or use CoffeeScript's very nice `switch` syntax

```
codeFor('jsxy_switch')
```

To loop over child components, you can use `for` (rather than having to use `.map(callback)`)

```
codeFor('jsxy_for')
```

Or use inline postfix `for`

```
codeFor('jsxy_postfix_for')
```

Angular-style `|` filters are also supported inside JSXY expressions.
Since `:` is heavily used in CoffeeScript, the additional-argument delimiter is `~`.
You don't have to specially register filters like in Angular, any function can be used
as a filter

```
codeFor('jsxy_filters')
```
