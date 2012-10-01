class ElsmApp
  class Node
    attr_accessor :logger

    def initialize(server, logger)
      @server = server
      @logger = logger
    end

    def instance_info
      logger.info "#{@server.id} - #{@server.tags["type"]} - #{@server.status}"
      logger.info " * Master DNS: #{@server.tags["master"]}"
      logger.info " * Public DNS: #{@server.public_dns_name}"
      logger.info " * Private DNS: #{@server.private_dns_name}"
    end

    def wait_ready
      logger.info "Waiting for SSH..."
      if !@server.wait_port(22)
        logger.fatal "Timed out waiting for SSH"
      end

      logger.info "Waiting for cloud init to finish..."
      if !@server.wait_cloud_init
        logger.fatal "Timed out waiting for cloud init"
      end
    end

    def install_package(package)
      logger.info "Installing #{package}..."
      if @server.run_cmd("sudo apt-get -y -q install #{package}") != 0
        logger.fatal "Error installing #{package}"
      end
    end

    def upload_puppet_settings
      logger.info "Uploading puppet settings..."
      if @server.scp_to("puppet", "") != 0
        logger.fatal "Error uploading puppet settings"
      end
    end

    def install_modules
      logger.info "Installing puppet modules..."
      if @server.run_cmd("sudo rm -rf /etc/puppet/manifests && sudo cp -r puppet/manifests /etc/puppet") != 0 
        logger.fatal "Error installing puppet manifests"
      end
      if @server.run_cmd("sudo rm -rf /etc/puppet/modules && sudo cp -r puppet/modules /etc/puppet") != 0 
        logger.fatal "Error installing puppet modules"
      end
    end

    def install_manifests
      logger.info "Installing puppet manifests..."
      if @server.run_cmd("sudo rm -rf /etc/puppet && sudo cp -r puppet /etc") != 0 
        logger.fatal "Error installing puppet manifests"
      end
    end

    def stop_service(service)
      logger.info "Stopping #{service}..."
      if @server.run_cmd("sudo service #{service} stop") != 0
        logger.fatal "Error stopping #{service}"
      end
    end

    def restart_service(service)
      logger.info "Restarting #{service}..."
      if @server.run_cmd("sudo service #{service} restart") != 0
        logger.fatal "Error restarting #{service}"
      end
    end

    def write_facts(type, master=nil)
      master = @server.private_dns_name if !master

      logger.info "Writing facts..."
      if !@server.write_facts(type, master)
        logger.fatal "Error installing puppet"
      end
    end

    def add_puppet_source
      logger.info "Adding puppet sources..."

      if @server.run_cmd("wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb") != 0
        logger.fatal "Error downloading puppet sources"
      end
      if @server.run_cmd("sudo dpkg -i puppetlabs-release-precise.deb") != 0
        logger.fatal "Error installing puppet sources"
      end
      if @server.run_cmd("sudo apt-get update") != 0
        logger.fatal "Error updating apt sources"
      end
    end

    def run_puppet
      logger.info "Running puppet..."
      result = @server.run_cmd("sudo puppet agent --test --server #{@server.tags["master"]}") do |line|
        logger.debug line.rstrip
      end
      if result == 0
        logger.info "No changes"
      elsif result == 1
        logger.fatal "Error running puppet"
      elsif result == 2
        logger.info "Changes made"
      else
        p result
        logger.fatal "Error running puppet"
      end
    end
  end
end
