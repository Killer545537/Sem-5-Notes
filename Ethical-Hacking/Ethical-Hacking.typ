#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

#show: ilm.with(
  title: [Ethical Hacking],
  author: "Indranil Sengupta",
  abstract: [
    Remember to complete all the fucking assignments
  ],
)

= Week One

== Introduction to Ethical Hacking

#definition[Ethical Hacking][
  It refers to the act of locating weaknesses and vulnerabilities of computers and information systems by replicating the intent and actions of malicious hackers.\
  It is also called as penetration testing, intrusion testing or red teaming.
]
*Ethical Hackers* are employed by companies to perform penetration tests.\
A *Penetration Test* is a *legal* attempt to break into a company's network to find the weak links. It involves generating a report with all the vulnerabilities but does not provide solutions.\
A *Security Test* also includes analyzing a company's security policy and procedures but the tester offers solutions to secure or protect the network.

Some common terminologies are:
- *Cracking* refers to breaching security on software or systems
- *Spoofing* is faking the originating IP address in a datagram#footnote[It is a self-contained packet of data sent across a network without guaranteed delivery.]
- *Denial of Service (DoS)* is an attack which involves flooding a host with sufficient network traffic so that it cannot respond anymore
- *Port Scanning* is the process of probing a computer or network for open communication ports

Some methods to gain access are:
- *Front Door* refers to the intended methods for entry, these involve password guessing and stealing
- *Back Door* refers to any method that allows someone entry without going through the usual security checks, these involve abusing test accounts or debug/diagnostic tools
- *Trojan Horse* is a malware which installs back doors into a system. These disguise themselves as legitimate programs
- *Software Vulnerability Exploitation* is often advertised on the OEMs website along with security patches

Some things a hacker once inside can do are:
- *Modify Logs* thus covering their tracks
- *Steal files* which are important and then delete them while covering their tracks
- *Modify files*
- *Install backdoors*
- *Attack other systems*

Some penetration testing methodologies are:
- *Tiger Box* is a computer loaded with hacking tools for penetration testing and security assessments
- *White/Glass Box Model* is when the tester has full knowledge of the target system including source code, network diagrams, etc
- *Black Box Model* is when the tester has no information about the network
- *Gray Box Model* is when the tester has partial information about the network.

== Basic Concepts of Networking

#definition[Computer Network][
  It is a communication system that connects devices to share resources and information. It allows for diverse devices, resource sharing and connectivity.
]
Some types of networks are:
- *Local Area Network* is used to connect hosts within a relatively small geographical area, i.e. in the same building. It is faster and cheaper.
- *Wide Area Network* is used to connect hosts which are widely dispersed, i.e. across campuses or cities. It is slower and expensive.

Data is sent over a network via one of two approaches:
- *Circuit Switching* is a method of communication where a dedicated path is established between two nodes for the duration of their connection. It requires 3 steps for communication, Connection Establishment, Data Transfer and Connection Termination. However, the channel capacity is dedicated during the entire duration of the communication#footnote[Inefficient for bursty traffic like data] and there is initial delay due to connection establishment.
- *Packet Switching* is a communication method where data is broken into packets and sent independently across a shared network. This is a more modern approach where network resources are not dedicated and a link can be shared. The data is transmitted in small packets#footnote[A longer message is broken into packets each with sizes in Kilobytes] containing a header with relevant information about routing, etc. It is based on store-and-forward concept. Each intermediate node (router) maintains a routing table. It is more suitable for computer-generated (bursty) traffic, buffering and data rate conversion can be performed easily and packets can be given priority. #footnote[An old approach to this which is not used is the Virtual Circuit Approach. Here a *Call Request* packet is sent from source to destination and a *Call Accept* packet return back. It also follows a store-and-forward concept]
The widely used method for packet switching is the datagram approach. Here, no route is established beforehand and each packet is treated as an independent entity and can take any route to the destination. However, this means that the packets may arrive out of order, any node crash will result in loss of all queued packets and duplicate packets may be generated. It is faster than the virtual circuit approach, flexible and can handle congestion/failed link since packets follow different paths.

