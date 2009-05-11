class JLib
  class << self
    def find_haufen_keywords(haufen_stories)
      find_haufen_keywords4(haufen_stories)
    end

    def find_haufen_keywords1(haufen_stories)
      keyword_hashes = haufen_stories.collect{|s| s.all_keywords(true, true).last}
      new_hash    = Hash.new(0)
      keyword_hashes.each do |kh|
        kh.keys.each do |k|
          new_hash[k] += kh[k].to_i
        end
      end
      new_hash.keys.sort_by{|k| - new_hash[k]}
    end
    def find_haufen_keywords2(haufen_stories)
      new_hash    = Hash.new(0)
      haufen_stories.each do |s|
        s_ks = s.keywords.strip.split(/\s+/)
        s_ks.each do |k|
          new_hash[k] += 1
        end
      end
      return new_hash.keys.sort_by{|k| - new_hash[k]}
    end
    
    def find_haufen_keywords3(haufen_stories)
      new_hash    = Hash.new(0)
      haufen_stories.each do |s|
        s_ks = s.all_keywords.first(3)
        s_ks.each do |k|
          new_hash[k] += 1
        end
      end
      return new_hash.keys.sort_by{|k| - new_hash[k]}
    end
    
    def find_haufen_keywords4(haufen_stories)
      new_hash       = Hash.new(0)
      new_hash1      = Hash.new(0)
      haufen_stories.each do |s|
        hash1 = s.all_keywords(true, true).last
        hash1.keys.each do |k|
          new_hash[k] +=  hash1[k].to_i
          new_hash1[k] +=  1
        end
      end
      size = haufen_stories.size
      return new_hash.keys.sort_by{|k| -(new_hash[k] * new_hash1[k])}
    end

  end

end
