
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# Dillon Tice
# Dillon.Tice@gmail.com
#
###############################################################

$bigrams = Hash.new # The Bigram data structure
$name = "Dillon Tice"

# function to process each line of a file and extract the song titles
def process_file(file_name)
	begin
		if RUBY_PLATFORM.downcase.include? 'mswin'
            puts "Processing File.... "
			file = File.open(file_name)
			unless file.eof?
				file.each_line do |line|
					# do something for each line (if using windows)
                    # didn't need this fix :(
				end
			end
			file.close
		else
			IO.foreach(file_name, encoding: "utf-8") do |line|
				# do something for each line (if using macos or linux)
                cleanup_title(line)
			end
		end

		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end
end

def mcw(word)
    begin
    end
end
j
def cleanup_title(dirty_string)
    begin
    # 0. Split on <SEP>
    song_title = dirty_string.split('<SEP>', 4).last
    # 1. Remove \n
    song_title = song_title.tr("\n", "")
    # 2. Convert all characters to lower case
    song_title = song_title.downcase
    # 3. Remove all things following these characters:  (  [  {  \  /  _  -  :  "  `  +  =  *  feat.
    song_title = song_title.sub(/\(.+|\[.+|\{.+|\\.+|\/.+|\_.+|\-.+|\:.+|\".+|\`.+|\+.+|\=.+|\*.+|(feat.).+/, '')
    # 4. Delete the following punctuation marks globally:  ?  ¿  !  ¡  .  ;  &  @  %  #  |
    song_title = song_title.gsub(/\?|\¿|\!|\¡|\.|\;|\&|\@|\%|\#|\|/, '')
    # 5. Filter Out Titles that contain non-English characters
    song_title.each_char{|c| if c !~ /[a-z '(\s)(\w)]+/ then song_title = nil end}
    if song_title != nil
        p song_title
    end
    rescue => exception
        p exception.backtrace
        raise
    end
end

# Executes the program
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	# Get user input
end

if __FILE__==$0
	main_loop()
end
