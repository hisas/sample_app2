class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  scope :content_like, ->(content) { where("content LIKE ?", "%#{sanitize_sql_like(content)}%") }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  def liked_by(user_id)
    likes.find_by(user_id: user_id)
  end

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
