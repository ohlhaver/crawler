class FeedpagesController < ApplicationController
  
   before_filter :login_required
  
   def opinionate
     @feedpage = Feedpage.find(params[:id])
     @feedpage.opinionated = 1
     @feedpage.save
     @feedpage.rawstories.each do |story|
       story.opinion = 1
       story.save
     end
     redirect_to :action => 'show' 
   end

   def deopinionate
     @feedpage = Feedpage.find(params[:id])
     @feedpage.opinionated = 0
     @feedpage.save
     @feedpage.rawstories.each do |story|
       story.opinion = 0
       story.save
     end
     redirect_to :action => 'show'
   end
   
   
   def remove
    @feedpage = Feedpage.find(params[:id])
    @rawstories_to_be_deleted = @feedpage.rawstories.find(:all)
    Rawstory.destroy(@rawstories_to_be_deleted)
    Feedpage.destroy(@feedpage)
    redirect_to :controller => 'sources', :action => 'index'
   end
  
  
  def empty
   @feedpage = Feedpage.find(params[:id])
   @rawstories_to_be_deleted = @feedpage.rawstories.find(:all)
   Rawstory.destroy(@rawstories_to_be_deleted)
   redirect_to :controller => 'sources', :action => 'index'
  end

  def activate
    @feedpage = Feedpage.find(params[:id])
    @feedpage.Active = 1
    @feedpage.save
    redirect_to :controller => 'sources', :action => 'index' 
  end
  
  def deactivate
    @feedpage = Feedpage.find(params[:id])
    @feedpage.Active = 0
    @feedpage.save
    redirect_to :controller => 'sources', :action => 'index'
  end
  

  
  
  def find_source_name link
       link_array = link.split(/\//)
       source = link_array[2]
       return source
  end
  
  
  def index
     @feedpages = Feedpage.find(:all)
   
  end

  def show
    @feedpage = Feedpage.find(params[:id])
    @rawstories_published = Rawstory.find(:all, :conditions => "feedpage_id = #{@feedpage.id}", :order => 'rawstories.id DESC', :limit => '20')
 
  end


  def new
     @feedpage = Feedpage.new
  end

  def create
     require 'rubygems'
     require 'feed_tools'
     @feedpage = Feedpage.new(params[:feedpage])
     feed = FeedTools::Feed.open(@feedpage.url)
     @feedpage.website = feed.link 
     @feedpage.publication = feed.title
     @feedpage.language = params[:language]
     @feedpage.topic = params[:topic]
     @feedpage.opinionated = params[:opinionated]
     @feedpage.video = params[:video]
     @feedpage.previous_size = 0
     
     source_name = 'www.taz.de' if (@feedpage.url).match('www.taz.de')
     source_name = 'www.kicker.de' if (@feedpage.url).match('kicker.de')
     source_name = 'www.cicero.de Blogs' if (@feedpage.url).match('www.cicero.de/rss/rss2')
     source_name = find_source_name feed.link if source_name == nil

     
     
     if Source.find_by_name(source_name) == nil
       @source = Source.new(:name => source_name, :website => source_name)
       @source.save
     else
       @source = Source.find_by_name(source_name)
     end        
     
     @feedpage.source = @source
     
     if @feedpage.save
     redirect_to :controller => 'feedpages', :action => 'new'
     else
      render :action => 'new'
     end
     
     
  end

  def update

      @feedpage = Feedpage.find(params[:id])
      @feedpage.language = params[:language]
      @feedpage.topic = params[:topic]
      @feedpage.opinionated = params[:opinionated]
      @feedpage.video = params[:video]

      @feedpage.save
       render :action => 'new'



  end


end
