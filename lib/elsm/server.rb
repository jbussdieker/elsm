require 'timeout'

module Elsm
  class Server
    def wait_port(port)
      begin 
        timeout(60) do
          while true do
            begin
              TCPSocket.new(self.ip_address, port)
              return true
            rescue Exception => e
            end
          end
        end
      rescue Timeout::Error
      end
      false
    end

    def wait_cloud_init
      begin
        timeout(60) do
          while true do
            r = run_cmd("file /var/lib/cloud/instance/boot-finished")
            return true if r == 0
          end
        end
      rescue Timeout::Error
      end
      false
    end

    def wait_ready
      true
    end

    def scp_to(src, dst, &block)
      cmd = self.popen_scp_to(src, dst)
      cmd.each do |line|
        yield line if block
      end
      cmd.close
      $?.exitstatus
    end

    def write_facts(type, master)
      File.open("/tmp/facts-#{$$}.rb", "w") {|f|
        f.write("Facter.add('master') do\nsetcode do\n'#{master}'\nend\nend\n" +
                "Facter.add('type') do\nsetcode do\n'#{type}'\nend\nend\n")
      }
      result = scp_to("/tmp/facts-#{$$}.rb", "facts.rb")
      return false if result != 0
      result = run_cmd("sudo mkdir -p /var/lib/puppet/lib/facter")
      return false if result != 0
      result = run_cmd("sudo cp facts.rb /var/lib/puppet/lib/facter")
      result == 0
    end

    def run_cmd(cmd, &block)
      cmd_run = self.popen(cmd)
      cmd_run.each do |line|
        yield line if block
      end
      cmd_run.close
      $?.exitstatus
    end
  end
end
