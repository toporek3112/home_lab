package main

import (
	"bytes"
	"fmt"
	"net"
	"os"
)

// sendMagicPacket sends a WOL magic packet to the specified address and port
func sendMagicPacket(macAddress, broadcastIP string, port int) error {
	// Parse the MAC address
	mac, err := net.ParseMAC(macAddress)
	if err != nil {
		return fmt.Errorf("invalid MAC address: %v", err)
	}

	// Create the magic packet
	var packet bytes.Buffer
	// Add 6 bytes of 0xFF
	packet.Write(bytes.Repeat([]byte{0xFF}, 6))
	// Append the MAC address 16 times
	for i := 0; i < 16; i++ {
		packet.Write(mac)
	}

	// Convert packet to bytes
	packetBytes := packet.Bytes()

	// Send the magic packet over UDP
	address := fmt.Sprintf("%s:%d", broadcastIP, port)
	conn, err := net.Dial("udp", address)
	if err != nil {
		return fmt.Errorf("failed to connect to %s: %v", address, err)
	}
	defer conn.Close()

	_, err = conn.Write(packetBytes)
	if err != nil {
		return fmt.Errorf("failed to send magic packet: %v", err)
	}

	fmt.Printf("Magic packet sent to %s via %s:%d\n", macAddress, broadcastIP, port)
	return nil
}

func main() {
	// Command-line arguments: MAC address, broadcast IP, port
	if len(os.Args) != 4 {
		fmt.Printf("Usage: %s <MAC_ADDRESS> <BROADCAST_IP> <PORT>\n", os.Args[0])
		os.Exit(1)
	}

	macAddress := os.Args[1]
	broadcastIP := os.Args[2]
	port := 9 // Default port
	fmt.Sscanf(os.Args[3], "%d", &port)

	err := sendMagicPacket(macAddress, broadcastIP, port)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
		os.Exit(1)
	}
}
