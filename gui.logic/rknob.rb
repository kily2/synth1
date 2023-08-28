
require_relative 'misc'

#RegularKnob

RKnob = Struct.new(:x,:y,:radius,:value,:type,:angle_step,:id,:relative_mouse_y)


module RKnobIDManager
  @rknob_id = 0

  def self.next_rknob_id
    @rknob_id += 1
  end
end


module RKnobTypes
  MiddleKnob = :middle
  LeftKnob = :left
end


def create_rknob(x,y,r,val,type,angle_step)
  RKnob.new(x,y,r,val,type,angle_step,RKnobIDManager.next_rknob_id,y)
end


def rknob_draw(rknob)
  rknob_angle = rknob_value_to_angle(rknob)
  #puts rknob_angle
  # Draw the modulation arc
  modulation_radius = rknob.radius * 1.4
  draw_filled_arc2(rknob.x, rknob.y, modulation_radius, 225, -45, lighter_color(Gosu::Color::BLUE,30))

  draw_filled_arc(rknob.x,rknob.y,modulation_radius,225,rknob_angle, (Gosu::Color::GREEN))

  # Draw the base circle
  base_circle_radius = rknob.radius * 1.25
  draw_filled_circle(rknob.x, rknob.y, base_circle_radius, lighter_color(Gosu::Color::GRAY,30))

  draw_filled_circle(rknob.x, rknob.y, rknob.radius, Gosu::Color::GRAY)


  # Draw the white rectangle indicating current position
  rectangle_height = rknob.radius / 1.2
  rectangle_width = rknob.radius / 6.0
  rectangle_y = rknob.y - rknob.radius
  rectangle_x = rknob.x - rectangle_width

  Gosu.rotate(rknob_angle, rknob.x, rknob.y) do
    Gosu.draw_rect(rectangle_x, rectangle_y, rectangle_width, rectangle_height, Gosu::Color::WHITE)
  end
end

###225==135?!@#!@?
def rknob_value_to_angle(rknob)
  if rknob.type == RKnobTypes::MiddleKnob
    start_angle = 90
    end_angle = -45
    angle_range = end_angle - start_angle

    angle = start_angle - (rknob.value-0.5) * angle_range
    return angle
  elsif rknob.type == RKnobTypes::LeftKnob
    start_angle = 225
    end_angle = -45
    angle_range = end_angle - start_angle

    angle = start_angle - rknob.value * angle_range
    return angle
  end
end


def rknob_mouse_over?(rknob, mouse_x, mouse_y)
  distance = Math.sqrt((mouse_x - rknob.x)**2 + (mouse_y - rknob.y)**2)
  distance <= rknob.radius
end


def rknob_start_drag(rknob, mouse_x, mouse_y)
  if rknob_mouse_over?(rknob, mouse_x, mouse_y)
    rknob.relative_mouse_y = mouse_y.dup
    return true
  end
end

def rknob_drag(rknob, mouse_x, mouse_y, dragging)
  return unless dragging

  if mouse_y > rknob.relative_mouse_y
    rknob.relative_mouse_y = mouse_y.dup
    rknob.value -= (rknob.angle_step / 360.0)
    rknob.value = 0.0 if rknob.value < 0.0
  elsif mouse_y < rknob.relative_mouse_y
    rknob.relative_mouse_y = mouse_y.dup
    rknob.value += (rknob.angle_step / 360.0)
    rknob.value = 1.0 if rknob.value > 1.0
  end
end


def rknob_end_drag
  false
end

####
