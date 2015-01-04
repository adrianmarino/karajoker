class ::Hash
  
  # add keys to hash
  def to_obj
    self.each do |k,v|
      if v.kind_of? Hash
        v.to_obj
      end
      k=k.gsub(/\.|\s|-|\/|\'/, '_').downcase.to_sym

      ## create and initialize an instance variable for this key/value pair
      self.instance_variable_set("@#{k}", v)

      ## create the getter that returns the instance variable
      self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})

      ## create the setter that sets the instance variable
      self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
    end
    return self
  end
end
