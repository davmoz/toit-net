import gpio

main:
  pin := gpio.Pin 21 --output
  pin.set 1
  sleep --ms=1000