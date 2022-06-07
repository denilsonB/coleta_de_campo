require 'spec_helper'

RSpec.describe Visit, :type => :model do 
    let!(:my_user) {FactoryBot.create(:user)}

    subject {
        described_class.new(
            date: Date.tomorrow,
            status: 0,
            user_id: my_user.id,
            checkin_at: "04-06-2022",
            checkout_at: "05-06-2022")
    }

    describe "validations" do
        it "is valid with valid attributes" do 
            expect(subject).to be_valid
        end
        
        it "is invalid with date less than created_at" do
            subject.date = Date.yesterday
            expect(subject).to_not be_valid
        end
        
        it "is invalid with checkin_at after or equal to today" do
            subject.checkin_at = DateTime.now
            expect(subject).to_not be_valid
        end
        it "is invalid with checkin_at greater than checkout_at" do
            subject.checkin_at = Date.yesterday
            subject.checkout_at = 2.days.ago
            expect(subject).to_not be_valid
        end
        it "is invalid with checkout_at less than checkin_at" do
            subject.checkin_at = DateTime.current
            subject.checkout_at = 1.hour.ago
            expect(subject).to_not be_valid            
        end
        it "is invalid when user don't exist" do
            subject.user_id = -1
            expect(subject).to_not be_valid
        end
    end
end