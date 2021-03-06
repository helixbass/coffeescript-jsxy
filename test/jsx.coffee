# JSXY
# ----

test 'simple inline element', ->
  # element = %h1 Hello, world!
  eqJS(
    '%h1 Hello, world!'
    '''
    import React from 'react';

    <h1>
      Hello, world!
    </h1>;
    '''
  )

test 'simple indented element', ->
  eqJS(
    '''
    %h1
      Hello, world!
    '''
    '''
    import React from 'react';

    <h1>
      Hello, world!
    </h1>;
    '''
  )

test 'simple nested element', ->
  eqJS(
    '''
    %h1
      %a
        Hello, world!
    '''
    '''
    import React from 'react';

    <h1>
      <a>
        Hello, world!
      </a>
    </h1>;
    '''
  )

test 'inline element, no body', ->
  eqJS(
    '%h1'
    '''
    import React from 'react';

    <h1></h1>;
    '''
  )

test 'inline element with parenthesized attributes', ->
  eqJS(
    '''%h1( a="b" c='def' g={h + i})'''
    '''
    import React from 'react';

    <h1 a="b" c='def' g={h + i}></h1>;
    '''
  )

test 'inline element with parenthesized attributes and content', ->
  eqJS(
    '''%h1( a="b" c='def' g={h + i}) jkl'''
    '''
    import React from 'react';

    <h1 a="b" c='def' g={h + i}>
      jkl
    </h1>;
    '''
  )

test 'inline =expressionBody', ->
  eqJS(
    '%h1= name'
    '''
    import React from 'react';

    <h1>
      {name}
    </h1>;
    '''
  )

test 'expression inline content', ->
  eqJS(
    '%h1 {@abc}'
    '''
    import React from 'react';

    <h1>
      {this.abc}
    </h1>;
    '''
  )

test 'mixed inline content', ->
  eqJS(
    '%h1 name {@abc}'
    '''
    import React from 'react';

    <h1>
      name {this.abc}
    </h1>;
    '''
  )

test 'indented equals expression', ->
  eqJS(
    '''
    %h1
      = abc
    '''
    '''
    import React from 'react';

    <h1>
      {abc}
    </h1>;
    '''
  )

test 'no equals expression unless line-starting', ->
  eqJS(
    '''
    %h1
      x = abc
      y= abc
      {z}= abc
      {w} = abc
      =abc
    '''
    '''
    import React from 'react';

    <h1>
      x = abc
      y= abc
      {z}= abc
      {w} = abc
      {abc}
    </h1>;
    '''
  )

test 'equals for loop', ->
  eqJS(
    '''
    %h1
      = for x in ['a', 'b', 'c']
        %b= x
    '''
    '''
    var x;

    import React from 'react';

    <h1>
      {(function() {
        var i, len, ref, results;
        ref = ['a', 'b', 'c'];
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          x = ref[i];
          results.push(<b>
            {x}
          </b>);
        }
        return results;
      })()}
    </h1>;
    '''
  )

test 'various indented expressions', ->
  eqJS(
    '''
    %h1
      {@x} {@y}
      abc
      {@z}
      def {@g + h}
      {@i +
        @j }
      {
        @k
      }
      { @l
      }
      {
        @m }
    '''
    '''
    import React from 'react';

    <h1>
      {this.x} {this.y}
      abc
      {this.z}
      def {this.g + h}
      {this.i + this.j}
      {this.k}
      {this.l}
      {this.m}
    </h1>;
    '''
  )

test 'simple object attributes', ->
  eqJS(
    '''
    %h1{ a: b }
    '''
    '''
    import React from 'react';

    <h1 a={b}></h1>;
    '''
  )

test 'value object attributes', ->
  eqJS(
    '''
    %h1{ a, @b, c: d() }
    '''
    '''
    import React from 'react';

    <h1 a={a} b={this.b} c={d()}></h1>;
    '''
  )

test 'multi-line object attributes', ->
  eqJS(
    '''
    x = ->
      %h1{
        a
        @b
        c: d()
      }
    y
    '''
    '''
    var x;

    import React from 'react';

    x = function() {
      return <h1 a={a} b={this.b} c={d()}></h1>;
    };

    y;
    '''
  )

test 'parenthesized and object attributes', ->
  eqJS(
    '''
    %h1{ a, @b, c: d() }( e = 'f' )
    %h2(e={f}){a,@b,c:d()}
    '''
    '''
    import React from 'react';

    <h1 e='f' a={a} b={this.b} c={d()}></h1>;

    <h2 e={f} a={a} b={this.b} c={d()}></h2>;
    '''
  )

