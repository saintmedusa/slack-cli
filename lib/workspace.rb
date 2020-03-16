require_relative "lib_helper.rb"
class Workspace

  attr_reader :users, :channels
  def initialize
    @users = User.get_list
    @channels = Channel.get_list
  end

  def select(recipient)
    case recipient
    when "user"
      return users
    when "channel"
      return channels
    else
      raise ArgumentError.new("Invalid recipient.")
    end
  end

  def print_list(recipient)
    case recipient
    when "users"
      tp users, {:name => {:display_name => "Username"}}, :slack_id, :real_name
    when "channels"
      tp channels, :name, :slack_id, :topic, :member_count
    else
      raise ArgumentError.new("Invalid recipient")
    end
  end

 
end