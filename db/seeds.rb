# encoding: UTF-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

levels = if I18n.locale.to_s == 'ru'
           ['Что такое Ruby on Rails?', 'Новичок', 'Средний', 'Эксперт']
         else
           ['What is Ruby on Rails?', 'Beginner', 'Intermediate', 'Expert']
         end
Experience.delete_all
levels.each do |level|
  Experience.create(:level => level)
end

twitter_block_settings = if I18n.locale.to_s == 'ru'
                          {:title => 'Что пишут о',
                          :subject => 'Belarus Ruby on Rails',
                          :footer_text => 'Присоединиться к обсуждению'}
                        else
                          {:title => 'What is written about',
                          :subject => 'Belarus Ruby on Rails',
                          :footer_text => 'Join the conversation'}
                        end
TwitterBlock.delete_all
TwitterBlock.create(
  :title => twitter_block_settings[:title],
  :subject => twitter_block_settings[:subject],
  :search => '#hacby',
  :footer_text => twitter_block_settings[:footer_text]
)

StaticPage.delete_all
content_about = if I18n.locale.to_s == 'ru'
                  '<p>Белорусская Ruby on Rails User Group - сообщество Rails-девелоперов в Беларуси, созданное для обмена идеями и опытом. Мы также заинтересованы в развитии Ruby on Rails в нашей стране и помогаем друг другу построить успешную IT-карьеру.</p><p>Если Вы тоже желаете участвовать в развитии Belarus Ruby on Rails User Group, присылайте свои идеи на адрес:</p><p><a href="mailto:info@belarusrubyonrails.org">info@belarusrubyonrails.org</a></p>'
                else
                  '<p>Belarussian Ruby on Rails User Group is community of Rails-developers in Belarus, was found for exchenging ideas and expirience. We are also interested in developing Ruby on Rails in our country and help each other to build successfull IT-career.</p><p>If you would like take part in developing Belarus Ruby on Rails User Group, please send your ideas to: <a href="mailto:info@belarusrubyonrails.org">info@belarusrubyonrails.org</a></p>'
                end

title_about = if I18n.locale.to_s == 'ru'
                'О нас'
              else
                'About'
              end

content_friends = '<p><a target="_blank" href="http://belarusjug.org/">Belarus Java User Group</a></p><p><a rel="nofollow" target="_blank" href="http://belarusflex.org">Belarus Flex User Group</a></p>'

title_friends = if I18n.locale.to_s == 'ru'
                'Друзья'
              else
                'Friends'
              end
StaticPage.create(:title => title_about, :permalink => 'about', :content => content_about)
StaticPage.create(:title => title_friends, :permalink => 'friends', :content => content_friends)

AggregatorConfiguration.create(
  :source => 'http://news.google.com/news?cf=all&ned=ru_ru&hl=ru&q=%22ruby+on+rails%22+OR+%22Ruby-on-RAILS%22+OR+%22ruby+development%22+OR+%22rails+development%22+OR+%22ruby+developers%22+OR+%22rails+developers%22&as_qdr=d&as_drrb=q&cf=all&scoring=n&output=rss'
)
