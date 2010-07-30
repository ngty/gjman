module Gjman
  module Rjb
    class << self

      def initialize
        @initialized ||= (
          ::Rjb::load([Gjman::JAVA_LIBS, Gjman.root('gjman','java_hacks')].flatten.join(':'))
          @forbid_system_exit = classify('ForbidSystemExit')
          @forbid_system_exit_error = @forbid_system_exit.class.const_get(:Exception)
          true
        )
      end

      def classify(klass)
        ::Rjb.import(klass)
      end

      def sandbox(&block)
        initialize
        begin
          @forbid_system_exit.apply
          @result = yield
        rescue @forbid_system_exit_error
          @result
        ensure
          @forbid_system_exit.unapply
        end
      end

    end
  end
end
