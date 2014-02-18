require "rspec"

require_relative "account"

describe Account do

  let(:account) { Account.new("0123456789") }
  let(:invalid_account) { Account.new("0123456789", "BADINPUT") }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account with the account number" do
        account.should be_an_instance_of(account.class)
      end
    end

    context "with invalid input" do
      it "raises an argument error when given an invalid account number" do
        expect{ Account.new("ABC") }.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  describe "#transactions" do
    context "with valid input" do
      it "requires a numeric or an unnamed starting_balance argument" do
        expect(account.transactions).to eq([0])
      end
    end

     context "with invalid input" do
      it "requires a numeric starting_balance argument" do
        expect { invalid_account }.to raise_error(InvalidStartingBalance)
      end
    end
  end

  describe "#balance" do
    it "returns the sum of transactions" do
      expect(account.balance).to eq(0)
    end
  end

  describe "#account_number" do
    it "returns a masked account number" do
      expect(account.acct_number).to eq ("******6789")
    end
  end

  describe "deposit!" do
    context "with valid input" do
      it "returns the current account balance" do
        expect(account.deposit!(100)).to eq(100)
      end
    end

    context "with invalid input" do
      it "raises an argument error when given an invalid deposit amount" do
        expect{ account.deposit!(-100) }.to raise_error(NegativeDepositError)
      end
    end
  end

  describe "#withdraw!" do
    context "with valid input causing overdraft" do
      it "returns the current account balance" do
        expect {account.withdraw!(100)}.to raise_error(OverdraftError)
      end
    end

    context "with valid input" do
      it "returns the current account balance" do
        expect(account.withdraw!(0)).to eq(0)
      end
    end

    context "with invalid input" do
      it "returns the current account balance" do
        expect {account.withdraw!("a")}.to raise_error(ArgumentError)
      end
    end
  end

end

=begin
What are the valid inputs, if any, for this method?
What constitutes expected return values?
What constitutes unexpected return values?
Does the method cause changes to the state of the program?
What defines a happy path scenario? What about a sad path?
=end