Some types of delays are:
- *Propagation Delay* is the time taken by a data signal to propagate from one node to the next
- *Transmission Time* is the time taken to send out a packet by the transmitter
- *Processing Delay* is the time taken by a node to process a packet

*Layered Network Architecture* divides networking into distinct layers, each with specific responsibilities.
#definition[OSI Model][
  The OSI Model (Open Systems Interconnection Model) is a conceptual model developed by the International Organization for Standardization (ISO) to standardize the functions of a communication system or network. It divides the process of network communication into seven distinct layers, each with specific roles and responsibilities. The 7 layers are#footnote[The first 3 are point-to-point, meaning each node contains these and the rest are host-to-host, meaning only the source and destination]:
  #columns(2)[
    - Physical
    - Data Link
    - Network
    #colbreak()
    - Transport
    - Session
    - Presentation
    - Application#footnote[Closest to end user]
  ]
]
The following is an introduction to each layer:
- *Physical Layer* transmits raw bit stream over a physical layer
- *Data Link Layer* guarantees reliable transfer of frames over a point-to-point link (flow-control, error-control)
- *Network Link* establishes, maintains and terminates connections and routes packets through point-to-point links
- *Transport Layer* ensures reliable, end-to-end communication between devices on a network
- *Session Layer* manages and controls the dialog (sessions) between two computers in a network
- *Presentation Layer* formats, encrypts, and translates data for the application layer above it
- *Application Layer* provides network services directly to end-user applications
#figure(
  image("imgs/Data-Flow.png"),
  caption: [
    Stack like flow of data
  ]
)
Some inter-networking devices are:
- *Hub* is a basic networking device that connects multiple computers in a network and transmits data to all connected devices. It is used to extend the span of a single LAN
- *Switch* is a network device that connects devices and intelligently forwards data only to the intended recipient
- *Bridge/Layer-2 Switch* is a network device that connects and filters traffic between two or more network segments at the data link layer. It is used to connect two or more LANs together. It works at the data link layer
- *Router/Layer-3 Switch* is a network device that directs data packets between different networks, choosing the best path for each packet. It is used to connect any combination of LANs and WANs. It works at the network layer
#figure(
  image("imgs/Internetworking-Structure.png"),
  caption: [
    Typical Inter-Networking Structure
  ]
)

== TCP/IP Protocol Stack

*TCP/IP#footnote[Funded by US military, started in 1970s] (Transmission Control Protocol/Internet Protocol)* is the foundational set of communication protocols that powers the internet, enabling devices to connect and exchange data globally. It acts as a common language for computers and thus, bridges the gap between non-compatible platforms.\
Instead of a 7-layer OSI model, it uses a simplified 4-layer model,
#figure(
  image("imgs/TCP:IP-Layers.png", height: 20%, fit: "contain"),
  caption: [
    Simplified 4-layer TCP/IP Model
  ]
)
- *Application Layer* handles high-level protocols, representation, encoding, and dialog control (e.g., HTTP, FTP, SMTP)
- *Transport Layer* manages end-to-end communication and data flow (mainly TCP and UDP)
- *Network Layer* responsible for routing packets across networks (primarily the IP protocol)
- *Link Layer* deals with the physical transmission of data (e.g., Ethernet)

The *TCP/IP Protocol Suite* refers to a family of network protocols that enable internet communication. The data is sent from one node to the other as a sequence of datagrams, where each datagram is sent independently taking different routes with no guarantee of delivery.

Some common protocols in the network layer are:
- *Address Resolution Protocol (ARP)* maps IP addresses to hardware (MAC) addresses
- *Reverse Address Resolution Protocol (RARP)* maps hardware addresses to IP addresses
- *Internet Control Message Protocol (ICMP)* sends error messages and operational information in IP networks
- *Internet Group Management Protocol (IGMP)* manages multicast group memberships in IP networks

#definition[Internet Protocol][
  IP is a core network protocol that routes data packets across interconnected networks. It is responsible for packet routing, fragmentation and best-effort delivery.
]
#definition[Transmission Control Protocol][
  It is a reliable, connection-oriented transport protocol that ensures data is delivered accurately and in order. It is responsible for connection establishment, splitting a message into packets, resending packets lost in transit and reassembling packets at destination.
]
#definition[User Datagram Protocol][
  It is a fast, connectionless transport protocol that sends data without guaranteeing delivery or order. It is generally used for smaller messages that fit into a packet, but is unreliable and has no error control. It is faster and simpler than TCP.
]

