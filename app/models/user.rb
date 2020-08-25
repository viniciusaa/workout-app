class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :exercises, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, class_name: "User"
  has_one :room, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }

  after_create :create_chatroom

  self.per_page = 10

  def self.search_by_name(name)
    names_array = name.split(' ')

    if names_array.size == 1
      where('first_name LIKE ? or last_name LIKE ?', "%#{names_array[0]}%",
        "%#{names_array[0]}%").order(:first_name)
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or
        last_name LIKE ?', "%#{names_array[0]}%",
        "%#{names_array[1]}%", "%#{names_array[0]}%",
        "%#{names_array[1]}%").order(:first_name)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def follows?(new_friend)
    friendships.map(&:friend).include?(new_friend)
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end

  private

  def create_chatroom
    hyphenated_username = self.full_name.split.join('-')
    Room.create(name: hyphenated_username, user_id: self.id)
  end
end
