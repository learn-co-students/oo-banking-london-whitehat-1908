class Transfer
    attr_accessor :status
    attr_reader :amount, :sender, :receiver
    
    def initialize(sender, receiver, amount)
        @status = "pending"
        @sender = sender
        @receiver = receiver
        @amount = amount
    end
    
    def valid?
        sender.valid? && receiver.valid?
    end
    
    def execute_transaction
        if(valid? && receiver.balance > amount && self.status == "pending")
            sender.balance -= amount
            receiver.balance += amount
            self.status = "complete"
        else
            self.status = "rejected"
            "Transaction rejected. Please check your account balance."
        end
    end
    
    def reverse_transfer
        if(valid? && sender.balance > amount && self.status == "complete")
            sender.balance += amount
            receiver.balance -= amount
            self.status = "reversed"
        else
            self.status = "rejected"
            "Transaction rejected. Please check your account balance."
        end
    end
end
