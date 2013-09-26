require 'hashie'
require 'pp'

module HelloSign
  class Response < Hashie::Mash

    def to_s
      pretty_inspect
    end

  end
end