Encapsulation is the process of adding headers/trailers to data as it moves down the protocol stack. As data moves from the application layer to the physical layer, each layer adds its own control information in the form of headers/trailers and these headers/trailers are stripped as data moves up.
#figure(
  image("imgs/Encapsulation-TFTP.png", height: 20%),
  caption: [
    Encapsulation in TFTP
  ]
)

*IP Layer* provides a connectionless, unreliable delivery system for packets, where each packet is independent#footnote[Each packet contains the address of the source and destination] of each other. It does not maintain history. This layer receives a data chunk from a higher layer (TCP or UDP) and prepends a header of at least 20 bytes containing information regarding route handling and flow control.

#figure(
  image("imgs/Format-IP-Datagram.png"),
  caption: [
    Format of an IP Datagram
  ]
)
- *VER* specifies the IP protocol version (typically 4)
- *HLEN* indicates the length of the IP header in 32-bit words ($[5, 15]$)
- *Service Type (ToS)* suggests  priority and handling for the packet (e.g., delay, throughput) (8 bits)
- *Total Length* is the total size of the IP datagram (header + data) in bytes ($2^16-1$ bytes)
- *Identification* uniquely identifies each datagram for reassembly of fragments
- *Flags* control fragmentation; indicate if the packet can be fragmented or if more fragments follow
- *Fragment Offset* specifies the position of a fragment within the original datagram
- *Time to Live (TTL)* limits the packet’s lifetime by counting down hops; discarded when it reaches zero (8 bits)
- *Protocol* indicates the higher-level protocol (e.g., TCP, UDP) carried in the data (8 bits)
- *Header Checksum*#footnote[The headers are treated as a sequence of 16-bit integers, which are all added (using 1s complement) and the 1s complement of the final sum is taken as the checksum. Any mismatch in the checksum causes the datagram to be discarded] error-checking value for the IP header to detect corruption (16 bits)
- *Options* is an optional field Used for network testing, debugging, or special routing (variable width)
- *Padding* is extra bytes added to ensure the header is a multiple of 32 bits
- *Source/destination IP Address* are of 32 bits each

We can view IP packets using packet sniffers like `Wireshark`, `tcpdump`, etc.

= Week Two

== IP Addressing and Routing

#definition[Fragmentation][
  It is the process of breaking a larger packet into smaller pieces for network transmission.
]
Fragmentation#footnote[Typically performed by routers when forwarding packets between networks with different MTUs] occurs when a packet is too large to be transmitted over a network segment with a smaller *Maximum Transmission Unit (MTU)*#footnote[Each layer has enforces some maximum size on the packets it can receive]. The IP layer divides#footnote[Each fragment is treated as a separate IP packet with its own header containing fields like identification, fragment offset, and flags] the larger packet into smaller fragments where each travels independently. The final reassembly occurs at the final destination host.

There are two strategies for managing fragmented packets as they traverse multiple networks:
- *Transparent Fragmentation:* Here, fragmentation and reassembly are handled within a single network segment. When a large packet enters a network with a smaller MTU, a router fragments the packet. All fragments are routed to the same exit router which reassembles them before forwarding the complete packet to the next network. Intermediate networks are unaware of fragmentation occurred, thus the name _transparent_. However, this method can overload the exit router and limit parallelism, also it requires a count/end-of-packet field to know when all the packets have been received.
- *Non-Transparent Fragmentation:* Here fragmentation occurs as needed but reassembly is not performed by intermediate routers. All the fragments are forwarded independently through subsequent networks, possibly taking different paths, thus improving network resource utilization. Reassembly takes place only at the final destination host. This is the approach used by the IP protocol in the internet.

