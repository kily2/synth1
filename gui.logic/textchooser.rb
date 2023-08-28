
require_relative 'misc'


#TextChooser
TextChooser = Struct.new(:x,:y,:width,:height,:id,:current_choice,:current_val,:choice_hash)


module TextChooserIDManager
  @textchooser_id = 0

  def self.next_textchooser_id
    @textchooser_id += 1
  end
end


def create_textchooser(x,y,w,h,hash)
  TextChooser.new(x,y,w,h,TextChooserIDManager.next_textchooser_id,"",0,hash)
end

def create_textchooser2(x,y,w,h,current_,current_val,hash)
  TextChooser.new(x,y,w,h,TextChooserIDManager.next_textchooser_id,current_,current_val,hash)
end

def textchooser_draw(textchooser)

  

end


###
