class AuthorsApi
 class << self
  def sanitize_author_name(line)
    ## Generic Clean UP 
    return "" if line.nil?
    list_of_non_names = [' Jan ',' Feb ', ' Mar ', ' Apr ', ' May ', ' Jun ', ' Jul ', ' Aug ', ' Sep ', ' Oct ',' Nov ', ' Dec ', ' am ', ' pm ',' Ist', ' Am ', ' Pm ', 'year', 'Cent', '-', '..', '/', "Hrs", "hrs", 'By ']
    line.chomp
    without_spaces_tabs = line.gsub(/\\n/,"").gsub(/\\t/,"").gsub(/\r/,"").gsub(/\^M/,'').strip
    without_html_tags = (without_spaces_tabs.gsub(/\/byline$/,"/byline>").gsub(%r{</?[^>]+?>}, ''))
    without_html_tags = ""  if without_html_tags.nil?
    list_of_non_names.each{|elem|
      without_html_tags = without_html_tags.gsub(elem,"") 
    }
    without_numbers = without_html_tags.gsub(/[0-9]/,"").strip
    without_numbers = ""  if without_numbers.nil?
    without_numbers
    #with_new_line = without_numbers + "\n" 
  end
 end
end
