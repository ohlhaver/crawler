
# Gem::Specification for Ultrasphinx-1.11
# Originally generated by Echoe

Gem::Specification.new do |s|
  s.name = %q{ultrasphinx}
  s.version = "1.11"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [""]
  s.date = %q{2008-05-26}
  s.description = %q{Ruby on Rails configurator and client to the Sphinx fulltext search engine.}
  s.email = %q{}
  s.extra_rdoc_files = ["CHANGELOG", "DEPLOYMENT_NOTES", "lib/ultrasphinx/is_indexed.rb", "lib/ultrasphinx/search.rb", "lib/ultrasphinx/spell.rb", "lib/ultrasphinx/ultrasphinx.rb", "lib/ultrasphinx.rb", "LICENSE", "RAKE_TASKS", "README", "TODO"]
  s.files = ["CHANGELOG", "DEPLOYMENT_NOTES", "examples/ap.multi", "examples/default.base", "init.rb", "lib/ultrasphinx/associations.rb", "lib/ultrasphinx/autoload.rb", "lib/ultrasphinx/configure.rb", "lib/ultrasphinx/core_extensions.rb", "lib/ultrasphinx/fields.rb", "lib/ultrasphinx/is_indexed.rb", "lib/ultrasphinx/postgresql/concat_ws.sql", "lib/ultrasphinx/postgresql/crc32.sql", "lib/ultrasphinx/postgresql/group_concat.sql", "lib/ultrasphinx/postgresql/hex_to_int.sql", "lib/ultrasphinx/postgresql/language.sql", "lib/ultrasphinx/postgresql/unix_timestamp.sql", "lib/ultrasphinx/search/internals.rb", "lib/ultrasphinx/search/parser.rb", "lib/ultrasphinx/search.rb", "lib/ultrasphinx/spell.rb", "lib/ultrasphinx/ultrasphinx.rb", "lib/ultrasphinx.rb", "LICENSE", "Manifest", "RAKE_TASKS", "README", "tasks/ultrasphinx.rake", "test/config/ultrasphinx/test.base", "test/integration/app/app/controllers/addresses_controller.rb", "test/integration/app/app/controllers/application.rb", "test/integration/app/app/controllers/sellers_controller.rb", "test/integration/app/app/controllers/states_controller.rb", "test/integration/app/app/controllers/users_controller.rb", "test/integration/app/app/helpers/addresses_helper.rb", "test/integration/app/app/helpers/application_helper.rb", "test/integration/app/app/helpers/sellers_helper.rb", "test/integration/app/app/helpers/states_helper.rb", "test/integration/app/app/helpers/users_helper.rb", "test/integration/app/app/models/category.rb", "test/integration/app/app/models/geo/address.rb", "test/integration/app/app/models/geo/country.rb", "test/integration/app/app/models/geo/state.rb", "test/integration/app/app/models/person/user.rb", "test/integration/app/app/models/seller.rb", "test/integration/app/app/views/addresses/edit.html.erb", "test/integration/app/app/views/addresses/index.html.erb", "test/integration/app/app/views/addresses/new.html.erb", "test/integration/app/app/views/addresses/show.html.erb", "test/integration/app/app/views/layouts/addresses.html.erb", "test/integration/app/app/views/layouts/sellers.html.erb", "test/integration/app/app/views/layouts/states.html.erb", "test/integration/app/app/views/layouts/users.html.erb", "test/integration/app/app/views/sellers/edit.html.erb", "test/integration/app/app/views/sellers/index.html.erb", "test/integration/app/app/views/sellers/new.html.erb", "test/integration/app/app/views/sellers/show.html.erb", "test/integration/app/app/views/states/edit.html.erb", "test/integration/app/app/views/states/index.html.erb", "test/integration/app/app/views/states/new.html.erb", "test/integration/app/app/views/states/show.html.erb", "test/integration/app/app/views/users/edit.html.erb", "test/integration/app/app/views/users/index.html.erb", "test/integration/app/app/views/users/new.html.erb", "test/integration/app/app/views/users/show.html.erb", "test/integration/app/config/boot.rb", "test/integration/app/config/database.yml", "test/integration/app/config/environment.rb", "test/integration/app/config/environments/development.rb", "test/integration/app/config/environments/production.rb", "test/integration/app/config/environments/test.rb", "test/integration/app/config/locomotive.yml", "test/integration/app/config/routes.rb", "test/integration/app/config/ultrasphinx/default.base", "test/integration/app/config/ultrasphinx/development.conf.canonical", "test/integration/app/db/migrate/001_create_users.rb", "test/integration/app/db/migrate/002_create_sellers.rb", "test/integration/app/db/migrate/003_create_addresses.rb", "test/integration/app/db/migrate/004_create_states.rb", "test/integration/app/db/migrate/005_add_capitalization_to_seller.rb", "test/integration/app/db/migrate/006_add_deleted_to_user.rb", "test/integration/app/db/migrate/007_add_lat_and_long_to_address.rb", "test/integration/app/db/migrate/008_add_mission_statement_to_seller.rb", "test/integration/app/db/migrate/009_create_countries.rb", "test/integration/app/db/migrate/010_create_categories.rb", "test/integration/app/db/migrate/011_categories_sellers.rb", "test/integration/app/doc/README_FOR_APP", "test/integration/app/public/404.html", "test/integration/app/public/500.html", "test/integration/app/public/dispatch.cgi", "test/integration/app/public/dispatch.fcgi", "test/integration/app/public/dispatch.rb", "test/integration/app/public/favicon.ico", "test/integration/app/public/images/rails.png", "test/integration/app/public/index.html", "test/integration/app/public/javascripts/application.js", "test/integration/app/public/javascripts/controls.js", "test/integration/app/public/javascripts/dragdrop.js", "test/integration/app/public/javascripts/effects.js", "test/integration/app/public/javascripts/prototype.js", "test/integration/app/public/robots.txt", "test/integration/app/public/stylesheets/scaffold.css", "test/integration/app/Rakefile", "test/integration/app/README", "test/integration/app/script/about", "test/integration/app/script/breakpointer", "test/integration/app/script/console", "test/integration/app/script/destroy", "test/integration/app/script/generate", "test/integration/app/script/performance/benchmarker", "test/integration/app/script/performance/profiler", "test/integration/app/script/plugin", "test/integration/app/script/process/inspector", "test/integration/app/script/process/reaper", "test/integration/app/script/process/spawner", "test/integration/app/script/runner", "test/integration/app/script/server", "test/integration/app/test/fixtures/addresses.yml", "test/integration/app/test/fixtures/categories.yml", "test/integration/app/test/fixtures/categories_sellers.yml", "test/integration/app/test/fixtures/countries.yml", "test/integration/app/test/fixtures/sellers.yml", "test/integration/app/test/fixtures/states.yml", "test/integration/app/test/fixtures/users.yml", "test/integration/app/test/functional/addresses_controller_test.rb", "test/integration/app/test/functional/sellers_controller_test.rb", "test/integration/app/test/functional/states_controller_test.rb", "test/integration/app/test/functional/users_controller_test.rb", "test/integration/app/test/test_helper.rb", "test/integration/app/test/unit/address_test.rb", "test/integration/app/test/unit/category_test.rb", "test/integration/app/test/unit/country_test.rb", "test/integration/app/test/unit/seller_test.rb", "test/integration/app/test/unit/state_test.rb", "test/integration/app/test/unit/user_test.rb", "test/integration/configure_test.rb", "test/integration/delta_test.rb", "test/integration/search_test.rb", "test/integration/server_test.rb", "test/integration/spell_test.rb", "test/profile/benchmark.rb", "test/setup.rb", "test/teardown.rb", "test/test_all.rb", "test/test_helper.rb", "test/ts.multi", "test/unit/parser_test.rb", "TODO", "vendor/riddle/lib/riddle/client/filter.rb", "vendor/riddle/lib/riddle/client/message.rb", "vendor/riddle/lib/riddle/client/response.rb", "vendor/riddle/lib/riddle/client.rb", "vendor/riddle/lib/riddle.rb", "vendor/riddle/MIT-LICENCE", "vendor/riddle/Rakefile", "vendor/riddle/README", "vendor/riddle/spec/fixtures/data/anchor.bin", "vendor/riddle/spec/fixtures/data/any.bin", "vendor/riddle/spec/fixtures/data/boolean.bin", "vendor/riddle/spec/fixtures/data/comment.bin", "vendor/riddle/spec/fixtures/data/distinct.bin", "vendor/riddle/spec/fixtures/data/field_weights.bin", "vendor/riddle/spec/fixtures/data/filter.bin", "vendor/riddle/spec/fixtures/data/filter_array.bin", "vendor/riddle/spec/fixtures/data/filter_array_exclude.bin", "vendor/riddle/spec/fixtures/data/filter_floats.bin", "vendor/riddle/spec/fixtures/data/filter_floats_exclude.bin", "vendor/riddle/spec/fixtures/data/filter_floats_range.bin", "vendor/riddle/spec/fixtures/data/filter_range.bin", "vendor/riddle/spec/fixtures/data/filter_range_exclude.bin", "vendor/riddle/spec/fixtures/data/group.bin", "vendor/riddle/spec/fixtures/data/index.bin", "vendor/riddle/spec/fixtures/data/index_weights.bin", "vendor/riddle/spec/fixtures/data/keywords_with_hits.bin", "vendor/riddle/spec/fixtures/data/keywords_without_hits.bin", "vendor/riddle/spec/fixtures/data/phrase.bin", "vendor/riddle/spec/fixtures/data/rank_mode.bin", "vendor/riddle/spec/fixtures/data/simple.bin", "vendor/riddle/spec/fixtures/data/sort.bin", "vendor/riddle/spec/fixtures/data/update_simple.bin", "vendor/riddle/spec/fixtures/data/weights.bin", "vendor/riddle/spec/fixtures/data_generator.php", "vendor/riddle/spec/fixtures/sphinx/configuration.erb", "vendor/riddle/spec/fixtures/sphinxapi.php", "vendor/riddle/spec/fixtures/sql/conf.example.yml", "vendor/riddle/spec/fixtures/sql/data.sql", "vendor/riddle/spec/fixtures/sql/structure.sql", "vendor/riddle/spec/functional/excerpt_spec.rb", "vendor/riddle/spec/functional/keywords_spec.rb", "vendor/riddle/spec/functional/search_spec.rb", "vendor/riddle/spec/functional/update_spec.rb", "vendor/riddle/spec/spec_helper.rb", "vendor/riddle/spec/sphinx_helper.rb", "vendor/riddle/spec/unit/client_spec.rb", "vendor/riddle/spec/unit/filter_spec.rb", "vendor/riddle/spec/unit/message_spec.rb", "vendor/riddle/spec/unit/response_spec.rb", "vendor/will_paginate/LICENSE", "ultrasphinx.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://blog.evanweaver.com/files/doc/fauna/ultrasphinx/}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Ultrasphinx", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fauna}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{Ruby on Rails configurator and client to the Sphinx fulltext search engine.}
  s.test_files = ["test/test_all.rb"]

  s.add_dependency(%q<chronic>, [">= 0"])
