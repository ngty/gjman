module Gjman
  module PDF
    module Utils
      module PDFC

        class NotSupportedModeError < Exception ; end

        class << self

          SHELL_CMD = 'java -cp %s com.inet.pdfc.PDFC' % %w{CCLib log4j-1.2.15 PDFC PDFParser}.
            map{|name| Gjman.root('java', 'pdfc', "#{name}.jar") }.join(':')

          def method_missing(mode, args)
            args = [args].flatten.join(' ')
            raise NotSupportedActionError unless mode == :diff
            %x|#{SHELL_CMD} #{args} 2>&1|
          end

        end
      end
    end
  end
end

