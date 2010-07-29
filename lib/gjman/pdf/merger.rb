module Gjman
  module PDF
    class Merger < Base
      class << self

        def do(*args)
          opts = args.last.is_a?(Hash) ? args.pop : {}
          default_dest = args[0].sub(/\.pdf$/,'-m.pdf')
          dest = opts.delete(:to) || default_dest
          work(args, dest, default_dest)
        end

        private

          def work(srcs, dest, tmp_dest)
            merge(srcs)
            File.move(tmp_dest, dest) unless dest == tmp_dest
            dest
          end

      end
    end
  end
end
