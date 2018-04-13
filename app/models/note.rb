class Note < ActiveRecord::Base
  belongs_to :user
  has_many :viewers
  has_many :readers, through: :viewers, source: :user

  before_save :ensure_owner_can_read

  def visible_to
    self.readers.map{|reader| reader.name}.join(', ')
  end

  def visible_to=(new_readers)
    self.readers = new_readers.split(',').map do |name|
      User.find_by(name: name.strip)
    end.compact
  end

  def ensure_owner_can_read
    if user && !readers.include?(user)
      readers << user
    end
  end

end
