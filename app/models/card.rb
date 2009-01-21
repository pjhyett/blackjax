class Card
	attr_reader :face

  @@deck = %w(ah ac ad as 2h 2c 2d 2s 3h 3c 3d 3s 
              4h 4c 4d 4s 5h 5c 5d 5s 6h 6c 6d 6s 
              7h 7c 7d 7s 8h 8c 8d 8s 9h 9c 9d 9s 
              th tc td ts jh jc jd js qh qc qd qs 
              kh kc kd ks)
            
	def initialize	
		@face = @@deck[@@position]
		@@position += 1
	end 
	
  def self.shuffle
    @@position = 0
    @@deck = @@deck.sort_by{ rand }
  end

  def self.value(face, score)
    value = 0
    if face =~ /^[0-9]/
      value += face[0,1].to_i # [0] only prints the ASCII code of the character
    elsif face =~ /a/
      if score + 11 > 21
        value = 1
      else
        value = 11
      end
    else
      value = 10
    end
    value
  end
  
end