#example[IP Fragmentation][
  Consider two networks, $N_1$ and $N_2$ with MTUs $620$ bytes and $400$ bytes respectively. If some data of $1000$ bytes is to first pass through $N_1$ and then $N_2$, how will the fragmentation occur?
  #align(center)[#image("imgs/IP-Fragmentation-Question.svg")]
]
#thmbox(
  variant: "Explanation",
  color: green,
  numbering: none
)[
  - *Step 1:* When 1000 bytes flow into $N_1$, since the MTU is 620 bytes, each fragment has 20 bytes of header data, so only 600 bytes of actual data can be sent, thus, we need to divide into 2 fragments, say $F_1$ with 600 bytes,0 offset and $M = 1$, since one more fragment follows and $F_2$ with $1000-600=400$ bytes of data, $600/8=75$ offset and $M=0$ since no fragments follow.
  - *Step 2:* Now the packets flow into $N_2$. Since the MTU is 400 bytes, each fragment can have only 380 bytes of actual data. We divide $F_1$ into two fragments say $F_(11)$ with 376 bytes#footnote[We cannot transfer 380 bytes of data since the data transferred must be a multiple of 8], 0 offset and $M=1$ and $F_(12)$ with $600-376=224$ bytes, $376/8=47$ offset.
  - *Step 3:* Now we divide $F_2$ into two fragments say $F_(21)$ with 376 bytes, 75 offset and $M=1$ and $F_(22)$ with $400-376=24$ bytes, $75+376/8=122$ offset and $M=0$.
  #align(center)[
    #table(
      columns: 4,
      table.header([*Fragment*], [*Data (Bytes)*], [*Offset*], [*Flag M*]),
      [$F_(11)$], [376], [0], [1],
      [$F_(12)$], [224], [47], [0],
      [$F_(21)$], [376], [75], [1],
      [$F_(22)$], [24], [122], [0]
    )
  ]
]

The IP layer (Network Layer) sits on top of the Ethernet Layer (Datalink Layer) which has an MTU of 1500 bytes, thus the IP layer makes sure that larger packets are fragmented to fit this frame to avoid fragmentation at the Ethernet layer.

#definition[IP Address][
  An IP address is a 32-bit quantity expressed as $W.X.Y.Z$ where $.$s separate the four octets of the address, where each octet consists of 8 bits $[0, 255]$. It consists of two logical parts#footnote[The boundary between these parts is determined by the address class], _network_ and _host_. The network part identifies the specific network and the host part identifies the device withing that network.
]
A computer on the internet is addressed using a pair (network number#footnote[Assigned and managed by a central authority], host number#footnote[Assigned and managed by local network administrator]). During packet routing only the network number is looked at.

There are five address classes:
- *Class A:* Here, the first bit is 0, the addresses are in the range $[0.0.0.0, 127.255.255.255]$. The network/host split is 8/24 bits. It is generally used for very large networks up to 16 million hosts per network. Used exclusively for unicasting.
- *Class B:* Here, the first two bits are 10, the addresses are in the range $[128.0.0.0, 191.255.255.255]$. The network/host split is 16/16 bits. It is generally used for medium-sized networks up to 65K hosts per network. Used exclusively for unicasting.
- *Class C:* Here, the first three bits are 110, the addresses are in the range $[192.0.0.0, 223.255.255.255]$. The network/host split is 24/8 bits. It is generally used for small networks up to 254 hosts per network. Used exclusively for unicasting.
- *Class D:* Here, the first four bits#footnote[The rest of the bits contain the multicast address] are 1110, the addresses are in the range $[224.0.0.0, 239.255.255.255]$. It is generally multicasting.
- *Class E:* Here, the first four bits are 1111, the addresses are in the range $[240.0.0.0, 255.255.255.255]$. It is generally used for experimental or future use.

Some special purpose IP addresses are:
- IPs like $10.X.X.X$, $[172.16.X.X, 172.31.X.X]$ and $192.168.X.X$ are reserved for private use
- $127.X.X.X$ is used for loopback/local address
- $0.0.0.0$ is the default network
- $255.255.255.255$ is used for limited broadcast

For Class A, B and C, the first address identifies the network as the whole, e.g. $118.0.0.0$, 118 is the network part and all the host bits are 0 and the last address, also called directed broadcast address is used to send a message to all hosts on that specific network, e.g. $118.255.255.255$, 118 is the network part and the host bits are 1.

== TCP and UDP

Applications interact with the TCP/IP protocol suite by sending/receiving TCP or UDP data, and both TCP and UDP then use the IP layer for delivery of packets.

#figure(
  diagram(
    node((-1, 0), [User Process]),
    edge((-1, 0), "d", "<->"),
    node((-1, 1), [TCP]),
    edge((-1, 1), "dr", "<->"),
    node((0, 2), [IP]),
    node((1, 0), [User Process]),
    edge((1, 0), "d", "<->"),
    node((1, 1), [UDP]),
    edge((1, 1), "dl", "<->"),
    edge((0, 2), "d", "<->"),
    node((0, 3), [Datalink and Hardware Layer]),
    node((1.7, 1), [Port Address (16 bit)]),
    node((1.7, 2), [IP Address (32 bit)]),
    node((1.7, 3), [Physical Address (48 bit)])
  ),
)

