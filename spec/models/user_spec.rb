require 'spec_helper'

RSpec.describe User, :type => :model do
    subject {
        described_class.new(
            name: "Rspec test",
            password: "123456Tt",
            password_confirmation: "123456Tt",
            email: "rspec@mail.com",
            cpf: "55385674869")
    }

    describe "Validations" do
        it "is valid with valid attributes" do
            expect(subject).to be_valid
        end
        
        it "is not valid without email" do
            subject.email = nil
            expect(subject).to_not be_valid
        end

        it "is not valid with invalid email" do
            subject.email = "this_is_invalid"
            expect(subject).to_not be_valid
        end

        it "is not valid without password" do
            subject.password = nil
            expect(subject).to_not be_valid
        end

        it "is not valid password with only numbers" do
            subject.password = "123456"
            expect(subject).to_not be_valid
        end

        it "is not valid password without lowercase letter " do
            subject.password = "123456A"
            expect(subject).to_not be_valid
        end

        it "is not valid password without uppercase letter " do
            subject.password = "123456a"
            expect(subject).to_not be_valid
        end

        it "is not valid without CPF " do
            subject.cpf = nil
            expect(subject).to_not be_valid
        end

        it "is not valid with invalid CPF " do
            subject.cpf = "12345678910"
            expect(subject).to_not be_valid
        end
    end
end