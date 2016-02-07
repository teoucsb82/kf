class PagesController < ApplicationController
  def home
    redirect_to members_path if user_signed_in?
    @clan = Clan.find_by_tag("8PVC09UJ")
  end
end
