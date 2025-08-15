def.ext sol_print_int(int Int)
def.ext sol_print_bytes(byte_ptr BytePtr, int Int)

def.ext sol_perror(byte_ptr BytePtr)
def.ext exit(code Int32)

def.ext sol_malloc_struct(name Str) -> BytePtr
def.ext sol_listen(sol_tcp_server TcpServer)
def.ext sol_poll(sol_tcp_server TcpServer)
def.ext sol_check_events(sol_tcp_server TcpServer, sol_tcp_events TcpEvents)
def.ext sol_tcp_connection_buffer(sol_tcp_connection TcpConnection, str Str)

class Str
   @buffer     BytePtr
   @length     Int
   @max_length Int
end

def print(str Str)
   sol_print_bytes(str.buffer, str.length)
end

class Function
   def fn_ref
   end
end

class TcpEvents
   @tcp_data_received_fn FnRef
end

class TcpListener
end

class IoPoll
end

class IoEvents
end

class IoConnections
end

class IoBuffers
end

class TcpServer
   @host         Str
   @port         Str
   @tcp_listener TcpListener
   @poll         IoPoll
   @events       IoEvents
   @connections  IoConnections
   @buffers      IoBuffers
   @conn_id      Int
end

class TcpConnection
   def write(str Str)
      sol_tcp_connection_buffer(self, str)
   end
end

class HttpServer
   @host         Str
   @port         Str
   @tcp_listener TcpListener
   @poll         IoPoll
   @events       IoEvents
   @connections  IoConnections
   @buffers      IoBuffers
   @conn_id      Int

   def.class build(host Str, port Str) -> HttpServer
      -> HttpServer.new(
         "127.0.0.1",
         "7878",
         sol_malloc_struct("TcpListener"),
         sol_malloc_struct("IoPoll"),
         sol_malloc_struct("IoEvents"),
         sol_malloc_struct("IoConnections"),
         sol_malloc_struct("IoBuffers"),
         0
      )
   end

   def listen
      sol_listen(self)
   end

   def poll
      sol_poll(self)
   end

   def check_events(tcp_events TcpEvents)
      sol_check_events(self, tcp_events)
   end
end


def main
   server = HttpServer.build("127.0.0.1", "7878")

   server.listen()
   print("Pajama: Server listening on 127.0.0.1:7878")

   event_handlers = TcpEvents.new(tcp_data_received.fn_ref())

   loop {
      server.poll()
      server.check_events(event_handlers)
   }
end

def tcp_data_received(conn TcpConnection, request_data Str)
   conn.write("HTTP/1.1 200 OK\r\n")
   conn.write("Content-Length: 13\r\n")
   conn.write("Connection: keep-alive\r\n\r\n")
   conn.write("Haalo, world!")
end


# Experimental syntax below

def inferred_return_value(arg Str) ->
  -> "infers a string"
end
