module Gjman
  module PDF
    module Utils
      module PDFC

        class NotSupportedServiceError < Exception ; end

        SERVICE = 'com.inet.pdfc.PDFC'
        JARS = %w{CCLib log4j-1.2.15 PDFC PDFParser}.map{|n| Gjman.root('java','pdfc',"#{n}.jar") }.join(':')
        Gjman::JAVA_LIBS << JARS

        module JRuby
          def method_missing(mode, *args)
            Gjman::JRuby.sandbox do
              service, args = extract_args(mode, args)
              Gjman::JRuby.classify(service).main(args.split(' '))
            end
          end
        end

        module Rjb
          def method_missing(mode, *args)
            Gjman::Rjb.sandbox do
              service, args = extract_args(mode, args)
              Gjman::Rjb.classify(service).main(args.split(' '))
            end
          end
        end

        module Shell
          def method_missing(mode, *args)
            service, args = extract_args(mode, args)
            @cmd ||= 'java -cp %s %s' % [JARS, service]
            %x|#{@cmd} #{args} 2>&1|
          end
        end

        def self.extract_args(mode, args)
          raise NotSupportedServiceError unless mode == :diff
          [
            service,
            [args].flatten.compact.join(' ')
          ]
        end

        extend const_get(Gjman::JAVA_MODE)

      end
    end
  end
end

