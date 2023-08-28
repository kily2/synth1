
#Miscellaneous

##Helper functions (5)
#1:
def draw_circle(x, y, radius, segments, color)
  draw_arc(x,y,radius,0,360,segments, color)
end

#2:
def draw_arc(x, y, radius, start_angle, end_angle, segments, color)
  angle_increment = (end_angle - start_angle) / segments.to_f

  segments.times do |i|
    angle = start_angle + i * angle_increment.to_f
    end_angle = start_angle + (i + 1) * angle_increment.to_f

    start_x = x + radius * Math.cos(angle * Math::PI / 180)
    start_y = y + radius * Math.sin(angle * Math::PI / 180)
    end_x = x + radius * Math.cos(end_angle * Math::PI / 180)
    end_y = y + radius * Math.sin(end_angle * Math::PI / 180)

    Gosu.draw_line(start_x, start_y, color, end_x, end_y, color)
  end
end

#3:
def draw_filled_circle(x, y, radius, color)
  draw_filled_arc(x,y,radius,0,360,color)
end


#4:
def draw_filled_arc(x, y, radius, start_angle, end_angle, color)
  num_segments = 30
  angle_increment = (end_angle - start_angle) / num_segments.to_f

  num_segments.times do |i|
    angle1 = start_angle - i * angle_increment
    angle2 = start_angle - (i + 1) * angle_increment

    x1 = x + radius * Math.cos(angle1 * Math::PI / 180)
    y1 = y - radius * Math.sin(angle1 * Math::PI / 180)
    x2 = x + radius * Math.cos(angle2 * Math::PI / 180)
    y2 = y - radius * Math.sin(angle2 * Math::PI / 180)

    Gosu.draw_quad(x, y, color, x1, y1, color, x2, y2, color, x, y, color)
  end
end

#6: Opposite Version
def draw_filled_arc2(x, y, radius, start_angle, end_angle, color)
  num_segments = 30
  angle_increment = (end_angle - start_angle) / num_segments.to_f

  num_segments.times do |i|
    angle1 = start_angle + i * angle_increment
    angle2 = start_angle + (i + 1) * angle_increment

    x1 = x + radius * Math.cos(angle1 * Math::PI / 180)
    y1 = y - radius * Math.sin(angle1 * Math::PI / 180)
    x2 = x + radius * Math.cos(angle2 * Math::PI / 180)
    y2 = y - radius * Math.sin(angle2 * Math::PI / 180)

    Gosu.draw_quad(x, y, color, x1, y1, color, x2, y2, color, x, y, color)
  end
end

#5
def lighter_color(color, percent)
  lighter = Gosu::Color.new(
    [color.red + percent, 255].min,
    [color.green + percent, 255].min,
    [color.blue + percent, 255].min,
    color.alpha
  )
  lighter
end

#7:
def draw_rounded_rectangle(x, y, width, height, corner_radius, color)
  draw_rect(x,y,width,height,color)

  dx = 5
  dy = 5

  draw_rect(x+dx-corner_radius,y+dy,corner_radius-dx,height-2*dy,color)
  draw_rect(x+width,y+dy,corner_radius-dx,height-2*dy,color)

  draw_rect(x,y+dy-corner_radius,width-dx,corner_radius-dy,color)
  draw_rect(x,y+height,width-dx,corner_radius-dy,color)

  draw_filled_arc2(x+dx,y+dy,corner_radius,180,90,color)
  draw_filled_arc2(x-dx+width,y+dy,corner_radius,90,0,color)
  draw_filled_arc2(x-dx+width,y-dy+height,corner_radius,0,-90,color)
  draw_filled_arc2(x+dx,y-dy+height,corner_radius,-90,-180,color)
end


###
