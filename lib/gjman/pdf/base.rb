require 'forwardable'

module Gjman
  module PDF
    class Base
      class << self

        extend Forwardable

        def_delegators Utils::PDFC, :same_contents?
        def_delegators Utils::Multivalent, :merge, :compress, :uncompress, :fonts, :same_fonts?

      end
    end
  end
end

