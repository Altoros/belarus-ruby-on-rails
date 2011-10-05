class UsersFilter

  def self.filters_collection
    res = { 0 => I18n.t('labels.all') }
    # TODO select all meetups and include them with id to result hash
    res
  end

  def self.emails_list(filter)
    filter = filter.to_i
    if filter == 0 or !filters_collection.include?(filter)
      emails = Profile.select('DISTINCT users.email AS email').subscribed
    else
      # TODO select emails of users, which take part in selected meetup
    end

    emails.collect(&:email)
  end
end
