module InfluxDB
  module Rails
    module Instrumentation
      def benchmark_for_instrumentation
        start = Time.now
        yield

        unless InfluxDB::Rails.configuration.ignore_current_environment?
          elapsed = ((Time.now - start) * 1000).ceil
          InfluxDB::Rails.client.write_point "instrumentation", {
            values: {
              value: elapsed,
            },
            tags: {
              method: "#{controller_name}##{action_name}",
              server: Socket.gethostname,
              application: InfluxDB::Rails.configuration.application_name
            },
          }
        end
      end

      def write_request_data
        unless InfluxDB::Rails.configuration.ignore_current_environment?
          # From AirTrafficController
          request_data = influx_db_request_data
          tags_keys = [:controller, :action, :current_user]
          values = request_data.except(tag_keys)
          tags = request_data.only(tag_keys).merge(
            server: Socket.gethostname,
            application: InfluxDB::Rails.configuration.application_name)
          InfluxDB::Rails.client.write_point "requests", {
            values: values,
            tags: tags,
          }
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def send_air_traffic(methods)
          methods = [methods] unless methods.is_a?(Array)
          before_filter :write_request_data, :only => methods
        end

        def instrument(methods = [])
          methods = [methods] unless methods.is_a?(Array)
          around_filter :benchmark_for_instrumentation, :only => methods
        end
      end
    end
  end
end
