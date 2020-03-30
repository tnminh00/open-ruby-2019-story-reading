module StoriesHelper
  def average_rate story
    if story.rate_average.blank?
      t ".no_rates"
    else
      story.rate_average.avg
    end
  end

  def sales_types_option
    Story.sales_types.map do |key, value|
      [t(".#{key}"), key]
    end
  end
end
