#! /usr/bin/ruby

# page class to write stuff
class Page
	attr_writer :layout
	attr_writer :title
	attr_writer :date
	attr_writer :type

	def default_name
		@date ||= Time.now.strftime "%Y-%m-%d"
		title_copy = @title.dup

		# If title has capital letters
		if @title =~ /[A-Z]/
			title_copy.gsub!(' ', '-')
			title_copy.gsub!('"', ' ')
			title_copy = @date[0..(@date.include?(' ') ? @date.index(' ') : @date.length)].concat '-'.concat title_copy.downcase
			title_copy.gsub!(' ', '')
			title_copy.concat ".markdown"
		else
			title_copy.gsub!('"', ' ')
			title_copy = @date[0..(@date.include?(' ') ? @date.index(' ') : @date.length)].concat '-'.concat title_copy
			title_copy.gsub!(' ', '')
			title_copy.concat ".markdown"
		end
	end

	def write(name = default_name)
		@date = nil if @date.include? ' '
		
		puts name
	end
end

# types of pages that can be made
first_arguments = ["blog", "game", "other"]

# ensure all will work right
unless ARGV.length > 0
	puts "Invalid number of arguments!"
	exit -1
end

unless first_arguments.include? ARGV[0]
	puts "First argument must be one of the arguments listed below.", first_arguments
	exit -1
end

unless ARGV[1]
	puts "Second argument must be title of page!"
	exit -1
end

page = Page.new
page.layout = ARGV[0] == "blog" ? "blog" : "project"
page.title = '"' + ARGV[1] + '"'
page.date = Time.now.strftime "%Y-%m-%d %H:%M:%S" if ARGV[0] == "blog"
page.type = ARGV[0]
page.write
