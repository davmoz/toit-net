import net
import net.tcp
import gpio

ADDR := "46.101.174.243"
PORT_SERVER := 4545
DEVICE_ID := "983777445"

main:
    
    // task:: sleep --ms=100; send_heartbeat // Delay start of task by 100ms
    task:: send_heartbeat

send_heartbeat:

    pin := gpio.Pin 2 --output
    pin.set 1

    network := net.open

    server_address := net.SocketAddress (network.resolve ADDR)[0] PORT_SERVER
    tcp_socket := network.tcp_connect server_address

    msg := DEVICE_ID.to_byte_array
    tcp_socket.write msg

    while true:
        // print "waiting for incoming TCP on $tcp_socket.local_address
        val := tcp_socket.read
        if val:
            msg_in := val.to_string_non_throwing
            print "TCP Received: $msg_in (msg size: $msg_in.size)"
            if (msg_in == "0"):
                print "Yes, 0"
                pin.set 0
                sleep --ms=5000
            pin.set 1
            
            