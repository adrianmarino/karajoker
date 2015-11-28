class ::Hash
  def to_obj
    each do |k, v|
      v.to_obj if v.kind_of?(Hash)

      # rubocop:disable all
      k = k.gsub(%r{.|s|-|/|'}, '_').downcase.to_sym
      # rubocop:enable all

      ## create and initialize an instance variable for this key/value pair
      nstance_variable_set("@#{k}", v)

      ## create the getter that returns the instance variable
      self.class.send(:define_method, k, proc { instance_variable_get("@#{k}") })

      ## create the setter that sets the instance variable
      self.class.send(:define_method, "#{k}=", proc { |v| instance_variable_set("@#{k}", v) })
    end
    self
  end
end
