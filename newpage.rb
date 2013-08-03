#! /usr/bin/ruby
# newpage.rb - a Jekyll page generator
#
# Two required arguments,
# 1. type of page - can be "blog", "game", or "other"
# 2. title of page - examples "Pixel Zombies" or "Fun Ruby Concepts"
# be sure to quote the title with multiple words!
#
# Additional modifiers,
# -d or --date - allows customization date of page
# must have arguments
# arguments come after -d= and are separated by a comma
# max of six arguments
# arguments modify year, month, day, hour, minute, and second respectively
# example - -d=2012,5,3,1,34,20
#
# -f or --force - forces regeneration of page as default
# in the future a -r or --regenerate could be added for safer regeneration
# a use of this would be adding new variables
#
# -v or --verbose - verbose text
#
# Examples,
# ./newpage.rb blog "Jekyll"
# ./newpage.rb -d=2013,1,19 game "Pixel Zombies"

# page class to write stuff
class Page
	attr_writer :force
	
	attr_writer :layout
	attr_writer :title
	attr_writer :type
	
	attr_accessor :date
	attr_writer :github_url

	# initialize a variable
	def initialize
		@force = false
	end

	# the default file name
	def default_name
		@date ||= Time.now.strftime "%Y-%m-%d"
		title_copy = @title.dup
		
		title_copy.gsub! ' ', '-'
		title_copy = @date[0..(@date.include?(' ') ? @date.index(' ') : @date.length)].concat '-'.concat title_copy.downcase
		title_copy.gsub! ' ', ''
		"_posts/".concat title_copy.concat ".markdown"
	end

	# create file for new page
	def write(verbose = false)
		@date = nil if !@date.include? ' '

		if File.exist? default_name and !@force
			puts "File by name #{name} already exists!"
			exit -1
		end

		puts "Writing to file #{name}" if verbose
		
		File.open default_name, 'w' do |file|
			file.puts "---"
			file.puts "layout: #{@layout}"
			file.puts "title: #{@title}"
			file.puts "type: #{@type}"
			file.puts "date: #{@date}" if !@date.nil?
			file.puts "github_url: #{@github_url}" if !@github_url.nil? and @type != "blog"
			file.puts "---"
			file.puts "\n\n"
		end

		puts "Written successfully!" if verbose
	end
end

# certain allowed arguments
first_arguments = ["blog", "game", "other"]

verbose = false

# arguments that change how the program runs
manip = Array.new

# arguments that the program needs
neces = Array.new

# put arguments in correct places
ARGV.each do |arg|
	if arg[0] == '-'
		manip << arg
	else
		neces << arg
	end
end

# ensure all will work right
unless neces.length > 0
	puts "Invalid number of arguments!"
	exit -1
end

unless first_arguments.include? neces[0]
	puts "First argument must be one of #{first_arguments}!"
	exit -1
end

unless neces[1]
	puts "Second argument must be title of page!"
	exit -1
end

if neces[0] != "blog" and !neces[2]
	puts "Third argument is normally the URL of the project on GitHub."
	puts "You can go without it, but it would be better if it was open source."
end

# create new page
page = Page.new

# does stuff for manipulating arguments
manip.each do |arg|
	if arg == "-v" or arg == "--verbose"
		verbose = true

		puts "Verbose text enabled!"
	elsif arg.include? '=' and (arg[0..(arg.index('=') - 1)] == "-d" or arg[0..(arg.index('=') - 1)] == "--date")
		time = arg[(arg.index('=') + 1)..arg.length]

		if time.length > 0
			args = time.split ','

			unless args.length < 7
				puts "Too many arguments in #{arg}!"
				exit -1
			end

			case neces[0]
			when "blog"
				page.date = Time.new(*args).strftime "%Y-%m-%d %H:%M:%S"
			else
				page.date = Time.new(*args).strftime "%Y-%m-%d"
			end

			puts "Force-set date to #{page.date}!" if verbose
		end
	elsif arg == "-f" or arg == "--force"
		page.force = true
		
		puts "Forcing regeneration!" if verbose
	else
		puts "Invalid manipulation argument #{arg}!"
	end
end

page.layout = neces[0] == "blog" ? "post" : "project"
page.title = neces[1]
page.type = neces[0]

page.date = Time.now.strftime "%Y-%m-%d %H:%M:%S" if neces[0] == "blog" and page.date.nil?
page.github_url = neces[2] if neces[2]

page.write verbose
