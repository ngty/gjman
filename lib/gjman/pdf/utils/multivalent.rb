module Gjman
  module PDF
    module Utils
      module Multivalent

        class NotSupportedServiceError < Exception ; end

        JARS = Gjman.root('java', 'multivalent', 'Multivalent20060102.jar')
        Gjman::JAVA_LIBS << JARS

        SERVICES = {
          :compress   => %w{tool.pdf.Compress},
          :uncompress => %w{tool.pdf.Uncompress},
          :merge      => %w{tool.pdf.Merge},
          :fonts      => %w{tool.doc.ExtractText --output xml --style},
          :images     => %w{tool.pdf.Info --images},
        }

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
            @cmd ||= 'java -cp %s' % JARS
            %x|#{@cmd} #{service} #{args} 2>&1|
          end
        end

        def self.extract_args(mode, args)
          (service_args = SERVICES[mode]) or raise NotSupportedServiceError
          [
            service_args[0],
            [service_args[1..-1], args].flatten.compact.join(' ')
          ]
        end

        extend const_get(Gjman::JAVA_MODE)

      end
    end
  end
end
