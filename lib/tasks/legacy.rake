namespace :legacy do
  desc "Import the legacy data."
  task :import => :environment do
    #Remove existing users and profiles
    User.delete_all
    Profile.delete_all
    puts "\033[0;32mCurrent users deleted\033[0m"

    #Import users
    print "\033[0;32mCreating new users \033[0m"
    experience_id = Experience.first.id
    LegacyUser.where(:block => 0).each { |old_user|
      user = User.new(
        :email => old_user.email,
        :password => old_user.password
      )
      user.id = old_user.id
      user.skip_confirmation!
      if ['Super Administrator', 'Administrator'].any? {|type| old_user.usertype == type}
        user.is_admin = true
      end
      user.build_profile
      user.profile = Profile.new(
        :first_name => old_user.name,
        :last_name => old_user.name,
        :experience_id => experience_id
      )
      user.save
      user.encrypted_password = old_user.password.scan(/^(.*):/)[0][0]
      user.password_salt = old_user.password.scan(/:(.*)$/)[0][0]
      user.save
      print "\033[0;32m.\033[0m"
    }
    puts


    #Remove existing news
    Article.delete_all
    puts "\033[0;32mCurrent news deleted\033[0m"

    #Import custom news
    print "\033[0;32mImport custom news \033[0m"
    LegacyArticle.where(:catid => 2, :state => 1).each { |article|
      slug = LegacyRedirection.where(
        :newurl => 'index.php?option=com_content&id=' + article.id.to_s + '&task=view'
      ).first.oldurl.gsub(/\.html$/, '')
      Article.create(
        :title => article.title,
        :content => article.introtext,
        :published => true,
        :created_at => article.created,
        :updated_at => article.modified,
        #:user_id => article.created_by,
        :slug => slug
      )
      print "\033[0;32m.\033[0m"
    }
    puts

    #Import aggregated news
    print "\033[0;32mImport aggregated news \033[0m"
    LegacyArticle.where(:catid => 1, :state => 1).each { |article|
      slug = LegacyRedirection.where(
        :newurl => 'index.php?option=com_content&id=' + article.id.to_s + '&task=view'
      ).first.oldurl.gsub(/\.html$/, '')
      rss_link_attribute = article.fulltext.scan(/href="(.*?)"/) if article.fulltext
      rss_link = rss_link_attribute[0][0] if rss_link_attribute.count > 0
      complex_rss_link = rss_link.scan(/&url=(.*?)&cid/) if rss_link
      rss_link = complex_rss_link[0][0] if complex_rss_link && complex_rss_link.count > 0
      title = CGI.unescapeHTML(article.title)
      if rss_link && rss_link.scan(/^http/i).count > 0
        AggregatedArticle.create(
          :title => title.gsub(/<.*?>/, ''),
          :content => article.introtext
                        .gsub(/<i.*?<\/i>/, '')
                        .gsub(/<img.*?>/, '')
                        .gsub(/<.*?>/, '')
                        .strip,
          :published => true,
          :created_at => article.created,
          :updated_at => article.modified,
          :rss_link => rss_link,
          :slug => slug
        )
        print "\033[0;32m.\033[0m"
      end
    }
    puts

  end
end

class Legacy < ActiveRecord::Base
  config = YAML::load(File.open('config/database.yml'))
  establish_connection config['legacy']
end

class LegacyArticle < Legacy
  set_table_name 'rug_content'
end

class LegacyRedirection < Legacy
  set_table_name 'rug_redirection'
end

class LegacyUser < Legacy
  set_table_name 'rug_users'
end
