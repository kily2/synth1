
require_relative 'misc'


#TextChooser
TextChooser = Struct.new(:x,:y,:width,:height,:id,:current_choice,:current_val,:choice_hash,:clicked)


module TextChooserIDManager
  @textchooser_id = 0

  def self.next_textchooser_id
    @textchooser_id += 1
  end
end


def create_textchooser(x,y,w,h,hash)
  TextChooser.new(x,y,w,h,TextChooserIDManager.next_textchooser_id,"",0,hash,false)
end

def create_textchooser2(x,y,w,h,current_,current_val,hash)
  TextChooser.new(x,y,w,h,TextChooserIDManager.next_textchooser_id,current_,current_val,hash,false)
end

def textchooser_draw(textchooser)

  draw_rounded_rectangle(textchooser.x,textchooser.y,textchooser.width,textchooser.height,10,Gosu::Color::GRAY)

  font = Gosu::Font.new(20)

  text_width = font.text_width(textchooser.current_choice)
  text_height = font.height

  center_x = textchooser.x + (textchooser.width - text_width) / 2.0
  center_y = textchooser.y + (textchooser.height - text_height) / 2.0

  font.draw_text(textchooser.current_choice, center_x, center_y, 0, 1, 1, Gosu::Color::WHITE)
end

def textchooser_draw_options(textchooser)
  dark_gray = Gosu::Color.new(40, 40, 40)

  draw_rounded_rectangle(textchooser.x+textchooser.width,textchooser.y,1.5*textchooser.width,textchooser.choice_hash.size*textchooser.height,10,dark_gray)

  #lines
  (1...textchooser.choice_hash.size).each do |i|
    x1 = textchooser.x + textchooser.width
    y1 = textchooser.y + textchooser.height * i
    color1 = Gosu::Color::WHITE
    x2 = textchooser.x+textchooser.width+1.5 * textchooser.width
    color2 = Gosu::Color::GRAY

    Gosu.draw_line(x1, y1, color1, x2, y1, color2)
  end

  #text
  i=0
  textchooser.choice_hash.each do |option,val|
    font = Gosu::Font.new(20)

    text_width = font.text_width(option)
    text_height = font.height

    center_x = textchooser.x + textchooser.width + (1.5*textchooser.width - text_width) / 2.0
    center_y = textchooser.y + textchooser.height * i + (textchooser.height - text_height) / 2.0

    font.draw_text(option, center_x, center_y, 0, 1, 1, Gosu::Color::WHITE)
    i+=1
  end
end


###
