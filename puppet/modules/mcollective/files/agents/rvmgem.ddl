metadata    :name        => "RVM gem command wrapper",
            :description => "",
            :author      => "Joshua Bussdieker (josh.bussdieker@moovweb.com)",
            :license     => "MIT",
            :version     => "1.0",
            :url         => "http://github.com/moovweb-operations",
            :timeout     => 300

action "install", :description => "Install a gem" do
end

action "uninstall", :description => "Uninstall a gem" do
end

action "cleanup", :description => "Cleanup old gems" do
end

action "list", :description => "List installed gems" do
    display :always

    output :gems,
           :description => "List of gem names and versions",
           :display_as => "Gems"
end
