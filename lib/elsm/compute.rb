module Elsm
  class Compute
    def self.new(provider, options={})
      case provider
      when :aws
        require 'elsm/aws/compute'
        Elsm::Compute::AWS.new(options)
      else
        raise ArgumentError.new("#{provider} is not a recognized provider")
      end
    end
  end
end
