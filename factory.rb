class Factory
  class << self
    def new(*args, &block)
      Class.new do
        attr_accessor(*args)
        define_method(:initialize) do |*data|
          args.each { |argument| __send__("#{argument}=", data.shift) }
        end
        define_method(:[]) do |field|
          send_param = field.is_a?(Integer) ? args[field] : field
          __send__(send_param)
        end
        class_eval(&block) if block_given?
      end
    end
  end
end

Player = Factory.new(:name, :team, :number) do
  def greeting
    "Hello #{name}!"
  end
end

zlatan = Player.new('Zlatan Ibrahimovic', 'Manchester United', 9)

puts zlatan.name
puts zlatan['name']
puts zlatan[:name]
puts zlatan[0]

puts Player.new('Zlatan Ibrahimovic', 'Manchester United', 9).greeting
