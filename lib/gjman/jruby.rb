module Gjman
  module JRuby
    class << self

      def initialize
        @initialized ||= (
          include Java
          Gjman::JAVA_LIBS.join(':').split(':').each{|jar| require jar }
          $CLASSPATH << Gjman.root('gjman','java_hacks')
          java_import 'ForbidSystemExit'
          true
        )
      end

      def classify(klass)
        java_import klass
        Java.send(klass)
      end

      def sandbox(&block)
        initialize
        begin
          ForbidSystemExit.apply
          @result = yield
        rescue ForbidSystemExit::Exception
          @result
        ensure
          ForbidSystemExit.unapply
        end
      end

    end
  end
end
