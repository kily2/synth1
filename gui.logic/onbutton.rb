
require_relative 'misc'

#button with a light on\off
OnButton = Struct.new(:x,:y,:radius,:toggle,:id,:on_fn,:off_fn)



module OnButtonIDManager
  @onbutton_id = 0

  def self.next_onbutton_id
    @onbutton_id += 1
  end
end


def create_onbutton(x,y,on_fn,off_fn)
  OnButton.new(x,y,8,false,OnButtonIDManager.next_onbutton_id,on_fn,off_fn)
end


def onbutton_draw(onbutton)

  if onbutton.toggle
    draw_filled_circle(onbutton.x,onbutton.y,onbutton.radius,Gosu::Color::RED)
  else
    draw_filled_circle(onbutton.x,onbutton.y,onbutton.radius,Gosu::Color::GRAY)
  end

  #outro
  draw_circle(onbutton.x,onbutton.y,onbutton.radius,30,Gosu::Color::BLACK)
end

def onbutton_mouse_over?(onbutton, mouse_x, mouse_y)
  distance = Math.sqrt((mouse_x - onbutton.x)**2 + (mouse_y - onbutton.y)**2)
  distance <= onbutton.radius
end

def onbutton_clicked?(onbutton, mouse_x, mouse_y)
  if onbutton_mouse_over?(onbutton, mouse_x, mouse_y)
    onbutton.toggle = !onbutton.toggle
    if onbutton.toggle
      onbutton.on_fn.call
    else
      onbutton.off_fn.call
    end
  end
end

###
