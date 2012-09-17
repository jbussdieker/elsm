$:.unshift File.dirname(__FILE__)

require 'elsm'
require 'app/node'
require 'yaml'

class ElsmApp
  attr_accessor :logger

  def read_config(filename)
    if File.exists? filename
      puts "Reading config from #{filename}"
      YAML::load(File.open(filename))
    else
      puts "No config found #{filename}"
      {}
    end
  end

  def initialize(options={})
    provider = options[:provider] || :aws
    log_level = options[:log_level] || :info
    @config = {}
    @config.merge! read_config("/etc/elsm.yml")
    @config.merge! read_config("~/.elsm.yml")
    @config.merge! read_config("config/elsm.yml")
    @logger = Elsm::Logger.new(log_level)
    @compute = Elsm::Compute.new(provider, @config[provider])
  end

  def instance_list
    @compute.servers.each do |server|
      ElsmApp::Node.new(server, logger).instance_info
      #logger.info "#{server.id} - #{server.security_groups.first.name} - #{server.status}"
      #logger.info "  Public DNS: #{server.public_dns_name}"
      #logger.info "  Private DNS: #{server.private_dns_name}"
    end
  end

  def create_node(type, master)
    logger.info "Creating instance..."

    template = @config[:aws][:templates][type.to_sym]
    @server = @compute.new(template)
    if !@server
      logger.fatal "Failed to create instance"
    end

    logger.info "Waiting for instance to startup..."
    if !@server.wait_ready
      logger.fatal "Timed out waiting for startup"
    end

    ElsmApp::Node.new(@server, logger)
  end

  def find_node id
    logger.info "Finding instance..."
    @server = @compute[id]
    if !@server
      logger.fatal "Failed to find instance"
    end

    ElsmApp::Node.new(@server, logger)
  end

  def find_or_create_node(type, id, master=nil)
    if !id
      create_node(type, master)
    else
      find_node(id)
    end
  end
end
