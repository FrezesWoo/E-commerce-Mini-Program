namespace :upload do
  desc "upload dist"
  task :copy do
    on roles(:all) do
      upload! "app", "/home/aurelien/apps/shiseido-ecmp-back/current/", recursive: true
      upload! "db", "/home/aurelien/apps/shiseido-ecmp-back/current/", recursive: true
      upload! "lib", "/home/aurelien/apps/shiseido-ecmp-back/current/", recursive: true
      upload! "config/locales", "/home/aurelien/apps/shiseido-ecmp-back/current/config/", recursive: true
      upload! "config/routes.rb", "/home/aurelien/apps/shiseido-ecmp-back/current/config/", recursive: true
      upload! "public/libraries", "/home/aurelien/apps/shiseido-ecmp-back/current/public/", recursive: true
    end
  end
end
