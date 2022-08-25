import net
import net.udp

ADDR := "46.101.174.243"
PORT_SERVER := 4445

main:
  task:: send_heartbeat

send_heartbeat:
  network := net.open
  udp_socket := network.udp_open --port=4440
  server_address := net.SocketAddress (network.resolve ADDR)[0] PORT_SERVER
  udp_socket.connect server_address

  msg := udp.Datagram "1".to_byte_array server_address
  udp_socket.send msg

  // print "waiting for incoming udp on $udp_socket.local_address"
  // print udp_socket.receive.data
  // print "Received in send hearbeat"