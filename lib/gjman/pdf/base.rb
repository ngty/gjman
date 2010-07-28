module Gjman
  module PDF
    class Base
      class << self

        JLIB_ARGS = {
          # --
          :multivalent => '-cp %s' % Gjman.root('java', 'multivalent', 'Multivalent20060102.jar'),
          # --
          :pdfc => '-cp %s com.inet.pdfc.PDFC' % %w{CCLib log4j-1.2.15 PDFC PDFParser}.
            map{|name| Gjman.root('java', 'pdfc', "#{name}.jar") }.join(':')
        }

        def java(mode, args)
          %x|java #{JLIB_ARGS[mode]} #{[args].flatten.join(' ')} 2>&1|
        end

        def shell(cmd, args)
          %x|#{cmd} #{[args].flatten.join(' ')} 2>&1|
        end

      end
    end
  end
end

