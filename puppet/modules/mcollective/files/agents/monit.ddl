metadata    :name        => "Monit Agent",
            :description => "",
            :author      => "Joshua Bussdieker (josh.bussdieker@moovweb.com)",
            :license     => "MIT",
            :version     => "1.0",
            :url         => "http://github.com/moovweb-operations",
            :timeout     => 300

action "start", :description => "Start a process" do
end

action "stop", :description => "Stop a process" do
end

action "status", :description => "Get the status of a process" do
    display :always

    output :processes,
           :description => "List of processes and statuses",
           :display_as => "Processes"

    output :process,
           :description => "Process status",
           :display_as => "Process"
end

action "summary", :description => "Summary of processes" do
    display :always

    output :processes,
           :description => "List of processes and statuses",
           :display_as => "Processes"
end
