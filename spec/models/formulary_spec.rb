require 'spec_helper'

RSpec.describe Formulary, :type => :model do
    let!(:my_forms){FactoryBot.create_list(:formulary,2)}
    
    describe "Validations" do
        it "is valid with valid attributes" do
            expect(my_forms[1]).to be_valid
        end
        it "is invalid with same name" do
            my_forms[0].name = my_forms[1].name
            expect(my_forms[0]).to_not be_valid
        end
        it 'is invalid with blank name' do
            my_forms[0].name = ""
            expect(my_forms[0]).to_not be_valid
        end
    end
end