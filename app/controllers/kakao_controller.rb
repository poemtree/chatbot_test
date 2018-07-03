require 'parse'
  
class KakaoController < ApplicationController

  def friend_add
    User.create(user_key: params[:user_key], chat_room: 0)
    render nothing: true
  end
  
  def friend_delete
    User.find_by(user_key: params[:user_key]).destroy
    render nothing: true
  end
  
  def chat_room
    user = User.find_by(user_key: params[:user_key])
    user.plus
    user.save
    render nothing: true
  end

  def keyboard
    @keyboard = {
      :type => "buttons",
      :buttons => ["Menu", "Lotto", "Cat"]
    }
    render json: @keyboard
  end
  
  def message
    @user_msg = params[:content]
    @text = "default"
    
    if @user_msg == "Menu"
      @text = ["Cafeteria", "Chinese", "Hambuger"].sample
    elsif @user_msg == "Lotto"
      @text = (1..45).to_a.sample(6).sort.to_s
    elsif @user_msg == "Cat"
      @cat_url = Parse::Animal.cat
    end
    
    @return_msg = {
      :text => @text
    }
    
    @return_msg_photo = {
      :text => "My cat",
      :photo => {
        :url => @cat_url,
        :width => 720,
        :height => 630
      }
    }
    
    @return_keyboard = {
      :type => "buttons",
      :buttons => ["Menu", "Lotto", "Cat"]
    }
    
    if @user_msg == "Cat"
      @result = {
        :message => @return_msg_photo,
        :keyboard => @return_keyboard
      }
    else
      @result = {
        :message => @return_msg,
        :keyboard => @return_keyboard
      }
    end
    render json: @result
  end
  
  
end
