# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  link       :string(255)
#  artist     :string(255)
#  event_date :string(255)
#  venue      :string(255)
#  location   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Event < ActiveRecord::Base
  belongs_to :user
end
