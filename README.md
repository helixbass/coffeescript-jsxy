CoffeeScript-JSXY adds [Haml](http://haml.info)-inspired whitespace-indented JSX syntax to CoffeeScript 2

## tl;dr
Write React/JSX code that looks like this:
```
Recipe = ({name, ingredients, steps}) ->
  %section.recipe.("recipe-#{name}")
    %h1= name
    %ul.ingredients
      = for {name}, i in ingredients
        %li{ key: i }
          = name
          =^ 'mmm...' if name is 'honey'
    .instructions
      %h2 Cooking Instructions
      = %RecipeStep{
        step
        key: i
      } for step, i in steps
```

## Installation

Once you have Node.js installed:

```shell
npm install coffeescript-jsxy
```

To swap out CoffeeScript proper for CoffeeScript-JSXY on an existing project, replace your `coffeescript` (or the older 1.x `coffee-script`) dependency with `coffeescript-jsxy`. As of now, uses the same `coffee` binary name as CoffeeScript

## Getting Started

CoffeeScript-JSXY is built on CoffeeScript 2.
It's intended to be a drop-in replacement for CoffeeScript 2 proper
(see below for possible [breaking changes](#breaking-changes))
that adds a nicer whitespace-indented JSX syntax.
See the [CoffeeScript website](http://coffeescript.org/v2) for CoffeeScript documentation.
Here we'll just document the differences from CoffeeScript 2 proper

## JSXY
### Background
##### JSX
[JSX](https://facebook.github.io/react/docs/introducing-jsx.html) is a syntax extension to JavaScript
that is primarily used in [React](https://facebook.github.io/react/).
It (and React as a whole) have proven extremely powerful and convenient.
But not to everyone's taste aesthetically
##### CoffeeScript
[CoffeeScript](http://coffeescript.org) is a stunningly gorgeous whitespace-indented language that transpiles into JavaScript.
[CoffeeScript 2](http://coffeescript.org/v2) is on the verge of being released.
It targets ES6 and helps make CoffeeScript a viable option (again) for modern JavaScript development.
It includes support for standard (non-whitespace-indented) JSX syntax out of the box

### Enter JSXY
JSXY aims to provide a nicer, whitespace-indented JSX syntax that fits well into
CoffeeScript's existing whitespace-indented style.
Its syntax is heavily inspired by [Haml](http://haml.info).
Standard JSX syntax is also supported.
Let's take a look (compiled JS output on right)
#### Elements
Create JSX elements with `%element` syntax
| <pre>  | <pre>          |
|   %div |   <div></div>; |
| </pre> | </pre>         |
Child


## Breaking changes
While breaking changes are relatively minimal,
some of the JSXY syntax potentially conflicts with existing CoffeeScript usage and so could require
a little cleanup when swapping out CoffeeScript proper for CoffeeScript-JSXY in an existing project.
Below are breaking changes starting with the most likely to break existing code:
#### #id vs comments
Allowing the shorthand `#id` syntax means that most comments now require an initial space, eg
`#some comment` must become `# some comment`.
Many would consider this good practice already
#### .class vs chaining
Any *nested* leading-dot (`.class`) elements are unambiguous.
But for "top-level" (ie intermixed directly with surrounding CoffeeScript) elements,
the `.class` syntax potentially conflicts with eg method chaining syntax (where a line starts with `.method()`).
Currently, you can indicate a `.class` element by leaving a blank line before it, so eg:
```
a
.b(x=1) # this is a method call

a

.b(x=1) # this is <div className='b' x={1}></div>
```
This could be annoying if you like to be able to leave blank lines between chained method calls,
so I plan to add a configuration option to control this behavior.
#### %tag vs modulo
Allowing `%tag` syntax means that the modulo (`%`) operator requires a space
before the second operand. Eg `a%b` should become `a % b`. Again, many would already consider
this to be good practice

## TODO
- configuration options for:
  - disallowing shorthand syntax (to minimize breaking changes)
  - suppressing/configuring auto-generated imports (ie of `React` and/or `classnames`)

To suggest a feature or report a bug: https://github.com/helixbass/coffeescript-jsxy/issues

The source repository: https://github.com/helixbass/coffeescript-jsxy.git
