module UsersHelper
  def follow
    current_user.follows.build
  end

  def unfollow
    current_user.follows.find_by story_id: @story.id
  end
end
