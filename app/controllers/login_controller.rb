class LoginController < ApplicationController
  def login
    @username = params[:username]
    @password = params[:password]
    @user = User.where(:username => @username).first
    if @user.nil?
      @json = {:error => 'Invalid username'}.to_json
      @status = 401
    else
      if @user.password == @password
        @status = 200
        @json = @user.to_json
      else
        @status = 401
        @json = {:error => 'Invalid password'}.to_json
      end
    end

    respond_to do |format|
      format.json { render :json => @json, :status => @status }
    end
  end
end