TCP provides a connection-oriented, reliable, full-duplex#footnote[Communication mode where data can be sent and received simultaneously between two devices], byte-stream and allows multiplexing#footnote[Combining multiple data streams for transmission] and de-multiplexing#footnote[Separating data streams at receiver] to make up for the underlying unreliable IP layer. It provides end-to-end reliability using checksum, positive acknowledgements, timeouts and end-to-end flow control while also handling establishment and termination of connections between processes and sequencing of data that might reach the destination in an arbitrary order.

UDP provides a connectionless and unreliable datagram service and is very similar to the IP layer in this respect. However, it does provide a checksum and port numbers to identify the processes at the two ends.

*Port Numbers* are unique 16-bit identifiers used to distinguish different processes or services on a computer during network communication. The port numbers are stored in the headers of TCP/UDP packets. Certain ports are reserved#footnote[Ports $[1, 2023]$ are reserved for well-known services and has been extended up to 4095] for common services like 80 for http, 25 for SMTP, 21 for FTP. The ports which are assigned for short-lived communications are called ephemeral ports#footnote[The rest of the ports are ephemeral port numbers] used when a client initiates a connection to a server. The list of common ports is stored in `/private/etc/services`.

Now, to describe a unique process-to-process connection a 5-tuple called *association* is used, (Protocol, Local Host (IP, Port), Remote Host (IP, Port)), such as (TCP, 144.16.192.5, 1785, 144.16.202.57,21).

#figure(
  image("imgs/Detailed-TCP.png"),
  caption: [Detailed View of TCP]
)

#figure(
  image("imgs/TCP-Format.png"),
  caption: [Format of TCP Segment]
)

- *Source/Destination Ports* are 16 bits each
- *Sequence Number* indicates the sequence number of the first byte of data in this segment. It is used to keep track of the order of bytes for reliable delivery (32 bits)
- *Acknowledgement Number* is used for reliable transfer and acknowledgement. If the `ACK` flag is set, this field contains the value of the next expected byte from the sender (32 bits)
- *HLEN* specifies the length of the TCP header in 32-bit words (4 bits)
- *Reserved* is reserved for future use (3 bits)
- *Flags* control bits that manage the state and flow of the connection, some important flags are:
  - *URG:* Urgent pointer field significant
  - *ACK:* Acknowledgement field significant
  - *PSH:* Push function
  - *RST:* Reset the connection
  - *SYN:* Synchronize sequence numbers (used to initialise connection)#footnote[A connection request is sent by making $"SYN"=1$ and $"ACK"=0$ and it is confirmed by making $"SYN"=1$ and $"ACK"=1$]
  - *FIN:* No more data from sender (used to terminate the connection)
- *Window Size:* specifies the size of the sender's receive window#footnote[how many bytes the sender is willing to accept]. It is used for flow of control. Value of zero closes the window (16 bits)
- *Checksum:* It applies to the entire segment and is a pseudo-header. It contains the following IP header fields: Source IP address, Destination IP address, Protocol, Segment Length. It uses the same algorithm as in IP (16 bits)

A TCP connection is established using a 3-way handshake.
#figure(
  image("imgs/TCP-Connection.png", height: 25%),
  caption: [TCP Connection Establishment]
)
However, a half-open (incomplete) connection can result in possible attack scenarios like:
- Create many half-open connections to target
- Ignore SYN+ACK response
- Target connection table fills up resulting in DoS attack

