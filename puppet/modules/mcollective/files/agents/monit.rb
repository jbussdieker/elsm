module MCollective
  module Agent
    class Monit < RPC::Agent
      metadata    :name        => "Monit Agent",
                  :description => "",
                  :author      => "Joshua Bussdieker <josh.bussdieker@moovweb.com>",
                  :license     => "",
                  :version     => "",
                  :url         => "",
                  :timeout     => 300

      def run_monit_command(cmd)
        run_cmd = "monit #{cmd}"
        cmdrun = IO.popen(run_cmd)
        output = cmdrun.readlines
        cmdrun.close
        if !$?.success?
          reply.fail! output
        end
        output
      end

      action "start" do
        reply.fail! "Missing process name" if !request[:name]
        run_monit_command("start #{request[:name]}")
      end

      action "stop" do
        reply.fail! "Missing process name" if !request[:name]
        run_monit_command("stop #{request[:name]}")
      end

      action "summary" do
        lines = run_monit_command("summary")
        # Get rid of heading and system entry
        lines = lines[2..-2]
        rval = {}
        lines.collect {|line|
          type, name, status = line.split(" ", 3)
          name = name[1..-2]
          rval[name] = status.chomp
        }
        reply[:processes] = rval
      end

      action "status" do
        lines = run_monit_command("status")
        lines = lines[2..-1]
        rval = {}

        while true do
          # Grab everything before the next empty line
          entry = lines.slice(0, lines.find_index("\n")) 
          break if entry == nil

          # The first line is the type and name for the group of stats
          _, pname = entry.first.split(" ")

          # Strip the ''s from the name
          pname = pname[1..-2]
          pstats = {}

          # Harvest the key value list of stats for this entry
          entry[1..-1].collect {|v|
            key, value = v.strip.split("  ", 2)
            pstats[key] = value.strip
          }

          # Add it to the running list unless it's a system entry
          rval[pname] = pstats unless pname.match(/^system_ip-/)

          # Trim the main list to exlude this entry
          lines = lines[entry.length+1..-1]
          break if lines.length < 2
        end

        reply[:processes] = rval unless request[:name]
        reply[:process] = rval[request[:name]] if request[:name]
      end
    end
  end
end
