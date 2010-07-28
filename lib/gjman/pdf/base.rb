module Gjman
  module PDF
    class Base
      class << self

        CLASS_PATHS = {
          :multivalent => Gjman.root('java', 'multivalent', 'Multivalent20060102.jar'),
          :pdfc => %w{
            CCLib log4j-1.2.15 PDFC PDFParser
          }.map{|name| Gjman.root('java', 'pdfc', "#{name}.jar") }.join(':')
        }

        def java(mode, args)
          class_path = CLASS_PATHS[mode]
          %x|java -cp #{class_path} #{[args].flatten.join(' ')} 2>&1|
        end

        def shell(cmd, args)
          %x|#{cmd} #{[args].flatten.join(' ')} 2>&1|
        end

      end
    end
  end
end

