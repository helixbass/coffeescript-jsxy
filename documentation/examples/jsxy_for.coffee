render: ->
  {steps} = @props

  %ul.steps-container
    = for {ingredients, description}, i in steps
      %Step{
        ingredients, description
        key: i
      }