test 'simple tag', ->
  eqJS(
    '''
    <h1></h1>
    '''
    '''
    import React from 'react';

    <h1></h1>;
    '''
  )

test 'self-closing tags', ->
  eqJS(
    '''
    <h1/>
    <h2 />
    <h3 a='b' c={d}/>
    <h4
        e='f g'
    />
    '''
    '''
    import React from 'react';

    <h1></h1>;

    <h2></h2>;

    <h3 a='b' c={d}></h3>;

    <h4 e='f g'></h4>;
    '''
  )

test 'tag with attributes and indented body', ->
  eqJS(
    '''
    <h1 a="b" c={@d}>
      <b>
        Hey
        = @name
      </b>
    </h1>
    '''
    '''
    import React from 'react';

    <h1 a="b" c={this.d}>
      <b>
        Hey
        {this.name}
      </b>
    </h1>;
    '''
  )

test 'nested inline tags', ->
  eqJS(
    '''
    <h1   a="b" c = {@d} ><b > Hey {@name}</b></h1>
    '''
    '''
    import React from 'react';

    <h1 a="b" c={this.d}><b> Hey {this.name}</b></h1>;
    '''
  )

test 'element enders', ->
  eqJS(
    '''
    x %h1, 2
    %h2 {
      if a
        %a
      else
        %b }
    [%a, %b]
    f(%h1( a={b} ))
    z = (%b{ x } for x in y)
    y =
      %b if c
    x = ->
      %b unless c
    '''
    '''
    var x, y, z;

    import React from 'react';

    x(<h1></h1>, 2);

    <h2>
      {(a ? <a></a> : <b></b>)}
    </h2>;

    [<a></a>, <b></b>];

    f(<h1 a={b}></h1>);

    z = (function() {
      var i, len, results;
      results = [];
      for (i = 0, len = y.length; i < len; i++) {
        x = y[i];
        results.push(<b x={x}></b>);
      }
      return results;
    })();

    y = c ? <b></b> : void 0;

    x = function() {
      if (!c) {
        return <b></b>;
      }
    };
    '''
  )

test 'shorthand tags', ->
  eqJS(
    '''
    %h1#abc
      #def.ghi.jkl
    '''
    '''
    import React from 'react';

    <h1 id='abc'>
      <div id='def' className='ghi jkl'></div>
    </h1>;
    '''
  )

test 'multiline attributes', ->
  eqJS(
    '''
    %h1(
      a={b}
      c='d' )
      %a( e={f g}
          h='i' )
        %b( j = 'k' 
          l='m'
          )
        %b( n = 'o' 
          p='q'
        )
    '''
    '''
    import React from 'react';

    <h1 a={b} c='d'>
      <a e={f(g)} h='i'>
        <b j='k' l='m'></b>
        <b n='o' p='q'></b>
      </a>
    </h1>;
    '''
  )

test 'multiline attributes in tags', ->
  eqJS(
    '''
    <h1
      a={b}
      c='d'>
      <a e={f g}
         h='i' >
        <b j = 'k' 
          l='m'
          />
        <b n = 'o' 
          p='q'
        ></b>
      </a></h1>
    '''
    '''
    import React from 'react';

    <h1 a={b} c='d'>
      <a e={f(g)} h='i'>
        <b j='k' l='m'></b>
        <b n='o' p='q'></b>
      </a>
    </h1>;
    '''
  )

test 'leading-dot classname', ->
  eqJS(
    '''
    SplitPane = ({left, right}) ->
      .SplitPane
        .SplitPane-left {left}
        .SplitPane-right {right}

    x =
      .abc
        .def

    f = (el) ->
      return .shutter {el}

    f(.pane)
    '''
    '''
    var SplitPane, f, x;

    import React from 'react';

    SplitPane = function({left, right}) {
      return <div className='SplitPane'>
        <div className='SplitPane-left'>
          {left}
        </div>
        <div className='SplitPane-right'>
          {right}
        </div>
      </div>;
    };

    x = <div className='abc'>
      <div className='def'></div>
    </div>;

    f = function(el) {
      return <div className='shutter'>
        {el}
      </div>;
    };

    f(<div className='pane'></div>);
    '''
  )

