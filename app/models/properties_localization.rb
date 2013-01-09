module PropertiesLocalization

  def self.included klass
    @klass = klass
  end

  def self.localize_properties(properties)
    RapidFTR::Application::LOCALES.each do |locale|
      properties.each {|key| @klass.property "#{key}_#{locale}"}
    end

    properties.each do |method|
      define_method method do |*args|
        locale = args.first || I18n.locale
        self.send("#{method}_#{locale}") || self.send("#{method}_#{I18n.default_locale}")
      end

      define_method "#{method}=" do |value|
        self.send("#{method}_#{I18n.default_locale}=",value)
      end
    end

  end
end