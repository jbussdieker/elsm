module MCollective
  module Agent
    class Rvmgem < RPC::Agent
      metadata    :name        => "RVM Gem Agent",
                  :description => "",
                  :author      => "Joshua Bussdieker <josh.bussdieker@moovweb.com>",
                  :license     => "",
                  :version     => "",
                  :url         => "",
                  :timeout     => 300

      def run_command(cmd)
        reply[:cmd] = cmd
        cmdrun = IO.popen(cmd)
        output = cmdrun.readlines
        cmdrun.close
        if !$?.success?
          reply.fail "Could not run #{cmd}, it returned error (#{$?})\n#{output}"
        end
        output
      end

      def run_gem_command(cmd)
        env = ""
        if request[:environment]
          reply.fail! "Missing environment file" if !File.exists? request[:environment]
          env = ". #{request[:environment]} && "
        end
        gem_args = " --version #{request[:version]}" if request[:version]
        run_command("#{env}gem #{cmd}#{gem_args}")
      end

      action "list" do
        versions = run_gem_command("list #{request[:name]}")
        rval = {}
        versions.collect {|v|
          name, versions = v.split(" ", 2)
          versions.chomp!
          versions = versions[1..-2]
          rval[name.to_s] = versions.split(", ")
        }
        reply[:gems] = rval
      end

      action "cleanup" do
        run_gem_command("cleanup #{request[:name]}")
      end

      action "install" do
        reply.fail! "Missing gem name" if !request[:name]
        run_gem_command("install #{request[:name]} --no-ri --no-rdoc")
      end

      action "uninstall" do
        reply.fail! "Missing gem name" if !request[:name]
        cmd = "uninstall #{request[:name]}"
        # Uninstall all gem versions unless one is specified
        cmd += " -a" if !request[:version]
        run_gem_command(cmd)
      end 
    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby
