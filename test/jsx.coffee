# JSX-Haml
# --------

test 'simple inline element', ->
  # element = %h1 Hello, world!
  eqJS(
    '%h1 Hello, world!'
    '''
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
    '<h1></h1>;'
  )

test 'inline element with parenthesized attributes', ->
  eqJS(
    '''%h1( a="b" c='def' g={h + i})'''
    '''<h1 a="b" c='def' g={h + i}></h1>;'''
  )

test 'inline element with parenthesized attributes and content', ->
  eqJS(
    '''%h1( a="b" c='def' g={h + i}) jkl'''
    '''
    <h1 a="b" c='def' g={h + i}>
      jkl
    </h1>;
    '''
  )

test 'inline =expressionBody', ->
  eqJS(
    '%h1= name'
    '''
    <h1>
      {name}
    </h1>;
    '''
  )

test 'expression inline content', ->
  eqJS(
    '%h1 {@abc}'
    '''
    <h1>
      {this.abc}
    </h1>;
    '''
  )

test 'mixed inline content', ->
  eqJS(
    '%h1 name {@abc}'
    '''
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
    var FORCE_EXPRESSION, x;

    <h1>
      {FORCE_EXPRESSION = (function() {
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
    '<h1 a={b}></h1>;'
  )

test 'value object attributes', ->
  eqJS(
    '''
    %h1{ a, @b, c: d() }
    '''
    '<h1 a={a} b={this.b} c={d()}></h1>;'
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
    var FORCE_EXPRESSION, x, y, z;

    x(<h1></h1>, 2);

    <h2>
      {FORCE_EXPRESSION = (a ? <a></a> : <b></b>)}
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

    Recipe = function({name, ingredients, steps}) {
      var FORCE_EXPRESSION, i;
      return <section id={name.toLowerCase().replace(/ /g, '-')}>
        <h1>
          {name}
        </h1>
        <ul className='ingredients'>
          {FORCE_EXPRESSION = (function() {
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
    var FORCE_EXPRESSION, appt;

    <div className='table-responsive small'>
      <thead>
        <tr></tr>
      </thead>
      {FORCE_EXPRESSION = (function() {
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
    var FORCE_EXPRESSION;

    <div>
      {FORCE_EXPRESSION = (a ? <div className='small'></div> : void 0)}
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
    var FORCE_EXPRESSION;

    <h1>
      {FORCE_EXPRESSION = a(b ? 1 : 2)}
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

test 'filter', ->
  eqJS(
    '''
    %a= amount | currency
    %a
      {a | b ~ c ~ d | e}
    '''
    '''
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
    <a data-id={1}></a>;
    '''
  )

# TODO:
# errors on stray <
# error tests:
# - no whitespace before element body
# - outdented end tag, expression }, ...
# - mismatched start/end tag
# - handle:
#   x =
#     %a
#
#   .leadingDotClass
