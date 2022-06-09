require 'spec_helper'

RSpec.describe Question, :type => :model do
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_questions){FactoryBot.create_list(:question,2,formulary: my_form)}

    subject {
        described_class.new(
            name: "Rspec question",
            formulary_id: my_form.id,
            question_type: 0)
    }
    
    describe "Validations" do
        it "is valid with valid attributes" do
            p subject
            expect(subject).to be_valid
        end

        it "is valid if image is attached and type is 1" do
            subject.question_type = 1
            subject.image.attach(io: File.open(Rails.root.join('spec','images','Question.png')), filename: 'Question.png', content_type: 'image/png')
            expect(subject).to be_valid
        end

        it "is not valid if image is not attached and type is 1" do
            subject.question_type = 1
            expect(subject).to_not be_valid
        end
        
        it "is not valid if the name already exists in this formulary" do
            my_questions[0].name = my_questions[1].name
            expect(my_questions[0]).to_not be_valid
        end
    end
end