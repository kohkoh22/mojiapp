class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :sns_credentials
  mount_uploader :image, ImageUploader
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
  has_many :following_user, through: :follower, source: :followed 
  has_many :follower_user, through: :followed, source: :follower 
  
  [:nickname, :email, :image, :password].each do |v|
    validates v, presence: true
  end
  validates :nickname, uniqueness: true
  validates :nickname, length: { maximum: 8 }

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    following_user.include?(user)
  end

  def self.search(search)
    if search != ""
      User.where('nickname LIKE(?)', "%#{search}%")
    else
      User.all
    end
  end

  

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
