namespace :db do
  desc "This rake task sanitizes all the the author names present in the authors table"
  task :sanitize_author_names do
    require(File.join(RAILS_ROOT, 'config', 'environment'))
    require 'authors_api'
    #puts AuthorsApi.sanitize_author_name(Author.find_by_id(4996).name)
    Author.find(:all).each{|auth|
      auth.name = AuthorsApi.sanitize_author_name(auth.name)
      auth.save
    }
  end
end
