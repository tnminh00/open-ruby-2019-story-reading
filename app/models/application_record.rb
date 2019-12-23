class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def date_time
    return unless self.updated_at
    updated_at.strftime Settings.date_format
  end
end
