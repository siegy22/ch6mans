module Discord
  module Commands
    class Base
      def name
        self.class.name.demodulize.underscore
      end

      def meta
        self.class::META
      end
    end
  end
end
