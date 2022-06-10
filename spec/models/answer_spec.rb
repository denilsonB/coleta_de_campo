require 'spec_helper'

RSpec.describe Answer, :type => :model do
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
    let!(:my_visit){ FactoryBot.create(:visit)}

    subject {
        described_class.new(
            content: "Rspec Answer",
            formulary_id: my_form.id,
            question_id: my_question.id,
            visit_id: my_visit.id,
            answered_at: Time.current)
    }
    
    describe "Validations" do
        it "is valid with valid attributes" do
            p subject
            expect(subject).to be_valid
        end

        it "is invalid with invalid formulary_id" do
            subject.formulary_id = 0
            expect(subject).to_not be_valid
        end

        it "is invalid with invalid question_id" do
            subject.question_id = 0
            expect(subject).to_not be_valid
        end

        it "is invalid with invalid visit_id" do
            subject.visit_id = 0
            expect(subject).to_not be_valid
        end

    end
end