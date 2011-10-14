class UsersFilter
  def self.options_for_select
    collection.invert
  end

  def self.collection(reload = false)
    @filters_collection = generate if reload or not defined?(@filters_collection)
    @filters_collection
  end

  def self.emails_list(filter)
    # 0 - 'all' option, another values ID of selected meetups
    if filter == '0' or !collection.include?(filter)
      emails = Profile.select('DISTINCT users.email AS email').subscribed
    else
      emails = Profile.select('DISTINCT users.email AS email').participants_on(filter)
    end

    emails.collect(&:email)
  end

  private

  def self.generate
    res = { '0' => I18n.t('labels.all') }
    Meetup.all.each { |el| res[el.id.to_s] = el.topic }
    res
  end
end
