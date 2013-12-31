class Stat
  attr_accessor :name, :value
  
  def initialize(data)
    @name = data['name']
    @value = if data.has_key? 'value'
      data['value']
    else
      data['count']
    end
  end
end