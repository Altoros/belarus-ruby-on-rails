class UsersFilter
  class << self
    def options_for_select
      collection.invert
    end

    def collection(reload = false)
      @filters_collection = generate if reload or not defined?(@filters_collection)
      @filters_collection
    end

    def emails_list(filters)
      User.filter(filters).joins(:profile).merge(Profile.subscribed).collect(&:email)
    end

    private

    def generate
      res = { '0' => I18n.t('labels.all') }
      Meetup.all.each { |el| res[el.id.to_s] = el.topic }
      res
    end
  end
end
