module ApplicationHelper
  def admin_user?
    current_user && (current_user.admin? || (Clan.last.player(current_user.username).present? && Clan.last.player(current_user.username)['role'] == "coLeader"))
  end
end
