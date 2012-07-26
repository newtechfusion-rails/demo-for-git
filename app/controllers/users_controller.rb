require 'net/http'
require 'uri'
require 'open-uri'
require 'cgi'

class UsersController < ApplicationController
	def show
		 @user = User.find(params[:id])
     @products = Product.where(:user_id=>params[:id])
     @pro_order = @products.find(:all , :order => "order_id")
     @friends = []
        if session['fb_token'] != nil then
            fb_friends = ActiveSupport::JSON.decode(open(URI.encode("https://graph.facebook.com/me/friends?access_token=#{session['fb_token']}")))['data']
            @friends = fb_friends.collect { |f| AuthService.find_by_provider_and_uid('facebook', f['id']) }.compact
        end
      respond_to do |format|
      	format.html
        format.json { render :json => [@user, @friends] }
      end
	end

  def profile
      @user = User.find_by_id(session[:user_id])
      @product = Product.find(params[:id])
  end

  def add_wish
      @user = User.find(params[:id])
      @products = Product.where(:user_id=>params[:id].last)
      @product_order = Product.last
  end

  def trems
  end

  def product_profile
     @friends_product = Product.find_all_by_user_id(params[:id])
  end

  def product_friend_profile
     @friends_prod_profile = Product.find_by_id(params[:id])
     @user_name = User.find_by_id(@friends_prod_profile.user_id)
  end
end
