require 'aws-sdk'
require 'elsm/aws/server'

module Elsm
  class Compute
    class AWS
      def initialize(options={})
        @options = options
        @ec2 = ::AWS::EC2.new(
          :access_key_id => @options[:access_key_id],
          :secret_access_key => @options[:secret_access_key],
        )
        @region = @ec2.regions[@options[:region]]
      end

      def new(options={})
        key_pair = @region.key_pairs[options[:key_pair]]
        security_groups = @region.security_groups[options[:security_group]]
        instance = @region.instances.create(
          :image_id => options[:image_id],
          :instance_type => options[:instance_type],
          :key_pair => key_pair,
          :security_groups => security_groups,
        )
        Elsm::Server::AWS.new(instance)
      end

      def [] name
        instance = @region.instances[name]
        Elsm::Server::AWS.new(instance) if instance.exists?
      end

      def servers
        # Get server list from region
        servers = @region.instances.collect {|v|
          if v.status != :terminated
            Elsm::Server::AWS.new(v)
          end
        }

        # Remove nil objects
        servers.reject {|v|
          true if v == nil
        }
      end
    end
  end
end
