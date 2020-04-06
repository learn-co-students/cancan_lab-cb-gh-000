class Note < ApplicationRecord
  belongs_to :user
  has_many :viewers
  has_many :readers, through: :viewers, source: :user

  def visible_to
    readers.map {|reader| reader.name }.join(',')
  end

  def visible_to=(comma_string)
    usernames = comma_string.strip.split(',')

    usernames.map do |name|
      user = User.find_by_name(name)
      
      if user
        readers << user
        name
      end

    end.compact
  end

end
