class Movie < ActiveRecord::Base
  def self.get_all_ratings()
    # get all unique ratings in alphabetical order
    self.uniq.pluck(:rating).sort_by{|e| e}
  end
end
