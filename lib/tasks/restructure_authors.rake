namespace :db do
  desc "This rake task sanitizes all the the author names present in the authors table"
  task :sanitize_author_names do
    require(File.join(RAILS_ROOT, 'config', 'environment'))
    require 'authors_api'
    Author.find(:all).each{|auth|
      auth.name = AuthorsApi.sanitize_author_name(auth.name)
      auth.save
    }
  end
  desc "After sanitization, some rawstories point to authors whose author is empty-string. This task makes these rawstories have null authors, and subsequently it drops those authors"
  task :remove_empty_authors do 
    require(File.join(RAILS_ROOT, 'config', 'environment'))
    require 'authors_api'
    Rawstory.find(:all).each{|story|
      if ((!story.author_id.nil?)) 
        if (story.author.nil?) 
          story.author_id = nil 
        else
          if story.author.name.strip.empty?
            author = story.author
            story.author_id = nil
            author.destroy
          end
        end
      end
    }
  end

  desc "For all Authors with pending_approval, create unapproved grouping suggestions for them"
  task :create_author_group_suggestions do 
    require(File.join(RAILS_ROOT, 'config', 'environment'))
    require 'authors_api'
    AuthorsApi.generate_author_group_suggestions
  end 
end
