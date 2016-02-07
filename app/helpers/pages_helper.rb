module PagesHelper
  def format_name(name)
    a = case name
      when "admin" then "Elder"
      when "coLeader" then "Co-Leader"
      else name.capitalize
      end
    return a
  end
end
