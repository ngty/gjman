require 'forwardable'

module Gjman
  module PDF
    class Base
      class << self

        extend Forwardable

        def_delegators Utils::PDFC, :diff
        def_delegators Utils::Multivalent, :merge, :compress, :uncompress

      end
    end
  end
end

