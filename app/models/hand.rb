class Hand
	attr_accessor :cards, :score, :money
	
	def initialize()
		@cards = []
		@score = 0
	end
	
	def self.calc_score(hand)
		score = 0

    # sum non-aces first
    hand.cards.each do |card|
      if card.face !~ /a/
        score += Card.value(card.face, score)
      end
    end

    # sum aces
    hand.cards.each do |card|
      if card.face =~ /a/
        score += Card.value(card.face, score) 
      end
    end
		score
  end
  
end
