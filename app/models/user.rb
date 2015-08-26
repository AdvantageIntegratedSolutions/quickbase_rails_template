class User
  include QuickbaseRecord::Model

  attr_accessor :password

  define_fields do |t|
    t.dbid 'bj7v3ykr2'
    t.number :id, 3, :primary_key, :read_only
    t.string :email, 6
    t.string :encrypted_password, 7
    t.string :registration_status, 8
    t.number :related_customer, 9
  end

  validates :email, :password, presence: true

  def authenticate(attempted_password)
    return false unless attempted_password.present?
    BCrypt::Password.new(encrypted_password) == attempted_password
  end

  def set_encrypted_password
    self.encrypted_password = BCrypt::Password.create(password) if password
    self.password = nil
  end
end