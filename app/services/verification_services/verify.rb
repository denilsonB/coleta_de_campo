module VerificationServices
    class Verify  < ApplicationService
        prepend SimpleCommand

        def initialize(object1,object2)
            @object1 = object1
            @object2 = object2
        end

        def call 
            verify
        end
        
        private 

        def verify
            
            if @object1 == @object2
                true
            else
                false
            end
        end
        
    end
end