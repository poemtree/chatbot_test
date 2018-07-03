class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
      :type => "buttons",
      :buttons => ["메뉴", "로또", "날씨"]
    }
    render json: @keyboard
  end
  def message
    @user_msg = params[:content]
    
    @return_msg = {
      :text => @user_msg
    }
    
    @return_keyboard = {
      :type => "buttons",
      :buttons => ["메뉴", "로또", "날씨"]
    }
    
    @result = {
      :message => @return_msg,
      :keyboard => @return_keyboard
    }
    
    render json: @result
  end
end
