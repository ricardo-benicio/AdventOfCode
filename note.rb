require 'securerandom'

class Note
    attr_reader :id

    def initialize(text)
        @id = SecureRandom.uuid
        @text = text
        @date = Time.now        
    end

    def to_s
        "Date: #{@date.strftime("%y-%m-%d %H:%M:%S")} \nNote: #@text"
        
    end
end