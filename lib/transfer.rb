#require 'pry'
class Transfer
  attr_accessor  :receiver, :amount, :status

  attr_reader :sender, :bankaccount

  def initialize(sender, receiver,  amount, status="pending")
    #binding.pry
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
  end

  def valid?
    if (sender.valid? && receiver.valid?)
        return true
    else
      return false
    end
  end

  def execute_transaction 
    if (self.status == "pending" && @sender.balance > @amount && self.valid?)
       @sender.balance -= @amount
       @receiver.deposit(@amount)
       self.status = "complete"
    else
      self.status = "rejected" 
      return "Transaction rejected. Please check your account balance."
    end

  end

  def reverse_transfer
    if (self.status == "complete")
      @receiver.balance -= @amount
      @sender.deposit(@amount)
      self.status = "reversed"
    end
  end

end

