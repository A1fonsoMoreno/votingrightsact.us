class PagesController < ApplicationController
  def home
    @signature = Signature.new
  end
end