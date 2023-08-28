

#Slider that is rounded like knob
SliderKnob = Struct.new(:t)

#==========================================#



#regular text tag
TextTag = Struct.new(:t)

#Led indicator
OnLed = Struct.new(:x,:y,:color,:on)

#Regular slider
RSlider = Struct.new(:t)

#Regular Text Field
RTextField = Struct.new(:t)


InputText = Struct.new(:x,:y,:width,:height,:text)


def create_input_text(x,y,w,h,text)
  InputText.new(x,y,w,h,text)
end


module ButtonIDManager
  @button_id = 0

  def self.next_button_id
    @button_id += 1
  end
end

Button = Struct.new(:x,:y,:width,:height,:hovered,:text,:id)


def create_button(x,y,w,h,text)
  Button.new(x,y,w,h,false,text,ButtonIDManager.next_button_id)
end


def draw_button(button, font)
  color = button.hovered ? Gosu::Color::GREEN : Gosu::Color::GRAY
  Gosu.draw_rect(button.x, button.y, button.width, button.height, color)
  font.draw_text(button.text, button.x + 10, button.y + 10, 0)
end


def button_hovered(button, x, y)
  button.hovered = (x >= button.x && x <= button.x + button.width && y >= button.y && y <= button.y + button.height)
end


###
