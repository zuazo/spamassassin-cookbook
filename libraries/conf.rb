
module Onddo
  module SpamAssassin
    module Conf

      def self.value(v)
        if v.kind_of?(TrueClass)
          '1'
        elsif v.kind_of?(FalseClass)
          '0'
        else
          v.to_s
        end
      end

    end
  end
end