test 'all together now', ->
  eqJS(
    '''
    Recipe = ({name, ingredients, steps}) ->
      %section( id={ name.toLowerCase().replace(/ /g, '-')})
        %h1= name
        %ul.ingredients
          = for {name}, i in ingredients
            %li{ key: i } {ingredient.name}
        %section.instructions
          %h2 Cooking Instructions
          {steps.map (step, i) ->
            %p( key={i} )= step
          }
    '''
    '''
    var Recipe;

    import React from 'react';

    Recipe = function({name, ingredients, steps}) {
      var i;
      return <section id={name.toLowerCase().replace(/ /g, '-')}>
        <h1>
          {name}
        </h1>
        <ul className='ingredients'>
          {(function() {
            var j, len, results;
            results = [];
            for (i = j = 0, len = ingredients.length; j < len; i = ++j) {
              ({name} = ingredients[i]);
              results.push(<li key={i}>
                {ingredient.name}
              </li>);
            }
            return results;
          })()}
        </ul>
        <section className='instructions'>
          <h2>
            Cooking Instructions
          </h2>
          {steps.map(function(step, i) {
            return <p key={i}>
              {step}
            </p>;
          })}
        </section>
      </section>;
    };
    '''
  )

test 'indented = expression following outdent', ->
  eqJS(
    '''
    .table-responsive.small
      %thead
        %tr
      = %Appt{ appt, key: appt.id } for appt in data.appts
    '''
    '''
    var appt;

    import React from 'react';

    <div className='table-responsive small'>
      <thead>
        <tr></tr>
      </thead>
      {(function() {
        var i, len, ref, results;
        ref = data.appts;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          appt = ref[i];
          results.push(<Appt appt={appt} key={appt.id}></Appt>);
        }
        return results;
      })()}
    </div>;
    '''
  )

test 'outer leading #', ->
  eqJS(
    '''
    #abc
      #def.ghi.jkl
    '''
    '''
    import React from 'react';

    <div id='abc'>
      <div id='def' className='ghi jkl'></div>
    </div>;
    '''
  )

test 'leading dot class after if', ->
  eqJS(
    '''
    %div
      = if a
        .small
    '''
    '''
    import React from 'react';

    <div>
      {(a ? <div className='small'></div> : void 0)}
    </div>;
    '''
  )

test 'leading dot class after blank line', ->
  eqJS(
    '''
    {a} = b

    .small

    {c} = d
    .big
    '''
    '''
    var a, c;

    import React from 'react';

    ({a} = b);

    <div className='small'></div>;

    ({c} = d.big);
    '''
  )

test 'leading interpreted dot class', ->
  eqJS(
    '''
    .( 'small', 'text-danger': not mobile_confirm )

    .( 'small', 'text-danger': not mobile_confirm ){ other: attr }
    '''
    '''
    import classNames from 'classnames';

    import React from 'react';

    <div className={classNames('small', {
      'text-danger': !mobile_confirm
    })}></div>;

    <div other={attr} className={classNames('small', {
      'text-danger': !mobile_confirm
    })}></div>;
    '''
  )

test 'allow closer at same indent', ->
  eqJS(
    '''
    %h1
      = a(
        if b
          1
        else
          2
      )
    %h2
      = a
      b
    %h3
      = a [
        b
      ]
      c
    %h4
      = a
      )
    %h5
      = a {
        b, c
      }
    '''
    '''
    import React from 'react';

    <h1>
      {a(b ? 1 : 2)}
    </h1>;

    <h2>
      {a}
      b
    </h2>;

    <h3>
      {a([b])}
      c
    </h3>;

    <h4>
      {a}
      )
    </h4>;

    <h5>
      {a({b, c})}
    </h5>;
    '''
  )

test 'whitespace', ->
  eqJS(
    '''
      <a> a{b} c {d} </a>
      %a
        {z} a
      %a a{b} c {d}
      %a {a}{b}
      %a
        {a}{b}
      %a {a} {b}
      %a
        {a} {b}
      %a {a}<a/>b{c}
      %a
        {a}<a/>b{c}
      %a {a} <a/> b
      %a
        {a} <a/> b
      %a
        {a} %b c
      <a> {b} </a>
      <a> <b/> </a>
      %a
        abc <b/>
      %div
        Hello
        %b^= name
        =^ abc
      %a
        b
        %c^
        d
      %a
        b
        =^ c
        d
    '''
    '''
    import React from 'react';

    <a> a{b} c {d} </a>;

    <a>
      {z} a
    </a>;

    <a>
      a{b} c {d}
    </a>;

    <a>
      {a}{b}
    </a>;

    <a>
      {a}{b}
    </a>;

    <a>
      {a} {b}
    </a>;

    <a>
      {a} {b}
    </a>;

    <a>
      {a}<a></a>b{c}
    </a>;

    <a>
      {a}<a></a>b{c}
    </a>;

    <a>
      {a} <a></a> b
    </a>;

    <a>
      {a} <a></a> b
    </a>;

    <a>
      {a} <b>
        c
      </b>
    </a>;

    <a> {b} </a>;

    <a> <b></b> </a>;

    <a>
      abc <b></b>
    </a>;

    <div>
      Hello <b>
        {name}
      </b> {abc}
    </div>;

    <a>
      b <c></c> d
    </a>;

    <a>
      b {c} d
    </a>;
    '''
  )