end


# # Original Rakefile source (requires the Echoe gem):
# 
# 
# require 'echoe'
# 
# Echoe.new("ultrasphinx") do |p|
#   p.project = "fauna"
#   p.summary = "Ruby on Rails configurator and client to the Sphinx fulltext search engine."
#   p.url = "http://blog.evanweaver.com/files/doc/fauna/ultrasphinx/"  
#   p.docs_host = "blog.evanweaver.com:~/www/bax/public/files/doc/"  
#   p.rdoc_pattern = /is_indexed.rb|search.rb|spell.rb|ultrasphinx.rb|^README|TODO|DEPLOY|RAKE_TASKS|CHANGELOG|^LICENSE/
#   p.dependencies = "chronic"
#   p.test_pattern = ["test/integration/*.rb", "test/unit/*.rb"]
#   p.rcov_options << '--include-file test\/integration\/app\/vendor\/plugins\/ultrasphinx\/lib\/.*\.rb --include-file '
# end
# 
# desc "Run all the tests for every database adapter" 
# task "test_all" do
#   ['mysql', 'postgresql'].each do |adapter|
#     ENV['DB'] = adapter
#     ENV['PRODUCTION'] = nil
#     STDERR.puts "#{'='*80}\nDevelopment mode for #{adapter}\n#{'='*80}"
#     system("rake test:multi_rails:all")
#   
#     ENV['PRODUCTION'] = '1'
#     STDERR.puts "#{'='*80}\nProduction mode for #{adapter}\n#{'='*80}"
#     system("rake test:multi_rails:all")    
#   end
# end