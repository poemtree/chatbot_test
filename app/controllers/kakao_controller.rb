class KakaoController < ApplicationController
  
  require 'httparty'
  require 'nokogiri'
  require 'rest-client'
  
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
    
      @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      
      @cat_xml = RestClient.get(@url)
      @cat_doc = Nokogiri::XML(@cat_xml)
      @cat_url = @cat_doc.xpath('//url').text
      @text = @cat_url
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
