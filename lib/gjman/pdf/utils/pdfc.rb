module Gjman
  module PDF
    module Utils
      module PDFC

        class NotSupportedServiceError < Exception ; end

        SERVICE = 'com.inet.pdfc.PDFC'
        JARS = %w{CCLib log4j-1.2.15 PDFC PDFParser}.map{|n| Gjman.root('java','pdfc',"#{n}.jar") }.join(':')
        Gjman::JARS << JARS

        module JRuby
        end

        module Rjb
          def method_missing(mode, *args)
            service, args = extract_args(mode, args)
            Gjman.rjb_load
            # TODO:
            # * need to confirm if setting this helps: export LD_LIBRARY_PATH=/opt/java/jre/lib/amd64
            # * need to prevent java from calling system exit the following code
            ::Rjb.import(service).main(args.split(' '))
          end
        end

        # Most inefficient processor !!
        module Shell
          def method_missing(mode, *args)
            service, args = extract_args(mode, args)
            @cmd ||= 'java -cp %s %s' % [JARS, service]
            %x|#{@cmd} #{args} 2>&1|
          end
        end

        def self.extract_args(mode, args)
          raise NotSupportedServiceError unless mode == :diff
          [SERVICE, [args].flatten.compact.join(' ')]
        end

        extend const_get(Gjman::JMODE)

      end
    end
  end
end

