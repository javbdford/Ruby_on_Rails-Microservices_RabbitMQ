#frozen_string_literal: true

class BunnyClient
  class << self

    # Connect
    def connect!
      @connection = Bunny.new(ENV['PORT2'])
      @connection.start

      # Create Channel 
      @channel = @connection.create_channel
      #Start Fanout
      @fan_out = @channel.fanout('aceleracao_dio_users.out')
      @connected = true
    end

    # Publish the message
    def push(payload, type)
      connect! unless @connected
      @fan_out.publish(payload, { app_id: 'aceleracao_dio_users', type: type })

      true
    end
  end
end