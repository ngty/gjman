module Gjman
  module PDF
    module Utils
      module PDFC

        class NotSupportedModeError < Exception ; end

        module JRuby
        end

        module Rjb
        end

        # Most inefficient processor !!
        module Shell

          CMD = 'java -cp %s com.inet.pdfc.PDFC' % %w{CCLib log4j-1.2.15 PDFC PDFParser}.
            map{|name| Gjman.root('java', 'pdfc', "#{name}.jar") }.join(':')

          def method_missing(mode, *args)
            args = [args].flatten.join(' ')
            raise NotSupportedActionError unless mode == :diff
            %x|#{CMD} #{args} 2>&1|
          end

        end

        extend const_get(Gjman::JPROCESSOR)

      end
    end
  end
end

