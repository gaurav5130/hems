module ModelHooks
  extend ActiveSupport::Concern

  included do
    before_validation :upcase_attributes
    before_validation :downcase_attributes
  end

  def upcase_attributes
    if defined? self.upcase_attrs
       self.attributes.each do |attr,val|
         # if the attribute only has spaces, then this will store nil in the DB
         self.send("#{attr}=",val.strip.upcase) if self.upcase_attrs.include?(attr) && !val.nil?
       end
    end
  end

  def downcase_attributes
    if defined? self.downcase_attrs
       self.attributes.each do |attr,val|
         # if the attribute only has spaces, then this will store nil in the DB
         self.send("#{attr}=",val.strip.downcase) if self.downcase_attrs.include?(attr) && !val.nil?
       end
    end
  end
end