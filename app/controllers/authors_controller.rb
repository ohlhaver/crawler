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




  def edit
  end

end
