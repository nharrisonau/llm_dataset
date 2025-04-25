# llm_dataset

## Encryption Libraries
### OpenSSL - Full-featured SSL/TLS and crypto library
- SSL_library_init / OPENSSL_init_ssl - Library initialization
- SSL_connect / SSL_accept - Perform TLS handshakes
- SSL_read / SSL_write - Encrypted data I/O

### Mbed TLS - Lightweight TLS and crypto library for embedded use
- mbedtls_ssl_init / mbedtls_ssl_setup - Context and session setup
- mbedtls_ssl_handshake - Perform TLS handshake
- mbedtls_ssl_read / mbedtls_ssl_write - Secure I/O functions

### wolfSSL - Compact TLS library optimized for embedded systems
- wolfSSL_Init - Initialize the library
- wolfSSL_connect / wolfSSL_accept - Handshake with peer
- wolfSSL_read / wolfSSL_write - Encrypted data communication

### GnuTLS - GNU TLS/SSL library with support for DTLS
- gnutls_init - Session initialization
- gnutls_handshake - TLS handshake loop
- gnutls_record_recv / gnutls_record_send - Secure data exchange

## Remote Access & Authentication
### Dropbear SSH - Lightweight SSH server/client for embedded Linux
- dropbear_main - Main server logic
- cli_main - SSH client entry point
- Session handlers - Manage auth, I/O, and session lifecycle

### OpenSSH - Full-featured SSH implementation
- main (sshd) - Daemon setup and connection handling
- do_authentication - User login authentication
- server_loop - Manage encrypted session I/O

## Wireless Networking
### hostapd - AP-side Wi-Fi access and authentication service
- main - Configuration and event loop setup
- eloop_run - Core event loop
- hostapd_new_assoc_sta - Handle new station association

### wpa_supplicant - Wi-Fi client and 802.1X supplicant
- wpa_supplicant_main - Daemon entry point
- wpa_sm_step - WPA handshake progression
- wpa_supplicant_event - Event handler for interface events

### BlueZ - Official Linux Bluetooth protocol stack
- main (bluetoothd) - Daemon start, D-Bus/HCI setup
- adapter_start - Initialize Bluetooth adapter
- device_create - Process newly discovered devices

### OpenThread - Thread mesh networking protocol stack
- otInstanceInitSingle - Initialize Thread stack instance
- otThreadStart - Enable Thread protocol
- otTaskletsProcess / otSysProcessDrivers - Main protocol processing loop

### OpenRadar - MIMO radar data acquisition and processing
- open_device - Initialize radar hardware
- Start frame loop - Begin radar data capture
- Process FFT/filtering - Signal transformation and object detection

## Networking Stacks & Protocols
### lwIP - Lightweight TCP/IP stack for embedded systems
- lwip_init - Initialize the TCP/IP stack
- tcpip_thread - Main event/packet handler thread
- tcp_input / etharp_output - Protocol-level packet processing

### uIP - Minimal TCP/IP stack for 8-bit/16-bit MCUs
- uip_init - Stack setup
- uip_input / uip_process - Input processing and timeouts
- uip_periodic - Retransmission/time-driven events

### pppd - Point-to-Point Protocol daemon for link-layer communication
- main - Setup and launch link negotiation
- lcp_fsm_open / ipcp_up - State machine handling for LCP/IPCP
- eap_input / eap_request - Authentication message handling

## System & Network Services
### BusyBox - Embedded suite of Unix utilities
- busybox_main - Dispatcher entry point
- run_applet_by_name - Applet name-based dispatch
- httpd_main / ifconfig_main - Specific utility applet entry points

### dnsmasq - Lightweight DNS and DHCP service
- main - Setup and service loop entry
- receive_query - DNS query handling
- dhcp_packet - DHCP request and response handler

### Samba - SMB/CIFS file sharing for Windows compatibility
- smbd_process - Handle incoming SMB requests
- reply_sesssetup_and_X - Authenticate user sessions
- main (smbd) - Start server, daemonize, spawn workers

### Mosquitto - MQTT message broker for IoT messaging
- main - Initialize broker and event loop
- mosquitto_main_loop - Accept sockets, process MQTT traffic
- handle__publish / handle__subscribe - MQTT PUBLISH/SUBSCRIBE logic

## Operating Systems / RTOS
### FreeRTOS - RTOS kernel for microcontrollers
- vTaskStartScheduler - Start scheduler and context switching
- xTaskCreate - Create new task
- xPortSysTickHandler - Timer tick handler for scheduler

### Zephyr OS - Modular RTOS for resource-constrained devices
- z_cstart - Kernel and thread system initialization
- main (user task) - First user-space thread
- z_clock_announce - Tick event for kernel scheduling

## VPN & Security Protocols
### OpenVPN - SSL-based VPN implementation
- main / openvpn_main - Config parsing and startup
- process_buffers / tls_process - Encrypted channel handling
- open_tun / do_close_tun - Tunnel interface setup/teardown

### strongSwan - Modular IPsec VPN solution
- charon_main - IKE daemon startup
- ike_sa_init / ike_auth - IKE handshake and authentication
- create_child_sa - Create IPsec data tunnel