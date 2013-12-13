class Stat
  attr_accessor :id, :name, :value
  
  def initialize(data)
    @id = data['id']
    @name = data['name']
    @value = if data.has_key? 'value'
      data['value']
    else
      data['count']
    end
  end
end