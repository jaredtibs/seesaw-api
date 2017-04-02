#currently unused
#TODO remove or use
class Media < ApplicationRecord
  belongs_to :user
  belongs_to :post

  enum kind: {
    photo: 1
  }

end
