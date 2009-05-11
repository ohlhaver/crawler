class Rawstory < ActiveRecord::Base
  attr_accessor :position, :score, :related
  belongs_to :group
  belongs_to :author
  belongs_to :feedpage
  belongs_to :source
  belongs_to :haufen
  has_one    :rawstory_detail
  is_indexed :fields =>[
  {:field => :title},
  {:field => :body},
  {:field => :opinion},
  {:field => :created_at}]

  class << self
    def find_en_keywords(text, return_counts = false, from_first_forty = false)
      raw_text = text.gsub(/,|\.|“|”|;|:|\?|- |_|\s+|\\|\"|\(|\)/, ' ')
      ignore_kw = ['jan','feb','mar','apr','may','jun','jul', 'aug','sep','oct','nov','dec',
                   'januar','february','march','april','may','june','july', 'august','september','october','november','december', 
                   'monday','tuesday','wednesday','thursday','friday','saturday','sunday',
                   'first', 'second', 'third',
                   'a','ap','about','an','am','and','are','at','as','also','after',
                   'be','but','by','before', 
                   'can',
                   'do','does', 
                   'for','from','got', 
                   'has','have','he','her','him','his',
                   'if','ii','in','into','is','it','its',
                   'no','not','now',
                   'of','off','on','out','over', 
                   'she','should','so','some', 
                   'that','the','their','them','there','they','this','to','too',
                   'under','up',
                   'you',
                   'was','we','what','when','which','who','will','with']
      raw_keywords = raw_text.split(/\s+/)
      raw_keywords = raw_keywords.first(40) if from_first_forty
      raw_keywords.reject! do |kw|
        kw.match(/[A-Z]/).nil? or  ignore_kw.include?(kw.downcase)
      end
      raw_keywords.collect!{|k| k.downcase}
      count_hashed = raw_keywords.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
      sorted_keys  = count_hashed.keys.sort_by{|k| - count_hashed[k]}
      if return_counts 
        return sorted_keys, count_hashed
      else
        return sorted_keys
      end
    end
    def find_de_keywords(text, return_counts = false, from_first_forty = false)
      raw_text = text.gsub(/,|\.|“|”|;|:|\?|- |_|\s+|\\|\"|\(|\)/, ' ')
      ignore_kw = ['der', 'die', 'das','ein', 'am', 'wie', 'was', 'warum', 'wer', 'wo', 'wann', 'als', 'in']
      raw_keywords = raw_text.split(/\s+/)
      raw_keywords = raw_keywords.first(40) if from_first_forty
      raw_keywords.reject! do |kw|
        kw.match(/[A-Z]/).nil? or  ignore_kw.include?(kw.downcase)
      end

      count_hashed = raw_keywords.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
      sorted_keys  = count_hashed.keys.sort_by{|k| - count_hashed[k]}
      if return_counts 
        return sorted_keys, count_hashed
      else
        return sorted_keys
      end
    end
  end
  
  def all_keywords(return_counts = false, from_first_forty = false)
    #if defined?(@all_keywords)
    #  return @all_keywords
    #end
    if self.language == 2
      @all_keywords = Rawstory.find_de_keywords(self.title.to_s + ' ' + self.body.to_s, return_counts, from_first_forty)
    else
      @all_keywords = Rawstory.find_en_keywords(self.title.to_s + ' ' + self.body.to_s, return_counts, from_first_forty)
    end
    return @all_keywords
  end
end