A TCP connection is terminated using a 4-way handshake.
#figure(
  image("imgs/TCP-Termination.png", height: 30%),
  caption: [TCP Connection Termination]
)

#figure(
  image("imgs/Format-UDP-Datagram.png", height: 10%),
  caption: [Format of UDP Segment]
)

- *Checksum* is an optional field which is set to zero if not used (16 bits)
- *Source/Destination Ports* are 16 bits each
- *Message Length:* specifies the size of the datagram in bytes (UDP header and data) (16 bits)

== IP Subnetting

#definition[Subnet][
  A subnet is a smaller, logically defined segment of a larger IP network, created using a subnet mask.
]
Subnet is short for subnetwork, the smaller more manageable sections are made by borrowing bits from the host portion of an IP address and using them to create additional network addresses within the original network. This process is called subnetting. Thus, IP subnets introduce a third level of hierarchy, network portion, subnet portion and host portion.

A natural mask is the default subnet mask assigned to a classful IP address. It refers to the original, default subnet mask that corresponds to the traditional class-based division of IP addresses (Class A, B, or C) before any subnetting is applied. This simply separates the network and host portions. The natural mask for class A is $255.0.0.0$, class B is $255.255.0.0$ and class C is $255.255.255.0$.

Consider an address $10.0.0.20$, the natural mask provides a mechanism to split into a network portion of 10 and a host portion of 20 by computing the bitwise AND of $10.0.0.20$ and $255.0.0.0$.

Masks are very flexible and using them can divide a network into smaller subnets by extending the network portion of the addresses into the host portion. This also reduces the number of hosts per network.

Consider a network mask of $255.255.0.0$ applied on $10.5.0.20$. This divides the address into a network portion of 10, a subnet portion of 5 and a host portion of 20. Thus, the initially large single Class A network is not split into 256 subnets (from 10.0.0.0 to 10.255.0.0) and the hosts per subnet decreases to $2^16-1$ from $2^24-1$.

To further allow better utilization of available addresses we can use subnets of different sizes. This is called *Variable Length Subnet Mask*. Consider a Class C network $192.203.17.0$ to be divided into three subnets with 110, 45 and 50 hosts. Thus, we can use first use the mask $255.255.255.128$ to divide into two subnets with 128 hosts each, i.e. $192.203.17.0$ to $192.203.17.127$ and $192.203.17.128$ to $192.203.17.255$ , now subnet the second $.128$ using a mask of $255.255.255.192$ to creating $192.203.17.128$ to $192.203.17.191$ and $192.203.17.192$ to $192.203.17.255$.

There is also another concept *Classless Internet Domain Routing (CIDR)* to manage IP addresses which has no concept of Class A, B or C networks and helps reduce sizes of routing tables. Here, an IP address is represented by a prefix, which is the IP address of the network. E.g. $144.16.192.57 slash 18$, this means the 18 leftmost continuous bits are to be used for the network mask. The number of addresses in each block must be a power of 2 and the beginning addresses in each block must be divisible by the number of addresses in the block. E.g. for a $slash 28$ block (16 addresses), valid starting addresses are $... slash 0$, $... slash 16$, $... slash 32$, etc. This is the method used today.

= Week Three

== Routing Protocols

There are two ways in which data is delivered, i.e. the two connection options are:
- *Connection Oriented:* Here, a logical connection is established between the sender and receiver before any data is transferred. The network layer protocol first makes a connection and all packets are delivered as per the connection.
- *Connection-Less:* Here, no prior connection is established. Each packet is sent independently.

There are two main packet delivery options:
- *Direct Delivery:* The packet is delivered directly from the source to the destination without passing through any intermediate routers. It happens when both are on the same physical network or the sender can reach the destination using the local network.
- *Indirect Delivery:* The packet is delivered via one or more intermediate routers (gateways). It occurs when both are on different networks (different subnets), thus, the sender forwards the packet to a router, which then forwards it toward the destination (possibly through multiple routers).

