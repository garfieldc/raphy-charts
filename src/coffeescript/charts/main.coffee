# @import bezier.coffee
# @import scaling.coffee
# @import point.coffee
# @import tooltip.coffee
# @import dot.coffee
# @import line_chart_options.coffee
# @import line_chart.coffee

create_exponential_points = -> 
  points = (new Point("11/#{i}", i*(4)) for i in [0..25])
  points

create_squared_points = -> 
  points = (new Point("11/#{i}", i * i-1) for i in [0..25])

create_random_points2 = -> 
  points = (new Point(i, Math.random() * i) for i in [0..25])


draw_bars = (r, points) ->
  attach_handler = (element) ->
    element.mouseover () ->
      element.attr({ "fill" : "#333" })

    element.mouseout () ->
      element.attr({ "fill" : "#00aadd" })

  x = points[0].x 
  for point, i in points
    rect = r.rect(x-15, point.y, 15, 300 - point.y)
    x += 16 

    rect.attr({ 
      "fill"        : "#00aadd",
      "stroke"      : "transparent",
      "stroke-width": "0"
    })

    attach_handler(rect)

    new Tooltip(r, rect, Math.floor(points[i].y))

window.onload = () ->
  # line 
  c = new LineChart('chart1', {
  })
  c.add_line create_exponential_points(), {
    line_color : "#cc1100"
    area_color : "#cc1100"
    dot_color  :  "#cc1100"
  }
  c.add_line create_squared_points()
  c.draw()

  c = new LineChart('chart2', {
    line_color : "#118800"
    dot_color  : "#118800"
    area_color : "#118800"
    dot_stroke_color: "#aaa"
    dot_stroke_size: 3 
    label_min  : false
    smoothing  : 0.5 
    show_grid  : true
  })

  c.add_line(create_random_points2())
  c.draw()

  c = new LineChart('chart4', {
    line_color : "#9900cc"
    dot_color  : "#000"
    dot_size: 7 
    dot_stroke_color: "#9900cc"
    dot_stroke_size: 2 
    label_min  : false
    label_max  : false
    fill_area  : false
    smoothing  : 0 
    show_grid  : true
    grid_lines : 4
  })
  c.add_line(create_random_points2())
  c.draw()

  # bars
  chart2 = document.getElementById('chart3')
  [width, height, padding] = [1000, 300, 25]
  r2 = Raphael(chart2, width, height)
  points = Scaling.scale_points(width, height, create_exponential_points(), padding)
  draw_bars(r2, points)
