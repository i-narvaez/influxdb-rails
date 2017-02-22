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
          request_data = influxdb_request_data
          values = clean_influx_params(request_data.except(:controller, :action, :current_user))
          tags = request_data.slice(:controller, :action, :current_user).merge(
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

      private

      def clean_influx_params(influx_params)
        influx_params.each do |k, v|
          v.delete!("^\u{0000}-\u{007F}") if v.is_a? String
          influx_params[k] = v.to_json if v.is_a? Hash
          influx_params.delete(k) if v.nil?
        end
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