The different routing methods are:
- *Next-Hop Routing:* The routing table specifies only the next router (next hop) to which the packet should be sent (not the complete path). Each router makes its own decision about the next hop based on its routing table.
- *Network-Specific Routing:* The routing table contains entries for entire networks, not individual hosts. If a packet's destination IP matches a network entry, it is forwarded to that entry.
- *Host Specific Routing:* The routing table contains entries for specific host IP addresses. If a packet’s destination matches a host-specific entry, it is routed accordingly.
- *Default Routing:* The routing table includes a default route which is used when no other entries match the destination. If a packet’s destination does not match any specific or network entry, it is forwarded to the default gateway (often 0.0.0.0/0).

There are two types of routing tables#footnote[Data structures that determine how packets are forwarded in a network]:
- *Static:* This contains information entered manually by a network administrator and does not change with time. It is simple, secure and predictable but not scalable and does not adapt to network failures or topology changes.
- *Dynamic:* This contains entries that are automatically updated by using routing protocols like RIP, OSPF or BGP. These are scalable, adaptive and can automatically find alternate paths during failures but consume network resources and may be vulnerable to certain attacks if not secured.

A routing table contains multiple fields which contain the subnet mask, the destination IP address, the next hop address, the interface and some important flags like U (router is up and running), G (destination is in another network), H (host-specific address), D (added by redirection) and M (modified by redirection).

We can view the routing table on Unix using `netstat -r`

The two broad classes of protocols used in the internet are:
- *Interior Protocols* manage routing within a single network boundary. E.g. Routing information Protocol (RIP), Open Shortest Path First (OSPF)
- *Exterior Protocols* connect different networks. E.g. Border Gateway Protocol (BGP)
The network boundary is called an autonomous system where each AS is assigned a unique AS number. These are a set of routers managed by a single organization. The routers within an AS use a common routing protocol.

*Routing Information Protocol* is an interior routing protocol that uses distance vector routing to update routers within an autonomous system. It maintains timers to detect failed links. It was used in the first generation ARPANET. However, it has a slow convergence rate (long time for routers to update table after network change like failure), counting to infinity problem (if a route becomes unreachable, routers may keep increasing the hop count indefinitely, consuming bandwidth and delaying accurate updates) and has limited scalability (hop limit of 15 makes it unusable for large networks).

*Open Shortest Path First* is a widely used interior routing protocol that finds the shortest path using link state information. It is more efficient and scalable than older protocols like RIP.
- *Link State Routing:* Each router shares information about the state (status and cost) of its links with all other routers in the AS. This information is called a link state advertisement (LSA).
- *Network Topology Database:* All routers build a complete map (database) of the network’s topology based on the LSAs they receive.
- *Shortest Path Calculation:* Each router uses Dijkstra’s algorithm to compute the shortest path to every destination in the network.
- *Next Hop Forwarding:* The routing table only stores the next hop for each destination, not the entire path.
It has a fast convergence (can quickly adapt to network changes), is scalable and allows for a configurable cost metric (can be bandwidth, cost, delay) and supports authentication (to prevent malicious updates).

In the steady state, _Hello_ packets are periodically (default 10s) to neighbours, the LSA is flooded initially from each router, the absence of _Hello_ packet for 40s indicates the failure of neighbour and causes the LSA to be flooded again. The LSA is re-flooded every 30 minutes anyways.

#figure(
  image("imgs/OSPF-Header-Format.png", height: 15%),
  caption: [OSPF Header Format]
)

The different packet types are:
- *Hello Packet* is used to check if the neighbour is up
- *Database Description (DBD) Packet* is used during the initial exchange of OSPF database information between routers and Synchronizes the database at the beginning
- *Link State Request (LSR) Packet* requests specific pieces of link-state information from a neighbor
- *Link State Update (LSU) Packet* distributes new or updated link-state advertisements (LSAs) to other routers
- *Link State Acknowledgement (LSAck) Packet* confirms receipt of LSUs

*Border Gateway Protocol#footnote[The current version is 4. It uses port 179 to send routing messages]* is the most common external routing protocol used to exchange routing information between different autonomous systems on the internet. It is designed for inter-AS routing-connecting networks managed by different organizations. It is a distance vector protocol and can specify complete routes not just the next hop (like RIP).
