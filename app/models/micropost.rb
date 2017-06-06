class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  scope :content_like, ->(content) { where("content LIKE ?", "%#{sanitize_sql_like(content)}%") }
  scope :including_replies, ->(user) { where("reply_to is ? OR reply_to = ? OR user_id = ?", nil, "@#{user.nickname}", user.id) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  before_save :reply_user

  def liked_by(user_id)
    likes.find_by(user_id: user_id)
  end

  def liked_users
    ids = likes.inject([]) { |ids, like| ids << like.user_id }
    User.where(id: ids)
  end

  def reply_user
    if nickname = content.match(/(@[^\s]+)\s.*/)
      self.reply_to = nickname[1]
    end
  end

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
