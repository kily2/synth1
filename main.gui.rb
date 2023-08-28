
require 'gosu'
require_relative 'require'


class Synth < Gosu::Window
  def initialize
    super(800, 600)  # Window dimensions
    self.caption = "SynthApp"

    @input_text = ""
    @font = Gosu::Font.new(20)

    @rknob = create_rknob(width / 2, height / 2, 50,0.0, RKnobTypes::LeftKnob, 25)
    @dragging = false
  end

  def draw
    #@font.draw_text(@input_text, 10, 10, 0,1 ,1,Gosu::Color::WHITE)


    Gosu.draw_quad(
      0, 0, Gosu::Color::WHITE,
      width, 0, Gosu::Color::GREEN,
      width, height, Gosu::Color::BLUE,
      0, height, Gosu::Color::RED,
      z = 0, mode = :default
    )

    rknob_draw(@rknob)
  end

  def update
    #mouse_x and y internal for gosu
    rknob_drag(@rknob, mouse_x, mouse_y, @dragging)
  end

  def button_down(id)
    puts "Key code pressed: #{id}"
    if id == Gosu::MS_LEFT
      @dragging = rknob_start_drag(@rknob, mouse_x, mouse_y)
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
