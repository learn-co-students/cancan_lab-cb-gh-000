class Note < ActiveRecord::Base
	belongs_to :user
	has_many :viewers
	has_many :readers, through: :viewers, source: :user


	def visible_to=(readers_names)
		
		readers_names = readers_names.gsub(" ", "").split(",")
		
		readers_names.each do |reader_name|
			user = User.find_or_create_by(name: reader_name)
			self.viewers.build(user: user)
		end
	end

	def visible_to
		self.readers.collect(&:name).join(", ")
	end
end
