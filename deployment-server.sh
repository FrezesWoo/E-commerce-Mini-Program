echo $1
# upload_task = "$1 upload:copy"
# echo "$upload_task"
# cap "$upload_task"
cap uat upload:copy
cap uat deploy:migrate
cap uat bundler:install --local
cap uat sidekiq:restart
cap uat deploy:assets:precompile
cap uat puma:restart
cap uat nginx:restart
