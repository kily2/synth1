
require 'gosu'
require_relative 'require'

$onbutton_on_fn = -> {puts "ON"}
$onbutton_off_fn = -> {puts "OFF"}



class Synth < Gosu::Window
  def initialize
    super(1200, 800)  # Window dimensions
    self.caption = "SynthApp"

    @input_text = ""
    @font = Gosu::Font.new(20)

    @rknob = create_rknob(width / 2, height / 2, 50,0.0, RKnobTypes::LeftKnob, 25)

    @textchooser = create_textchooser2(50,height/2+100,100,50,"temp",0,{"temp"=>0,"test"=>5})

    @onbutton = create_onbutton(width/2,height/2,$onbutton_on_fn,$onbutton_off_fn)
    @dragging = false
  end

  def draw
    #@font.draw_text(@input_text, 10, 10, 0,1 ,1,Gosu::Color::WHITE)

    basic_layout()

    textchooser_draw_options(@textchooser)
    #rknob_draw(@rknob)
    #onbutton_draw(@onbutton)
  end

  def update
    #mouse_x and y internal for gosu
    rknob_drag(@rknob, mouse_x, mouse_y, @dragging)
  end

  def button_down(id)
    puts "Key code pressed: #{id}"
    if id == Gosu::MS_LEFT
      @dragging = rknob_start_drag(@rknob, mouse_x, mouse_y)
      onbutton_clicked?(@onbutton,mouse_x,mouse_y)
    end
  end

  def button_up(id)
    puts "Key code pressed: #{id}"
    if id == Gosu::MS_LEFT
      @dragging = rknob_end_drag()
    end
  end

  def text_input(text)
    @input_text += text
    puts "Text input: #{text.inspect}"
  end

  def needs_cursor?
    true
  end
end



Synth.new.show

####
