class SessionsController < ApplicationController

  def create
    @data = request.env['omniauth.auth']
    oauth_access_token = @data[:credentials][:token]
    @graph = Koala::Facebook::API.new(oauth_access_token)
    abc
  end

end
