class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments
  is_impressionable counter_cache: true
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  acts_as_taggable

  [:vocab, :definition, :example, :image, :user_id].each do |v|
    validates v, presence: true
  end
  validates :vocab, length: { maximum: 40 }
  def previous
    user.posts.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
  end

  def next
    user.posts.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
  end

  def self.search(search)
    if search != ""
      Post.where('vocab LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
end
