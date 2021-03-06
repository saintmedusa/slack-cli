require_relative 'workspace'

def select(input, workspace)
  recipient_kind = input.split(" ")[1]
  puts "Enter the Slack ID, channel name, or username of the recipient."
  recipient_id = gets.chomp
  selected = workspace.select(recipient_kind, recipient_id)
  if selected == nil
    puts "Recipient not found."
  else
    puts "#{selected.class} #{selected.name} selected."
  end
  return selected
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "This workspace has #{workspace.users.length} users and #{workspace.channels.length} channels."
  input = ""
  selected = nil
  while input != "quit"
    puts "\nWhat would you like to do?"
    puts "list users \nlist channels \nselect user \nselect channel \ndetails \nsend message \nmessage history \nquit \n\n"
    input = gets.chomp
    case input 
    when "list users"
      workspace.print_list("users")
    when "list channels"
      workspace.print_list("channels")
    when "select user"
      selected = select(input, workspace)
    when "select channel"
      selected = select(input, workspace)
    when "details"
      if selected == nil
        puts "You must select a recipient before asking for details."
      else
        ap selected.details
      end
    when "send message"
      if selected == nil
        puts "You must select a recipient before asking for details."
      else
        puts "What is your message to #{selected.name}?"
        text = gets.chomp
        workspace.post(text, selected)
        puts "Your message to #{selected.name} was successfully sent."
      end
    when "message history"
      if selected == nil
        puts "You must select a recipient before asking for details."
      else
        puts "Messages sent to #{selected.name}:"
        ap selected.messages.values
      end
    when "quit"
      puts "Goodbye!"
    else
      puts "Oops, that's not valid input."
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME