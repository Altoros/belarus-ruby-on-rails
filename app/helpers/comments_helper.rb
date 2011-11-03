module CommentsHelper
  def shallow_comment
    true if ['edit', 'update'].include? action_name
  end
end
