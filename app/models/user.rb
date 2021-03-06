class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :group_users
  has_many :groups, through: :group_users
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.looks(searches, words)
    if searches == "forward_match"
      @users = User.where("name LIKE ?", "#{words}%")
    elsif searches == "backward_match"
      @users = User.where("name LIKE ?", "%#{words}")
    elsif searches == "perfect_match"
      @users = User.where("name LIKE ?", "#{words}")
    elsif searches == "partial_match"
      @users = User.where("name LIKE ?", "%#{words}%")
    else
      @users = User.all
    end
  end


end
