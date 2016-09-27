# Site Health Monitor
Monitor site availability and send notification utilizing twilio api

1. Get your console account & phone number at https://www.twilio.com/console
2. Modify and rename confg.rb
3. Run bundle install
4. Set regular cron. e.g per 5 minutes: */5 * * * * /usr/local/ruby /your_parent_dir/checker.rb
5. Run rvm cron setup & specify ruby path if you're using RVM