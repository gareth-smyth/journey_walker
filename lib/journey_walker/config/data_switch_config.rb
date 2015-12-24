module JourneyWalker
  module Config
    # Data switch definition
    #   source: The name of the data source
    #   method: The method to call on the data source
    #   value: The value which should match the response from the data source method to count as true
    class DataSwitchConfig
      attr_reader :value, :source_call

      def initialize(value, source_call)
        @value = value
        @source_call = source_call
      end
    end
  end
end
