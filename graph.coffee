class Graph
  constructor: ->
    @graph = d3.select('#graph')
    @width = 1000
    @height = 500
    @margins =
      top: 20
      right: 20
      bottom: 20
      left: 50

  render: (data) ->
    xRange = d3.scale.linear().range([
      @margins.left
      @width - (@margins.right)
    ]).domain([
      d3.min(data, (d) ->
        d.x
      )
      d3.max(data, (d) ->
        d.x
      )
    ])
    yRange = d3.scale.linear().range([
      @height - (@margins.top)
      @margins.bottom
    ]).domain([
      d3.min(data, (d) ->
        d.y
      )
      d3.max(data, (d) ->
        d.y
      )
    ])
    xAxis = d3.svg.axis().scale(xRange).tickSize(5).tickSubdivide(true)
    yAxis = d3.svg.axis().scale(yRange).tickSize(5).orient('left').tickSubdivide(true)
    @graph.append('svg:g').attr('class', 'x axis').attr('transform', 'translate(0,' + (@height - @margins.bottom) + ')').call xAxis
    @graph.append('svg:g').attr('class', 'y axis').attr('transform', 'translate(' + @margins.left + ',0)').call yAxis
    lineFunc = d3.svg.line().x((d) ->
      xRange d.x
    ).y((d) ->
      yRange d.y
    ).interpolate('basis')
    @graph.append('svg:path').attr('d', lineFunc(data)).attr('stroke', 'blue').attr('stroke-width', 2).attr 'fill', 'none'

$(document).ready ->
  data = [
    {x: 1,   y: 5}
    {x: 20,  y: 20}
    {x: 40,  y: 10}
    {x: 60,  y: 40}
    {x: 80,  y: 5}
    {x: 100, y: 60}
  ]

  graph = new Graph
  graph.render data
