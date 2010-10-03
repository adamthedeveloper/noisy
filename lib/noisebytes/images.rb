module Images
  class S3
    attr_accessor :configuration

    def initialize(options = { :yml_file => Rails.root.join('config','amazon_s3.yml'), :settings_key => 'default' })
      @configuration = YAML::load_file(options[:yml_file])
      @configuration.merge!(@configuration[options[:settings_key]])
      @configuration['bucket'] = @configuration['s3_credentials'][Rails.env]['bucket']
      symbolize_all_keys @configuration
    end

    def symbolize_all_keys(hash)
      hash.symbolize_keys!
      hash.each { |k,v| symbolize_all_keys v if v.is_a? Hash }
    end
  end
end