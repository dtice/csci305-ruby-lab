
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
                    
				end
			end
			file.close
		else
			IO.foreach(file_name, encoding: "utf-8") do |line|
				# Clean Title
                clean_title = cleanup_title(line)
				# Split title into words
				if clean_title != nil
					# Array of words in the title
					words = clean_title.split(' ', 30)
					words.delete("")
						# For every word in the title
						for i in 0..words.length - 1
						# 	If word is not already in first hash as a key
							if !$bigrams.key?(words[i])
								# If it is not the last word in the title
								if words[i] != words.last
									# Insert first word into hash as key, with a new hash containing next word as key and 1 as value
									$bigrams[words[i]] = {words[i+1] => 1}
								# Else it is the last word in the title
								else
									$bigrams[words[i]] = Hash.new
								end
								
							
							# Else word is already in first hash  
							else
								# If word is not the last word in title
								if words[i] != words.last
									# If nested hash contains second word as a key
									if $bigrams[words[i]].key?(words[i+1])
										# Increase value that corresponds with second word
										$bigrams[words[i]][words[i+1]] += 1
									# Else word that follows is not in second hash
									else
										# Insert second word as key in second hash and set value to 1
										$bigrams[words[i]][words[i+1]] = 1
									end
								end
								# Else word is last word in title, no words follow
							end
					end
				end
			end
		end

		puts "Finished. Bigram model built.\n"
	rescue => exception
		p exception.backtrace
		raise
		STDERR.puts "Could not open file"
		exit 4
	end
end

def create_title(word)
	begin
		title = word
		current_word = word
		loop_check = Array.new
		while next_word = mcw(current_word)
			# This loops continuously while the current word has a bigram
			# It should stop if the next word's mcw is the current word
			title += " " << next_word
			if loop_check.length != 50
				loop_check.push(current_word)
			else 
				loop_check.slice!(0)
				loop_check.push(current_word)
				if /(#{loop_check})/.match(title)
					break
				end
			end
			
			current_word = next_word
		end
		p title
	rescue => exception
        p exception.backtrace
        raise
    end
end

#Most Common Word
def mcw(word)
	begin
		# If bigrams contains the word and the word has been followed by at least one other word
		if $bigrams.key?(word) && !$bigrams[word].empty?
			# If there is more than one maximum value in the hash
			$bigrams[word].max_by().count
			if $bigrams[word].max_by().count > 1
				$bigrams[word].max_by().to_a.sample(1)[0][0]
			end
		else
			false
		end
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
    song_title = song_title.sub(/\(.+|\[.+|\{.+|\\.+|\/.+|\_.+|\-.+|\:.+|\".+|\`.+|\+.+|\=.+|\*.+|(feat.).+/, '')
    # 4. Delete the following punctuation marks globally:  ?  ¿  !  ¡  .  ;  &  @  %  #  |
    song_title = song_title.gsub(/\?|\¿|\!|\¡|\.|\;|\&|\@|\%|\#|\|/, '')
	# 4.5 Remove stop words
	song_title = song_title.gsub(/ \ba\b| \ban\b| \band\b| \bby\b| \bfor\b| \bfrom\b| \bin\b| \bof\b| \bon\b| \bor\b| \bout\b| \bthe\b| \bto\b| \bwith\b/, '')
    # 5. Filter Out Titles that contain non-English characters
    song_title.each_char{|c| if c !~ /[a-z '(\s)(\w)]+/ then song_title = nil end}
    if song_title != nil
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
	prompt = "Enter a word [q: quit]> "
	print prompt

	while user_input = STDIN.gets.chomp # loop while getting user input
		
		if user_input == "q"
			break;
		else
			create_title(user_input)
			p prompt
		end
	end
end

if __FILE__==$0
	main_loop()
end
