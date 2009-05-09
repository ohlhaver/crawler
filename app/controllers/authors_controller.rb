class AuthorsController < ApplicationController
  
 before_filter :login_required
  
  def index
    @authors = Author.find(:all, :order => 'authors.name ASC')
  end

  def show
     @author = Author.find(params[:id])
     @rawstories_published = @author.rawstories.find(:all, :order => 'rawstories.id DESC')
  end

  def opinionate
    @author = Author.find(params[:id])
    @author.opinionated = 1
    @author.save
    @author.rawstories.each do |story|
      story.opinion = 1
      story.save
    end
    redirect_to :action => 'index' 
  end
  
  def deopinionate
    @author = Author.find(params[:id])
    @author.opinionated = 0
    @author.save
    @author.rawstories.each do |story|
      story.opinion = 0
      story.save
    end
    redirect_to :action => 'index'
  end

  def show_suggestions
   @hello = "" 
   @map_hash = {}
   @map_hash_first_20 = {}
   @i = 0
   @all_maps = AuthorMap.find(:all, :conditions => ["status=?",JConst::AuthorStatus::SUGGESTION_PENDING])
   @all_maps.each{|map|
      if @map_hash[map.unique_author].nil?
        @map_hash[map.unique_author] = Array.new 
        @i = @i + 1
        @map_hash_first_20[map.unique_author] = Array.new if @i < 21
      end
      @map_hash[map.unique_author].push(map) 
      @map_hash_first_20[map.unique_author].push(map) if @i < 21
   }
   puts @map_hash.length
   puts @map_hash_first_20.length
   
   
  end

  def approve_suggestions
    params[:auth_map].each{|key,val|
      @map = AuthorMap.find_by_id(key.to_i)
      if(val == "false") 
        @uniq_auth = UniqueAuthor.new({:name => @map.author.name,:opinionated => @map.author.opinionated})
        @uniq_auth.save!
        @map.unique_author = @uniq_auth
      end
      @map.status = JConst::AuthorMapStatus::APPROVED
      @map.author.approval_status = JConst::AuthorStatus::APPROVED
      @map.save
      @map.author.save
      #puts map.unique_author.id.to_s + "    " + map.author_id.to_s
    }
    redirect_to :action => :show_suggestions
  end



  def edit
  end

end
