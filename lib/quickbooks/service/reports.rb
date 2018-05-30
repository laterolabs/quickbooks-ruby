# Docs: https://developer.intuit.com/docs/0100_accounting/0400_references/reports
module Quickbooks
  module Service
    class Reports < BaseService

      def url_for_query(which_report = 'BalanceSheet', date_macro = nil, options = {})
        date_macro_string = date_macro && "date_macro=#{URI.encode_www_form_component(date_macro)}"
        query_params_array = options.map { |key, value| "#{key}=#{URI.encode_www_form_component(value)}" }
        query_params_array.unshift(date_macro_string) if date_macro_string
        query_string = query_params_array.length > 0 ? "?#{query_params_array.join('&')}" : ''
        "#{url_for_base}/reports/#{which_report}#{query_string}"
      end

      def query(object_query = 'BalanceSheet', date_macro = 'This Fiscal Year-to-date', options = {})
        do_http_get(url_for_query(object_query, date_macro, options))
        model.new(:xml => @last_response_xml)
      end

      private

      def model
        Quickbooks::Model::Report
      end

    end
  end
end
