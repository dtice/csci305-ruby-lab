
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
			# do something for each line
            # 1. cleanup_title(line)
            # 2. Ensure there are no non-english characters
            # 3. Convert all characters to lower case
            cleanup_title(line)
		end

		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end
end

def cleanup_title(dirty_string)
    # 0. Split on <SEP> *DONE*
    # 1. Remove all things following (following meaning until you hit a space?) these characters:  (  [  {  \  /  _  -  :  "  `  +  =  *  feat.
    # 2. Delete the following punctuation marks globally:  ?  ¿  !  ¡  .  ;  &  @  %  #  |
    p song_title = dirty_string.split('<SEP>', 4).last
    
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
