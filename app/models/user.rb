class User < ApplicationRecord
  has_secure_password validations: false
  # PASSWORD_REQUIREMENTS = /\A
  #   (?=.{8,}) # at least 8 characters long
  #   (?=.*\d)  # at least one number
  #   (?=.*[a-z]) # at least one lowercase
  #   (?=.*[A-Z]) # at least one uppercase
  # /x
  validates :password, presence: true,
                      confirmation: {message: 'Пароли не совпадают'},
                      length: {minimum: 8, message: 'Пароль должен состоять не менее, чем из 8 символов'}
  validates :username, presence: true,
                      length: { minimum: 3, message: 'Имя пользователя должно быть не короче 3-х символов' },
                      format: {
                        with: /\A[\da-zA-Z_]+\z/,
                        message: 'Имя пользователя должно состоять только из латинских букв, цифр и нижних подчеркиваний'
                      },
                      uniqueness: { message: 'Имя пользователя занято' }
  validates :email, allow_blank: true,
                    format: { with: /\A[^@;"\s]+@[^@;"\s]+\.[^@;"\s]+\z/, message: 'Неверный формат почты' },
                    uniqueness: { message: 'Почта занята другим пользователем' }

  def admin?
    role == 'admin'
  end
end
