class Restaurant < ActiveRecord::Base

  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews,
   -> { extending WithUserAssociationExtension },
      dependent: :restrict_with_exception,
      dependent: :destroy

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end


end
