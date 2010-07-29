module Gjman
  module PDF
    module Utils
      module Multivalent

        class NotSupportedActionError < Exception ; end

        class << self

          SHELL_CMD = 'java -cp %s' % Gjman.root('java', 'multivalent', 'Multivalent20060102.jar')

          ACTIONS = {
            :compress   => 'tool.pdf.Compress',
            :uncompress => 'tool.pdf.Uncompress',
            :merge      => 'tool.pdf.Merge'
          }

          def method_missing(mode, args)
            action, args = ACTIONS[mode], [args].flatten.join(' ')
            raise NotSupportedModeError unless action
            %x|#{SHELL_CMD} #{action} #{args} 2>&1|
          end

        end
      end
    end
  end
end
