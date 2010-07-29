module Gjman
  module PDF
    module Utils
      module Multivalent

        class NotSupportedServiceError < Exception ; end

        JARS = Gjman.root('java', 'multivalent', 'Multivalent20060102.jar')
        Gjman::JARS << JARS
        SERVICES = {
          :compress   => %w{tool.pdf.Compress},
          :uncompress => %w{tool.pdf.Uncompress},
          :merge      => %w{tool.pdf.Merge},
          :fonts      => %w{tool.doc.ExtractText --output xml --style},
          :images     => %w{tool.pdf.Info --images},
        }

        module JRuby
        end

        module Rjb
          def method_missing(mode, *args)
            service, args = extract_args(mode, args)
            Gjman.rjb_load
            # * need to confirm if setting this helps: export LD_LIBRARY_PATH=/opt/java/jre/lib/amd64
            # * need to prevent java from calling system exit the following code
            ::Rjb.import(service).main(args.split(' '))
          end
        end

        # Most inefficient processor !!
        module Shell
          def method_missing(mode, *args)
            service, args = extract_args(mode, args)
            @cmd ||= 'java -cp %s' % JARS
            %x|#{@cmd} #{service} #{args} 2>&1|
          end
        end

        def self.extract_args(mode, args)
          (service = SERVICES[mode]) or raise NotSupportedServiceError
          [service[0], [service[1..-1], args].flatten.compact.join(' ')]
        end

        extend const_get(Gjman::JMODE)

      end
    end
  end
end
