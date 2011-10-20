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

AggregatorConfiguration.create(
  :source => 'http://news.google.com/news?cf=all&ned=ru_ru&hl=ru&q=%22ruby+on+rails%22+OR+%22Ruby-on-RAILS%22+OR+%22ruby+development%22+OR+%22rails+development%22+OR+%22ruby+developers%22+OR+%22rails+developers%22&as_qdr=d&as_drrb=q&cf=all&scoring=n&output=rss'
)
