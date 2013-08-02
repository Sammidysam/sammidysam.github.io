#! /usr/bin/ruby

# page class to write stuff
class Page
	attr_writer :layout
	attr_writer :title
	attr_accessor :date
	attr_writer :type

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
	def write(name = default_name)
		@date = nil if !@date.include? ' '

		if File.exist? name
			puts "File by name #{name} already exists!"
			exit -1
		end
		
		File.open name, 'w' do |file|
			file.puts "---"
			file.puts "layout: #{@layout}"
			file.puts "title: #{@title}"
			file.puts "date: #{@date}" if !@date.nil?
			file.puts "type: #{@type}"
			file.puts "---"
			file.puts "\n\n"
		end
	end
end

# certain allowed arguments
first_arguments = ["blog", "game", "other"]

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

# create new page
page = Page.new

# does stuff for manipulating arguments
manip.each do |arg|
	if arg.include? '=' and (arg[0..(arg.index('=') - 1)] == "-d" or arg[0..(arg.index('=') - 1)] == "--date")
		time = arg[(arg.index('=') + 1)..arg.length]

		if time.length > 0
			args = time.split ','

			case neces[0]
			when "blog"
				page.date = Time.new(*args).strftime "%Y-%m-%d %H:%M:%S"
			else
				page.date = Time.new(*args).strftime "%Y-%m-%d"
			end
		end
	elsif arg == "-u" or arg == "--usage"
		puts "usage coming soon!"
	end
end

page.layout = neces[0] == "blog" ? "post" : "project"
page.title = neces[1]
page.date = Time.now.strftime "%Y-%m-%d %H:%M:%S" if neces[0] == "blog" and page.date.nil?
page.type = neces[0]
page.write