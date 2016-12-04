class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid? && sender.balance >= amount
  end

  def execute_transaction
    if status == "complete" || valid? == false
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    else
      sender.deposit(-amount)
      receiver.deposit(amount)
      self.status = "complete"
    end
  end
  def reverse_transfer
    if status == "complete"
      receiver.deposit(-amount)
      sender.deposit(amount)
      self.status = "reversed"
    end
  end
end
