module Elsm
  class Logger
    FATAL = 0
    ERROR = 1
    INFO  = 2
    DEBUG = 3

    def write_msg(level, msg)
      if @level >= Elsm::Logger.const_get(level.strip.upcase)
        puts msg
        #puts "[#{$$}] #{Time.now.utc} #{level.rjust 5}: #{msg}"
      end
    end

    def initialize level
      @level = Elsm::Logger.const_get(level.upcase)
      #@logfile = File.open("tmp/elsm-#{$$}.log", 'w')
    end

    def info msg
      write_msg('INFO', msg)
    end

    def error msg
      write_msg('ERROR', msg)
    end

    def fatal msg
      write_msg('FATAL', msg)
      exit! 1
    end

    def debug msg
      #@logfile.write("#{msg}\n")
      #@logfile.flush
      write_msg('DEBUG', msg)
    end
  end
end
