module Gjman
  module PDF
    module Utils
      module Multivalent

        class NotSupportedActionError < Exception ; end

        module JRuby
        end

        module Rjb
        end

        # Most inefficient processor !!
        module Shell

          CMD = 'java -cp %s' % Gjman.root('java', 'multivalent', 'Multivalent20060102.jar')

          ACTIONS = {
            :compress   => 'tool.pdf.Compress',
            :uncompress => 'tool.pdf.Uncompress',
            :merge      => 'tool.pdf.Merge',
            :fonts      => 'tool.doc.ExtractText --output xml --style',
            :images     => 'tool.pdf.Info --images',
          }

          def method_missing(mode, args)
            action, args = ACTIONS[mode], [args].flatten.join(' ')
            raise NotSupportedModeError unless action
            %x|#{CMD} #{action} #{args} 2>&1|
          end

        end

        extend const_get(Gjman::JPROCESSOR)

      end
    end
  end
end
