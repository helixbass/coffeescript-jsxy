render: ->
  {steps} = @props

  %ul.steps-container
    = %Step{
      ingredients, description
      key: i
    } for {ingredients, description}, i in steps
