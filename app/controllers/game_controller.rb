require 'digest/sha1'

class GameController < ApplicationController
  
  def index
    # generate unique urlif necessary
    redirect_to :action => 'index', :id => session.session_id if params[:id].nil?    
    
    # grab bankroll from existing user, otherwise create one
    session[:user] = (User.find_by_password(params[:id]) || User.create({:password => params[:id], :bankroll => 500}))
  end
  
  def deal
		session[:wager] = params[:wager]
	
	  Card.shuffle
	
		# players hand
    hand = Hand.new
    hand.cards << Card.new << Card.new
    hand.score = Hand.calc_score(hand)
    session[:hand] = hand

    # dealer hand
    dhand = Hand.new
    dhand.cards << Card.new
    dhand.score = Hand.calc_score(dhand) # don't want player to know full score
    dhand.cards << Card.new
		session[:dhand] = dhand
	end
	
	def hit
    hand = session[:hand]
    @card = Card.new
    hand.cards << @card
    hand.score = Hand.calc_score(hand)
    session[:hand] = hand
    
    # inline RJS
    render :update do |page| 
      page.replace_html 'cards', :partial => 'cards'
      page.replace_html 'score', @session[:hand].score
    end
  end
  
  def stay
    dhand = session[:dhand]
    
    # don't bother if the player busted or got blackjack
    if session[:hand].score < 21
      dhand.cards << Card.new while(Hand.calc_score(dhand) < 17)
    end
    
    dhand.score = Hand.calc_score(dhand)
		session[:dhand] = dhand
		
		get_winner
  end
  
  # still need to implement the view
  def double
    new_wager = session[:wager].to_f * 2
    session[:wager] = new_wager.to_s
    render :layout => false
	end
  
  def get_winner
    score = session[:hand].score
    d_score = session[:dhand].score
		wager = session[:wager].to_f
		cash = session[:user].bankroll.to_f
    
    if (score > 21)
      @result = "You Lose"
			cash -= wager
		elsif (score == 21)
		  @result = "You have BlackJack!"
		  cash += (wager * 2.5) # 3 to 2 odds
    elsif (score == d_score)
      @result = "You Push"
    elsif (d_score > 21 or (score > d_score))
      @result = "You Win!"
			cash += wager
    else
      @result = "You Lose"
			cash -= wager
    end

    session[:user].bankroll = cash
    session[:user].update
  end
  
end
