module Elsm
  class Server
    class AWS < Elsm::Server
      def initialize(instance)
        @instance = instance
      end

      def ip_address
        @ip_address ||= @instance.ip_address
      end

      def write_facts(type, master)
        @instance.tags["type"] = type
        @instance.tags["master"] = master
        super(type, master)
      end

      def wait_ready(timeout=60, interval=5)
        while timeout > 0 do
          begin
            return true if @instance.status == :running
          rescue ::AWS::EC2::Errors::InvalidInstanceID::NotFound => e
            # It happens sometimes
          rescue Exception => e
            break
          end
          sleep interval
          timeout -= interval
        end
        false
      end

      def popen(cmd)
        IO.popen("ssh -o StrictHostKeyChecking=no ubuntu@#{@instance.public_dns_name} \"#{cmd}\" 2>&1")
      end

      def popen_scp_to(src, dst)
        IO.popen("scp -r -o StrictHostKeyChecking=no #{src} ubuntu@#{@instance.public_dns_name}:#{dst} 2>&1")
      end

      def method_missing(m, *args, &block)
        @instance.send(m)
      end
    end
  end
end
