
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
	puts "Processing File.... "

	begin
		IO.foreach(file_name) do |line|
            # 0. cleanup_title(line)
            cleaned_title = cleanup_title(line)
            # 1. Remove all titles with non-English characters
            
		end

		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end
end

def cleanup_title(dirty_string)
    begin
    # 0. Split on <SEP>
    song_title = dirty_string.split('<SEP>', 4).last
    # 1. Remove \n
    song_title = song_title.tr("\n", "")
    # 2. Convert all characters to lower case
    song_title = song_title.downcase
    # 3. Remove all things following these characters:  (  [  {  \  /  _  -  :  "  `  +  =  *  feat.
    p song_title = song_title.sub(/\(.+|\[.+|\{.+|\\.+|\/.+|\_.+|\-.+|\:.+|\".+|\`.+|\+.+|\=.+|\*.+|(feat.).+/, '')
    # 4. Delete the following punctuation marks globally:  ?  ¿  !  ¡  .  ;  &  @  %  #  |
    song_title = song_title.sub(/\?|\¿|\!|\¡|\.|\;|\&|\@|\%|\#|\|/, '')
    # 5. Filter Out Titles that contain non-English characters
    # For every character in the title
    for i in 0..song_title.length
        # If the current character is English
        if(/[A-Za-z0-9]/.match(song_title))
            # Continue checking characters
        else
            # Else break the loop and return nothing
        end-
            song_title
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
