#! /usr/bin/ruby

# page class to write stuff
class Page
	attr_writer :layout
	attr_writer :title
	attr_writer :date
	attr_writer :type

	def write(name)
		puts "layout: " + @layout, "title: " + @title, "date: " + @date, "type: " + @type
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
	puts "Second argument must be name of file!"
	exit -1
end

page = Page.new
page.layout = ARGV[0] == "blog" ? "blog" : "project"
#escape quotes
page.title = ARGV[1]
page.date = Time.now.strftime "%Y-%m-%d %H:%M:%S"
page.type = ARGV[0]
page.write "hi"
