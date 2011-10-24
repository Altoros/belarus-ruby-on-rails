namespace :legacy do
  desc "Import the legacy data."
  task :import => :environment do
    #Remove existing users and profiles
    User.delete_all
    Profile.delete_all
    puts "\033[0;32mCurrent users deleted\033[0m"

    #Import users
    print "\033[0;32mCreating new users \033[0m"
    #experience_id = Experience.first.id
    LegacyUser.find(:all, :group => 'email', :conditions => {:block => 0}).each { |old_user|
      user = User.new(
        :email => old_user.email
      )
      user.id = old_user.id
      if ['Super Administrator', 'Administrator'].any? {|type| old_user.usertype == type}
        user.is_admin = true
      end
      user.build_profile
      user.profile = Profile.new(
        :first_name => old_user.name.gsub(/\s+.*$/, ''),
        :last_name => old_user.name.gsub(/^.*?\s+/, '')
      )
      user.encrypted_password = old_user.password.scan(/^(.*):/)[0][0]
      user.password_salt = old_user.password.scan(/:(.*)$/)[0][0]
      user.confirm!
      print "\033[0;32m.\033[0m"
    }
    puts


    #Remove existing meetups
    Meetup.delete_all
    puts "\033[0;32mCurrent meetups deleted\033[0m"

    #Import meetups
    print "\033[0;32mImport meetups \033[0m"
    LegacyRecords.select('DISTINCT name').each { |record|
      meetup = Meetup.new(
        :topic => record.name,
        :date_and_time => DateTime.parse(record.name.gsub(/conference_/, '').gsub(/_/, '/') + ' GMT').utc
      )
      meetup.save!(:validate => false)
      print "\033[0;32m.\033[0m"
    }
    puts

    #Remove existing participants
    Participant.delete_all
    puts "\033[0;32mCurrent participants deleted\033[0m"

    #Import participants
    print "\033[0;32mImport participants \033[0m"
    LegacyRecords.where(:form => 17).each { |record|
      #getting email
      subrecord = LegacySubrecords.where(:record => record.id, :element => 203).first
      email = subrecord.value if subrecord
      next if !email

      #getting user if possible
      user = User.where(:email => email).first

      #getting experience if possible
      subrecord = LegacySubrecords.where(:record => record.id, :element => 206).first
      subrecord_value = subrecord.value if subrecord
      experience = Experience.where(:level => experience).first if subrecord_value
      experience_id = experience.id if experience

      #check if we should register new user
      if user

        #Updating experience level of existing  user
        if experience_id
          user.profile.experience_id = experience_id
          user.save!
        end

      else

        #getting first name
        subrecord = LegacySubrecords.where(:record => record.id, :element => 198).first
        first_name = subrecord.value if subrecord

        #getting last name
        subrecord = LegacySubrecords.where(:record => record.id, :element => 200).first
        last_name = subrecord.value if subrecord

        #assign default experience level to user
        Experience.first.id if !experience_id

        #check if we have enough data for creating new user
        next if !first_name || !last_name

        #creating new user
        user = User.new(
          :email => email,
          :password => Devise.friendly_token[0,20]
        )
        user.created_at = record.submitted
        user.build_profile
        user.profile = Profile.new(
          :first_name => first_name,
          :last_name => last_name,
          :experience_id => experience_id
        )
        user.confirm!

      end

      #assigning user to meetup
      Participant.create(
        :meetup_id => Meetup.where(:topic => record.name).first.id,
        :user_id => user.id,
        :created_at => record.submitted
      )

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
      Article.create!(
        :title => article.title,
        :content => article.introtext,
        :published => true,
        :created_at => article.created,
        :updated_at => article.modified,
        :user_id => article.created_by,
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
        AggregatedArticle.create!(
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

class LegacyRecords < Legacy
  set_table_name 'rug_facileforms_records'
end

class LegacySubrecords < Legacy
  set_table_name 'rug_facileforms_subrecords'
  set_inheritance_column :ruby_type
end