test 'spread props', ->
  eqJS(
    '''
    %a{ b... }
    '''
    '''
    import React from 'react';

    <a {...b}></a>;
    '''
  )

test 'filter', ->
  eqJS(
    '''
    %a= amount | currency
    %a
      {a | b ~ c ~ d | e}
    '''
    '''
    import React from 'react';

    <a>
      {currency(amount)}
    </a>;

    <a>
      {e(b(a, c, d))}
    </a>;
    '''
  )

test 'data-attribute', ->
  eqJS(
    '''
    %a{ 'data-id': 1 }
    '''
    '''
    import React from 'react';

    <a data-id={1}></a>;
    '''
  )

test 'auto-generate React and classNames imports', ->
  eqJS(
    '''
    %a.(x)
    '''
    '''
    import classNames from 'classnames';

    import React from 'react';

    <a className={classNames(x)}></a>;
    '''
  )

test "don't auto-generate React and classNames imports if already explicitly imported", ->
  eqJS(
    '''
    import React from 'react'
    import classNames from 'classnames'

    %a.(x)
    '''
    '''
    import React from 'react';

    import classNames from 'classnames';

    <a className={classNames(x)}></a>;
    '''
  )

test 'both literal and interpreted classNames', ->
  eqJS(
    '''
    %h1.text-muted.('abc' if def)
    '''
    '''
    import classNames from 'classnames';

    import React from 'react';

    <h1 className={classNames('text-muted', def ? 'abc' : void 0)}></h1>;
    '''
  )

test 'dotted element name', ->
  eqJS(
    '''
    %Form.Field
    '''
    '''
    import React from 'react';

    <Form.Field></Form.Field>;
    '''
  )

test 'postfix if expression', ->
  eqJS(
    '''
    %div
      = %Header if headerText?
    '''
    '''
    import React from 'react';

    <div>
      {(typeof headerText !== "undefined" && headerText !== null ? <Header></Header> : void 0)}
    </div>;
    '''
  )

# test 'styled-components template literal', ->
#   eqJS(
#     '''
#     %a"""
#       text-decoration: underline;
#       color: #{(props) -> props.color}
#     """
#     '''
#     '''
#       import styled from 'styled-components';

#       styled.a`text-decoration: underline;\\ncolor: ${(function(props) {
#         return props.color;
#       })}`;
#     '''
#   )

# test 'styled-components sass template literal w/ interpolation', ->
#   eqJS(
#     '''
#     %a"""
#       text-decoration: underline
#       color: #{(props) -> props.color}
#     """
#     '''
#     '''
#     import styled from 'styled-components';

#     styled.a`
#       text-decoration: underline;
#       color: #{(props) -> props.color}
#     '''
#   )
# TODO:
# error tests:
# - no whitespace before element body
# - outdented end tag, expression }, ...
# - mismatched start/end tag

test 'leading dot class after outdent', ->
  eqJS(
    '''
      x =
        %a
   
      .leadingDotClass

      if a
        b

      .c

      a ->
        b
      .c

      a ->
        b

      .c
    '''
    '''
      var x;

      import React from 'react';

      x = <a></a>;

      <div className='leadingDotClass'></div>;

      if (a) {
        b;
      }

      <div className='c'></div>;

      a(function() {
        return b;
      }).c;

      a(function() {
        return b;
      });

      <div className='c'></div>;
    '''
  )

test '.[] style shorthand (single value)', ->
  eqJS(
    '''
    .[fontSize: '1.2em']
    '''
    '''
    import React from 'react';

    <div style={{
      fontSize: '1.2em'
    }}></div>;
    '''
  )

test '.[] style shorthand (multiple values, React)', ->
  eqJS(
    '''
    .[container, fontSize: '1.2em']
    '''
    '''
    var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

    import React from 'react';

    <div style={_extends({}, container, {
      fontSize: '1.2em'
    })}></div>;
    '''
  )

test 'Vue auto-imports/dynamic classnames', ->
  eqJS(
    '.(a, b).[c, d]'
    '''
    <div style={[c, d]} class={[a, b]}></div>;
    '''
    null
    options:
      jsxFramework: 'vue'
  )

test 'React Native auto-imports/dynamic classnames', ->
  eqJS(
    '.(a, b).[c, d]'
    '''
    import classNames from 'classnames';

    import React from 'react';

    <div style={[c, d]} className={classNames(a, b)}></div>;
    '''
    null
    options:
      jsxFramework: 'reactNative'
  )
