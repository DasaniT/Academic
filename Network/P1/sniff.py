import socket
import struct


def get_mac_addr(bytes_addr):
    bytes_str = map("{:02x}".format, bytes_addr)
    return ":".join(bytes_str).upper()


def ethernet_head(raw_data):
    destination, source_mac, prototype = struct.unpack("! 6s 6s H", raw_data[:14])
    proto = socket.htons(prototype)
    data = raw_data[14:]
    return get_mac_addr(destination), get_mac_addr(source_mac), proto, data


def ipv4_head(raw_data):
    version_header_length = raw_data[0]
    version = version_header_length >> 4
    header_length = (version_header_length & 15) * 4
    ttl, proto, src, target = struct.unpack("! 8x B B 2x 4s 4s", raw_data[:20])
    data = raw_data[header_length:]
    return version, header_length, ttl, proto, get_ip(src), get_ip(target), data


def get_ip(addr):
    return ".".join(map(str, addr))


connection = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_TCP)

while True:
    raw_data, address = connection.recvfrom(65565)
    dest_mac, source_mac, proto, data = ethernet_head(raw_data)
    print(
        "Destination: {}, Source: {}, Protocol: {}".format(dest_mac, source_mac, proto)
    )
    if proto == 8:
        ipv4 = ipv4_head(data)
        print("\t - " + "IPv4 Packet:")
        print(
            "\t\t - "
            + "Version: {}, Header Length: {}, TTL:{}, ".format(
                ipv4[1], ipv4[2], ipv4[3]
            )
        )
        print(
            "\t\t - "
            + "Protocol: {}, Source: {}, Target:{}".format(ipv4[4], ipv4[5], ipv4[6])
        )

