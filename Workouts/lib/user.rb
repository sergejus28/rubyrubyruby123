require "yaml"
require_relative 'workout'

class User
	attr_reader :name, :weight
	def initialize id
		users = YAML.load_file('yaml\users.yaml')
		current_user = users.select{|element| element[:id] == id}[0]
		@id = id
		@name = current_user[:name]
		@weight = current_user[:weight]
		@workouts = Workout.new @id
	end
	def self.add_user_to_file name, weight = nil
		users = YAML.load_file('yaml\users.yaml')
		new_id = users.max_by{|element| element[:id]}[:id] + 1
		new_element = {id:new_id, name:name, weight:weight}
		users.push new_element
		File.open('yaml\users.yaml', 'w') {|f| f.write users.to_yaml }
		new_id		
	end
	def self.delete_user_from_file id
		users = YAML.load_file('yaml\users.yaml')
		users.delete_if do |element| element[:id] == id  end
		File.open('yaml\users.yaml', 'w') {|f| f.write users.to_yaml }
	end
	def self.all_users

		users = YAML.load_file('yaml\users.yaml')
	end
	def self.user_exists? id
		exists = false
		users = User.all_users
		users.each do |element| exists = true if element[:id] == id end
		exists
	end
	def add_activity type, title, distance, duration, arg
		if type == :running
			# Activity.add_activity_to_yaml @id, type, title, distance, duration, cadence
			# reloads all workouts to include the new one
			@workouts.load_workouts 
		end
		if type == :cycling
			# Activity.add_activity_to_yaml @id, type, title, distance, duration, power
			# reloads all workouts to include the new one
			@workouts.load_workouts
		end
	end
	def remove_activity
	end
	def all_activities
	end
	def get_activity
	end
	def show_stats
	end
end