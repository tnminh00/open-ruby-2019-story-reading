module StoriesHelper
  def average_rate story
    if story.rate_average.blank?
      t ".no_rates"
    else
      story.rate_average.avg
    end
  end
end
