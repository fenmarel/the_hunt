class JobApplication < ActiveRecord::Base
  belongs_to :user

  def deny!
    self.status = 'DENIED'
    self.reply_date = DateTime.now
    self.save!
  end

  def renew!
    self.status = 'PENDING'
    self.reply_date = nil
    self.save!
  end
end