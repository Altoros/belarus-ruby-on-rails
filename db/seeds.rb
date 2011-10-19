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
                          :search => '#hacby',
                          :footer_text => 'Присоединиться к обсуждению'}
                        else
                          {:title => 'What is written about',
                          :subject => 'Belarus Ruby on Rails',
                          :search => '#hacby',
                          :footer_text => 'Join the conversation'}
                        end
TwitterBlock.delete_all
TwitterBlock.create(
  :title => twitter_block_settings[:title],
  :subject => twitter_block_settings[:subject],
  :search => twitter_block_settings[:search],
  :footer_text => twitter_block_settings[:footer_text]
)
