require 'spec_helper'

RSpec.describe Visit, :type => :model do 
    #let!(:my_visit) {FactoryBot.create(:visit)}
    let!(:my_user) {FactoryBot.create(:user)}

    subject {
        described_class.new(
            date: "06-06-2022",
            status: 0,
            user_id: my_user.id,
            checkin_at: "04-06-2022",
            checkout_at: "05-06-2022")
    }

    describe "validations" do
        it "is valid with valid attributes" do 
            expect(subject).to be_valid
        end
    end
end