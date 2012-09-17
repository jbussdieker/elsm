module MCollective
  module Agent
    class Bundle < RPC::Agent
      metadata    :name        => "Bundle Agent",
                  :description => "",
                  :author      => "Joshua Bussdieker <josh.bussdieker@moovweb.com>",
                  :license     => "",
                  :version     => "",
                  :url         => "",
                  :timeout     => 300

      def bundler_installed?
        `which bundle`
        $?.success?
      end

      def run_bundle_command(wd, cmd, env)
        run_env = ". #{env} &&" if env
        run_cmd = "#{run_env} cd #{wd} && bundle exec #{cmd}"
        cmdrun = IO.popen(run_cmd)
        output = cmdrun.readlines
        cmdrun.close
        if $?.to_i > 0
          reply.fail! output
        end
        output
      end

      action "execute" do
        reply.fail! "Missing working directory" if !request[:wd]
        reply.fail! "Missing command" if !request[:cmd]
        reply.fail! "Missing bundle command" if !bundler_installed?

        result = run_bundle_command(request[:wd], request[:cmd], request[:env])
        reply[:output] = result
      end
    end
  end
end
