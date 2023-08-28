
require_relative 'misc'

#button with a light on\off
OnButton = Struct.new(:t)


module OnButtonIDManager
  @onbutton_id = 0

  def self.next_onbutton_id
    @onbutton_id += 1
  end
end


def create_onbutton()

end



###
