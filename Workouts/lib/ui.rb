require_relative "user"
require 'io/console'

class Ui
	def initialize
		loop do
			choice = ""
			until choice == "1" || choice == "2" || choice == "3" || choice == "4" || choice == "5"
			system "cls"
			puts "1. New User"
			puts "2. Delete User"
			puts "3. List All Users"
			puts "4. Log In"
			puts "5. Exit"
			print "Enter your choice: "
			choice = gets.chomp
			end
			case choice
			when "1"
				new_user
			when "2"
				delete_user
			when "3"
				list_all_users
			when "4"
				log_in
			when "5"
				log_off
			end
		end
	end
	def new_user
		system "cls"
		puts "Enter the user's name:"
		name = gets.chomp
		system "cls"
		id = User.add_user_to_file name
		if  id != nil
			puts "A new user named #{name} has been added. His ID is #{id}"
		else
			puts "A new user has not been added"
		end
		STDIN.getch
	end
	def delete_user
		system "cls"
		list_all_users
		puts "Enter the id of the user you want to delete"
		id = gets.chomp.to_i
		User.delete_user_from_file id
	end
	def list_all_users
		system "cls"
		puts "These are all the users:"
		puts "ID\tName\tWeight"
		User.all_users.each do |i|
			puts "#{i[:id]}\t#{i[:name]}\t#{i[:weight]}"
		end
		STDIN.getch
	end
	def log_off
		system "cls"
		puts "Logging off"
		exit		
	end
	def log_in
		system "cls"
		puts "Enter Your ID"
		id = gets.chomp.to_i
		system "cls"
		unless User.user_exists? id
			puts "User does not exist"
			STDIN.getch
		else
			user = User.new id
			user_menu user
		end
	end
	def user_menu user
		loop do
			choice = ""
			until choice == "1" || choice == "2" || choice == "3" || choice == "4" || choice == "5" || choice == "6"
			system "cls"
			puts "1. Show stats"
			puts "2. Show all activities"
			puts "3. Add activity"
			puts "4. Remove activity"
			puts "5. Find activity"
			puts "6. Exit"
			print "Enter your choice: "
			choice = gets.chomp
			end
			case choice
			when "1"
				show_stats user
			when "2"
				# show_all_activites user
			when "3"
				add_activity user
			when "4"
				# remove_activity user
			when "5"
				# find_activity_id user
			when "6"
				break
			end
		end
	end
	def add_activity user
		loop do
			choice = ""
			until choice == "1" || choice == "2" || choice == "3"
			system "cls"
			puts "What type of activity was it?"
			puts "1. Running"
			puts "2. Cycling"
			puts "3. Back"
			print "Enter your choice: "
			choice = gets.chomp
			end
			case choice
			when "1"
				puts "Enter the title:"
				title = gets.chomp
				distance = nil
				until (distance.is_a? Integer) || (distance.is_a? Float)
					puts "Enter the distance:"
					distance = gets.chomp.to_i
				end

				duration = nil
				until (distance.is_a? Integer) || (distance.is_a? Float)
					puts "Enter the duration:"
					duration = gets.chomp.to_i
				end

				cadence = nil
				until (distance.is_a? Integer) || (distance.is_a? Float)
					puts "Enter the cadence:"
					cadence = gets.chomp.to_i
				end

				user.add_activity :running, title, distance, duration, cadence
			when "2"
				puts "Enter the title:"
				title = gets.chomp
				distance = nil
				until (distance.is_a? Integer) || (distance.is_a? Float)
					puts "Enter the distance:"
					distance = gets.chomp.to_i
				end

				duration = nil
				until (distance.is_a? Integer) || (distance.is_a? Float)
					puts "Enter the duration:"
					duration = gets.chomp.to_i
				end

				cadence = nil
				until (distance.is_a? Integer) || (distance.is_a? Float)
					puts "Enter the power:"
					power = gets.chomp.to_i
				end

				user.add_activity :cycling, title, distance, duration, power
			when "3"
				break
			end
		end
	end
	def remove_activity user
		system "cls"
		user.show_all_activities
		puts "Enter the id of the activity you want to delete"
		id = gets.chomp.to_i
		user.remove_activity id
	end
	def find_activity_id user
		system "cls"
		puts "Enter the id of the activity you would like to view"
		id = gets.chomp.to_i
		activity = user.find_activity_id id
		puts activity
	end
	def show_stats user
		system "cls"
		puts user.show_stats
	end
	
end

Ui.new