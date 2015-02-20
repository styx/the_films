module ViewContext
  attr_accessor :output_buffer

  def output_buffer_with_sprockets=(buffer)
    if is_sprockets?
      @output_buffer = buffer
    else
      output_buffer_without_sprockets=(buffer)
    end
  end

  def is_sprockets?
    self.try(:environment).class == Sprockets::Index
  end

  def protect_against_forgery?
    false
  end

  def self.included(klass)
    klass.instance_eval do
      alias_method_chain :output_buffer=, :sprockets
    end
  end
end
