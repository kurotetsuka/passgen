#!/usr/bin/ruby

class Passgen
	attr_accessor :words

	def initialize( filename = "data/wordlist.txt")
		load( filename)
	end

	def load( filename = "data/wordlist.txt")
		data = File.read( filename)
		@words = data.split("\n")
	end

	def gen( wc = 5)
		#setup
		result = ""
		old = Array.new
		rand = Random.new()
		spaces_enabled = true
		#while have more words to gen
		while wc > 0
			#chose an entry
			i = rand.rand( @words.length)
			#disqualify duplicates
			if old.include?( i)
				next
			end
			#push space
			if spaces_enabled && ! old.empty?
				result << " "
			end
			#push word
			result << @words[ i]
			old.push( i)
			wc -= 1
		end
		return result
	end
end

# main method
if __FILE__ == $0
	#printf( "argv: %s\n", ARGV);
	#get word count
	wc = 5
	if ! ARGV.empty?
		temp = ARGV[0].to_i
		if temp != 0
			wc = temp
		end
	end
	#setup
	passgen = Passgen.new()
	password = passgen.gen( wc)
	#print password
	# add arg to disable this
	read_enabled = true
	if read_enabled
		printf( "password: %s\n", password)
	end
	#copy to clipboard
end
