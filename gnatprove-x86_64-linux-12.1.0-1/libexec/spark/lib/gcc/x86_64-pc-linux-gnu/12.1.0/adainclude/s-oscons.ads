------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                  S Y S T E M . O S _ C O N S T A N T S                   --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 2000-2022, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

pragma Style_Checks ("M32766");
--  Allow long lines

--  This package provides target dependent definitions of constant for use
--  by the GNAT runtime library. This package should not be directly with'd
--  by an application program.

--  This file is generated automatically, do not modify it by hand! Instead,
--  make changes to s-oscons-tmplt.c and rebuild the GNAT runtime library.
--  This is the version for x86_64-pc-linux-gnu

with Interfaces.C;
package System.OS_Constants is

   pragma Pure;

   ---------------------------------
   -- General platform parameters --
   ---------------------------------

   type OS_Type is (Windows, Other_OS);
   Target_OS                     : constant OS_Type := Other_OS;
   pragma Warnings (Off, Target_OS);
   --  Suppress warnings on Target_OS since it is in general tested for
   --  equality with a constant value to implement conditional compilation,
   --  which normally generates a constant condition warning.

   Target_Name                   : constant String  := "x86_64-pc-linux-gnu";
   SIZEOF_unsigned_int           : constant := 4;          --  Size of unsigned int
   subtype Serial_Port_Descriptor is Interfaces.C.int;

   -------------------
   -- System limits --
   -------------------

   IOV_MAX                       : constant := 1024;       --  Maximum writev iovcnt
   NAME_MAX                      : constant := 255;        --  Maximum file name length

   ---------------------
   -- File open modes --
   ---------------------

   O_RDWR                        : constant := 2;          --  Read/write
   O_NOCTTY                      : constant := 256;        --  Don't change ctrl tty
   O_NDELAY                      : constant := 2048;       --  Nonblocking

   ----------------------
   -- Fcntl operations --
   ----------------------

   F_GETFL                       : constant := 3;          --  Get flags
   F_SETFL                       : constant := 4;          --  Set flags

   -----------------
   -- Fcntl flags --
   -----------------

   FNDELAY                       : constant := 2048;       --  Nonblocking

   ----------------------
   -- Ioctl operations --
   ----------------------

   subtype IOCTL_Req_T is Interfaces.C.int;
   FIONBIO                       : constant := 21537;      --  Set/clear non-blocking io
   FIONREAD                      : constant := 21531;      --  How many bytes to read

   ------------------
   -- Errno values --
   ------------------

   --  The following constants are defined from <errno.h>

   EAGAIN                        : constant := 11;         --  Try again
   ENOENT                        : constant := 2;          --  File not found
   ENOMEM                        : constant := 12;         --  Out of memory
   EACCES                        : constant := 13;         --  Permission denied
   EADDRINUSE                    : constant := 98;         --  Address already in use
   EADDRNOTAVAIL                 : constant := 99;         --  Cannot assign address
   EAFNOSUPPORT                  : constant := 97;         --  Addr family not supported
   EALREADY                      : constant := 114;        --  Operation in progress
   EBADF                         : constant := 9;          --  Bad file descriptor
   ECONNABORTED                  : constant := 103;        --  Connection aborted
   ECONNREFUSED                  : constant := 111;        --  Connection refused
   ECONNRESET                    : constant := 104;        --  Connection reset by peer
   EDESTADDRREQ                  : constant := 89;         --  Destination addr required
   EFAULT                        : constant := 14;         --  Bad address
   EHOSTDOWN                     : constant := 112;        --  Host is down
   EHOSTUNREACH                  : constant := 113;        --  No route to host
   EINPROGRESS                   : constant := 115;        --  Operation now in progress
   EINTR                         : constant := 4;          --  Interrupted system call
   EINVAL                        : constant := 22;         --  Invalid argument
   EIO                           : constant := 5;          --  Input output error
   EISCONN                       : constant := 106;        --  Socket already connected
   ELOOP                         : constant := 40;         --  Too many symbolic links
   EMFILE                        : constant := 24;         --  Too many open files
   EMSGSIZE                      : constant := 90;         --  Message too long
   ENAMETOOLONG                  : constant := 36;         --  Name too long
   ENETDOWN                      : constant := 100;        --  Network is down
   ENETRESET                     : constant := 102;        --  Disconn. on network reset
   ENETUNREACH                   : constant := 101;        --  Network is unreachable
   ENOBUFS                       : constant := 105;        --  No buffer space available
   ENOPROTOOPT                   : constant := 92;         --  Protocol not available
   ENOTCONN                      : constant := 107;        --  Socket not connected
   ENOTSOCK                      : constant := 88;         --  Operation on non socket
   EOPNOTSUPP                    : constant := 95;         --  Operation not supported
   EPIPE                         : constant := 32;         --  Broken pipe
   EPFNOSUPPORT                  : constant := 96;         --  Unknown protocol family
   EPROTONOSUPPORT               : constant := 93;         --  Unknown protocol
   EPROTOTYPE                    : constant := 91;         --  Unknown protocol type
   ERANGE                        : constant := 34;         --  Result too large
   ESHUTDOWN                     : constant := 108;        --  Cannot send once shutdown
   ESOCKTNOSUPPORT               : constant := 94;         --  Socket type not supported
   ETIMEDOUT                     : constant := 110;        --  Connection timed out
   ETOOMANYREFS                  : constant := 109;        --  Too many references
   EWOULDBLOCK                   : constant := 11;         --  Operation would block
   E2BIG                         : constant := 7;          --  Argument list too long
   EILSEQ                        : constant := 84;         --  Illegal byte sequence

   ----------------------
   -- Terminal control --
   ----------------------

   TCSANOW                       : constant := 0;          --  Immediate
   TCIFLUSH                      : constant := 0;          --  Flush input
   IXON                          : constant := 1024;       --  Output sw flow control
   CLOCAL                        : constant := 2048;       --  Local
   CRTSCTS                       : constant := 2147483648; --  Output hw flow control
   CREAD                         : constant := 128;        --  Read
   ICANON                        : constant := 2;          --  canonical mode
   CBAUD                         : constant := 4111;       --  baud speed mask
   ECHO                          : constant := 8;          --  echo input characters
   ECHOE                         : constant := 16;         --  erase preceding characters
   ECHOK                         : constant := 32;         --  kill character, erases current line
   ECHOCTL                       : constant := 512;        --  echo special characters
   ECHONL                        : constant := 64;         --  force echo NL character
   CS5                           : constant := 0;          --  5 data bits
   CS6                           : constant := 16;         --  6 data bits
   CS7                           : constant := 32;         --  7 data bits
   CS8                           : constant := 48;         --  8 data bits
   CSTOPB                        : constant := 64;         --  2 stop bits
   PARENB                        : constant := 256;        --  Parity enable
   PARODD                        : constant := 512;        --  Parity odd
   B0                            : constant := 0;          --  0 bps
   B50                           : constant := 1;          --  50 bps
   B75                           : constant := 2;          --  75 bps
   B110                          : constant := 3;          --  110 bps
   B134                          : constant := 4;          --  134 bps
   B150                          : constant := 5;          --  150 bps
   B200                          : constant := 6;          --  200 bps
   B300                          : constant := 7;          --  300 bps
   B600                          : constant := 8;          --  600 bps
   B1200                         : constant := 9;          --  1200 bps
   B1800                         : constant := 10;         --  1800 bps
   B2400                         : constant := 11;         --  2400 bps
   B4800                         : constant := 12;         --  4800 bps
   B9600                         : constant := 13;         --  9600 bps
   B19200                        : constant := 14;         --  19200 bps
   B38400                        : constant := 15;         --  38400 bps
   B57600                        : constant := 4097;       --  57600 bps
   B115200                       : constant := 4098;       --  115200 bps
   B230400                       : constant := 4099;       --  230400 bps
   B460800                       : constant := 4100;       --  460800 bps
   B500000                       : constant := 4101;       --  500000 bps
   B576000                       : constant := 4102;       --  576000 bps
   B921600                       : constant := 4103;       --  921600 bps
   B1000000                      : constant := 4104;       --  1000000 bps
   B1152000                      : constant := 4105;       --  1152000 bps
   B1500000                      : constant := 4106;       --  1500000 bps
   B2000000                      : constant := 4107;       --  2000000 bps
   B2500000                      : constant := 4108;       --  2500000 bps
   B3000000                      : constant := 4109;       --  3000000 bps
   B3500000                      : constant := 4110;       --  3500000 bps
   B4000000                      : constant := 4111;       --  4000000 bps

   ---------------------------------
   -- Terminal control characters --
   ---------------------------------

   VINTR                         : constant := 0;          --  Interrupt
   VQUIT                         : constant := 1;          --  Quit
   VERASE                        : constant := 2;          --  Erase
   VKILL                         : constant := 3;          --  Kill
   VEOF                          : constant := 4;          --  EOF
   VTIME                         : constant := 5;          --  Read timeout
   VMIN                          : constant := 6;          --  Read min chars
   VSWTC                         : constant := 7;          --  Switch
   VSTART                        : constant := 8;          --  Flow control start
   VSTOP                         : constant := 9;          --  Flow control stop
   VSUSP                         : constant := 10;         --  Suspend
   VEOL                          : constant := 11;         --  EOL
   VREPRINT                      : constant := 12;         --  Reprint unread
   VDISCARD                      : constant := 13;         --  Discard pending
   VWERASE                       : constant := 14;         --  Word erase
   VLNEXT                        : constant := 15;         --  Literal next
   VEOL2                         : constant := 16;         --  Alternative EOL

   -----------------------------
   -- Pseudo terminal library --
   -----------------------------

   PTY_Library                   : constant String  := "-lutil";     --  for g-exptty

   --------------
   -- Families --
   --------------

   AF_INET                       : constant := 2;          --  IPv4 address family
   AF_INET6                      : constant := 10;         --  IPv6 address family
   AF_UNIX                       : constant := 1;          --  Local unix family
   AF_UNSPEC                     : constant := 0;          --  Unspecified address family

   -----------------------------
   -- addrinfo fields offsets --
   -----------------------------

   AI_FLAGS_OFFSET               : constant := 0;          --  Offset of ai_flags in addrinfo
   AI_FAMILY_OFFSET              : constant := 4;          --  Offset of ai_family in addrinfo
   AI_SOCKTYPE_OFFSET            : constant := 8;          --  Offset of ai_socktype in addrinfo
   AI_PROTOCOL_OFFSET            : constant := 12;         --  Offset of ai_protocol in addrinfo
   AI_ADDRLEN_OFFSET             : constant := 16;         --  Offset of ai_addrlen in addrinfo
   AI_ADDR_OFFSET                : constant := 24;         --  Offset of ai_addr in addrinfo
   AI_CANONNAME_OFFSET           : constant := 32;         --  Offset of ai_canonname in addrinfo
   AI_NEXT_OFFSET                : constant := 40;         --  Offset of ai_next in addrinfo

   ---------------------------------------
   -- getaddrinfo getnameinfo constants --
   ---------------------------------------

   AI_PASSIVE                    : constant := 1;          --  NULL nodename for accepting
   AI_CANONNAME                  : constant := 2;          --  Get the host official name
   AI_NUMERICSERV                : constant := 1024;       --  Service is a numeric string
   AI_NUMERICHOST                : constant := 4;          --  Node is a numeric IP address
   AI_ADDRCONFIG                 : constant := 32;         --  Returns addresses for only locally configured families
   AI_V4MAPPED                   : constant := 8;          --  Returns IPv4 mapped to IPv6
   AI_ALL                        : constant := 16;         --  Change AI_V4MAPPED behavior for unavailavle IPv6 addresses
   NI_NAMEREQD                   : constant := 8;          --  Error if the hostname cannot be determined
   NI_DGRAM                      : constant := 16;         --  Service is datagram
   NI_NOFQDN                     : constant := 4;          --  Return only the hostname part for local hosts
   NI_NUMERICSERV                : constant := 2;          --  Numeric form of the service
   NI_NUMERICHOST                : constant := 1;          --  Numeric form of the hostname
   NI_MAXHOST                    : constant := 1025;       --  Maximum size of hostname
   NI_MAXSERV                    : constant := 32;         --  Maximum size of service name
   EAI_SYSTEM                    : constant := -11;        --  Check errno for details

   ------------------
   -- Socket modes --
   ------------------

   SOCK_STREAM                   : constant := 1;          --  Stream socket
   SOCK_DGRAM                    : constant := 2;          --  Datagram socket
   SOCK_RAW                      : constant := 3;          --  Raw socket

   -----------------
   -- Host errors --
   -----------------

   HOST_NOT_FOUND                : constant := 1;          --  Unknown host
   TRY_AGAIN                     : constant := 2;          --  Host name lookup failure
   NO_DATA                       : constant := 4;          --  No data record for name
   NO_RECOVERY                   : constant := 3;          --  Non recoverable errors

   --------------------
   -- Shutdown modes --
   --------------------

   SHUT_RD                       : constant := 0;          --  No more recv
   SHUT_WR                       : constant := 1;          --  No more send
   SHUT_RDWR                     : constant := 2;          --  No more recv/send

   ---------------------
   -- Protocol levels --
   ---------------------

   SOL_SOCKET                    : constant := 1;          --  Options for socket level
   IPPROTO_IP                    : constant := 0;          --  Dummy protocol for IP
   IPPROTO_IPV6                  : constant := 41;         --  IPv6 socket option level
   IPPROTO_UDP                   : constant := 17;         --  UDP
   IPPROTO_TCP                   : constant := 6;          --  TCP
   IPPROTO_ICMP                  : constant := 1;          --  Internet Control Message Protocol
   IPPROTO_IGMP                  : constant := 2;          --  Internet Group Management Protocol
   IPPROTO_IPIP                  : constant := 4;          --  IPIP tunnels (older KA9Q tunnels use 94)
   IPPROTO_EGP                   : constant := 8;          --  Exterior Gateway Protocol
   IPPROTO_PUP                   : constant := 12;         --  PUP protocol
   IPPROTO_IDP                   : constant := 22;         --  XNS IDP protocol
   IPPROTO_TP                    : constant := 29;         --  SO Transport Protocol Class 4
   IPPROTO_DCCP                  : constant := 33;         --  Datagram Congestion Control Protocol
   IPPROTO_RSVP                  : constant := 46;         --  Reservation Protocol
   IPPROTO_GRE                   : constant := 47;         --  General Routing Encapsulation
   IPPROTO_ESP                   : constant := 50;         --  encapsulating security payload
   IPPROTO_AH                    : constant := 51;         --  authentication header
   IPPROTO_MTP                   : constant := 92;         --  Multicast Transport Protocol
   IPPROTO_BEETPH                : constant := 94;         --  IP option pseudo header for BEET
   IPPROTO_ENCAP                 : constant := 98;         --  Encapsulation Header
   IPPROTO_PIM                   : constant := 103;        --  Protocol Independent Multicast
   IPPROTO_COMP                  : constant := 108;        --  Compression Header Protocol
   IPPROTO_SCTP                  : constant := 132;        --  Stream Control Transmission Protocol
   IPPROTO_UDPLITE               : constant := 136;        --  UDP-Lite protocol
   IPPROTO_MPLS                  : constant := 137;        --  MPLS in IP
   IPPROTO_RAW                   : constant := 255;        --  Raw IP packets

   -------------------
   -- Request flags --
   -------------------

   MSG_OOB                       : constant := 1;          --  Process out-of-band data
   MSG_PEEK                      : constant := 2;          --  Peek at incoming data
   MSG_EOR                       : constant := 128;        --  Send end of record
   MSG_WAITALL                   : constant := 256;        --  Wait for full reception
   MSG_NOSIGNAL                  : constant := 16384;      --  No SIGPIPE on send
   MSG_Forced_Flags              : constant := MSG_NOSIGNAL;
   --  Flags set on all send(2) calls

   --------------------
   -- Socket options --
   --------------------

   TCP_NODELAY                   : constant := 1;          --  Do not coalesce packets
   TCP_KEEPCNT                   : constant := 6;          --  Maximum number of keepalive probes
   TCP_KEEPIDLE                  : constant := 4;          --  Idle time before TCP starts sending keepalive probes
   TCP_KEEPINTVL                 : constant := 5;          --  Time between individual keepalive probes
   SO_REUSEADDR                  : constant := 2;          --  Bind reuse local address
   SO_REUSEPORT                  : constant := 15;         --  Bind reuse port number
   SO_KEEPALIVE                  : constant := 9;          --  Enable keep-alive msgs
   SO_LINGER                     : constant := 13;         --  Defer close to flush data
   SO_BROADCAST                  : constant := 6;          --  Can send broadcast msgs
   SO_SNDBUF                     : constant := 7;          --  Set/get send buffer size
   SO_RCVBUF                     : constant := 8;          --  Set/get recv buffer size
   SO_SNDTIMEO                   : constant := 21;         --  Emission timeout
   SO_RCVTIMEO                   : constant := 20;         --  Reception timeout
   SO_ERROR                      : constant := 4;          --  Get/clear error status
   SO_BUSY_POLL                  : constant := 46;         --  Busy polling
   IP_MULTICAST_IF               : constant := 32;         --  Set/get mcast interface
   IP_MULTICAST_TTL              : constant := 33;         --  Set/get multicast TTL
   IP_MULTICAST_LOOP             : constant := 34;         --  Set/get mcast loopback
   IP_ADD_MEMBERSHIP             : constant := 35;         --  Join a multicast group
   IP_DROP_MEMBERSHIP            : constant := 36;         --  Leave a multicast group
   IP_PKTINFO                    : constant := 8;          --  Get datagram info
   IP_RECVERR                    : constant := 11;         --  Extended reliable error message passing
   IPV6_ADDRFORM                 : constant := 1;          --  Turn IPv6 socket into different address family
   IPV6_ADD_MEMBERSHIP           : constant := 20;         --  Join IPv6 multicast group
   IPV6_DROP_MEMBERSHIP          : constant := 21;         --  Leave IPv6 multicast group
   IPV6_MTU                      : constant := 24;         --  Set/get MTU used for the socket
   IPV6_MTU_DISCOVER             : constant := 23;         --  Control path-MTU discovery on the socket
   IPV6_MULTICAST_HOPS           : constant := 18;         --  Set the multicast hop limit for the socket
   IPV6_MULTICAST_IF             : constant := 17;         --  Set/get IPv6 mcast interface
   IPV6_MULTICAST_LOOP           : constant := 19;         --  Set/get mcast loopback
   IPV6_RECVPKTINFO              : constant := 49;         --  Set delivery of the IPV6_PKTINFO
   IPV6_PKTINFO                  : constant := 50;         --  Get IPv6datagram info
   IPV6_RTHDR                    : constant := 57;         --  Set the routing header delivery
   IPV6_AUTHHDR                  : constant := 10;         --  Set the authentication header delivery
   IPV6_DSTOPTS                  : constant := 59;         --  Set the destination options delivery
   IPV6_HOPOPTS                  : constant := 54;         --  Set the hop options delivery
   IPV6_FLOWINFO                 : constant := 11;         --  Set the flow ID delivery
   IPV6_HOPLIMIT                 : constant := 52;         --  Set the hop count of the packet delivery
   IPV6_RECVERR                  : constant := 25;         --  Extended reliable error message passing
   IPV6_ROUTER_ALERT             : constant := 22;         --  Pass forwarded router alert hop-by-hop option
   IPV6_UNICAST_HOPS             : constant := 16;         --  Set the unicast hop limit
   IPV6_V6ONLY                   : constant := 26;         --  Restricted to IPv6 communications only

   ----------------------
   -- Type definitions --
   ----------------------

   --  Sizes (in bytes) of the components of struct timeval
   SIZEOF_tv_sec                 : constant := 8;          --  tv_sec
   SIZEOF_tv_usec                : constant := 8;          --  tv_usec

   --  Maximum allowed value for tv_sec
   MAX_tv_sec                    : constant := 2 ** (SIZEOF_tv_sec * 8 - 1) - 1;

   --  Sizes of various data types
   SIZEOF_sockaddr_in            : constant := 16;         --  struct sockaddr_in
   SIZEOF_sockaddr_in6           : constant := 28;         --  struct sockaddr_in6
   SIZEOF_sockaddr_un            : constant := 110;        --  struct sockaddr_un
   SIZEOF_fd_set                 : constant := 128;        --  fd_set
   FD_SETSIZE                    : constant := 1024;       --  Max fd value
   SIZEOF_struct_hostent         : constant := 32;         --  struct hostent
   SIZEOF_struct_servent         : constant := 32;         --  struct servent
   SIZEOF_sigset                 : constant := 128;        --  sigset
   SIZEOF_nfds_t                 : constant := 64;         --  Size of nfds_t
   SIZEOF_socklen_t              : constant := 4;          --  Size of socklen_t
   SIZEOF_fd_type                : constant := 32;         --  Size of socket fd
   SIZEOF_pollfd_events          : constant := 16;         --  Size of pollfd.events
   IF_NAMESIZE                   : constant := 16;         --  Max size of interface name with 0 terminator

   --  Poll values

   POLLIN                        : constant := 1;          --  There is data to read
   POLLPRI                       : constant := 2;          --  Urgent data to read
   POLLOUT                       : constant := 4;          --  Writing will not block
   POLLERR                       : constant := 8;          --  Error (output only)
   POLLHUP                       : constant := 16;         --  Hang up (output only)
   POLLNVAL                      : constant := 32;         --  Invalid request

   --  Fields of struct msghdr
   subtype Msg_Iovlen_T is Interfaces.C.size_t;

   ----------------------------------------
   -- Properties of supported interfaces --
   ----------------------------------------

   Need_Netdb_Buffer             : constant := 1;          --  Need buffer for Netdb ops
   Need_Netdb_Lock               : constant := 0;          --  Need lock for Netdb ops
   Has_Sockaddr_Len              : constant := 0;          --  Sockaddr has sa_len field
   Thread_Blocking_IO            : constant Boolean := True;
   --  Set False for contexts where socket i/o are process blocking

   Inet_Pton_Linkname            : constant String  := "inet_pton";
   Inet_Ntop_Linkname            : constant String  := "inet_ntop";
   Poll_Linkname                 : constant String  := "poll";

   ---------------------
   -- Threads support --
   ---------------------

   --  Clock identifier definitions

   CLOCK_REALTIME                : constant := 0;          --  System realtime clock
   CLOCK_MONOTONIC               : constant := 1;          --  System monotonic clock
   CLOCK_THREAD_CPUTIME_ID       : constant := 3;          --  Thread CPU clock
   CLOCK_RT_Ada                  : constant := CLOCK_MONOTONIC;

   --  Sizes of pthread data types

   PTHREAD_SIZE                  : constant := 8;          --  pthread_t
   PTHREAD_ATTR_SIZE             : constant := 56;         --  pthread_attr_t
   PTHREAD_MUTEXATTR_SIZE        : constant := 4;          --  pthread_mutexattr_t
   PTHREAD_MUTEX_SIZE            : constant := 40;         --  pthread_mutex_t
   PTHREAD_CONDATTR_SIZE         : constant := 4;          --  pthread_condattr_t
   PTHREAD_COND_SIZE             : constant := 48;         --  pthread_cond_t
   PTHREAD_RWLOCKATTR_SIZE       : constant := 8;          --  pthread_rwlockattr_t
   PTHREAD_RWLOCK_SIZE           : constant := 56;         --  pthread_rwlock_t
   PTHREAD_ONCE_SIZE             : constant := 4;          --  pthread_once_t

   --------------------------------
   -- File and directory support --
   --------------------------------

   SIZEOF_struct_file_attributes : constant := 32;         --  struct file_attributes
   SIZEOF_struct_dirent_alloc    : constant := 275;        --  struct dirent allocation

end System.OS_Constants;
