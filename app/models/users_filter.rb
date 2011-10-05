class UsersFilter
  def self.options_for_select
    collection.invert
  end

  def self.collection
    @filters_collection ||= generate
  end

  def self.emails_list(filter)
    # 0 - 'all' option, another values ID of selected meetups
    if filter == '0' or !collection.include?(filter)
      emails = Profile.select('DISTINCT users.email AS email').subscribed
    else
      # TODO select emails of users, which take part in selected meetup
    end

    emails.collect(&:email)
  end

  private

  def self.generate
    res = { '0' => I18n.t('labels.all') }
    # TODO select all meetups and include them with id to result hash
    res
  end
end
