#!/bin/env python

from scapy.all import *

def arp_display(pkt):
    if pkt.haslayer(ARP):
        if pkt[ARP].op == 1:  # who-has (request)
            return 'Request: {} is asking about {}'.format(pkt[ARP].psrc, pkt[ARP].pdst)
        if pkt[ARP].op == 2:  # is-at (response)
            return '*Response: {} has address {}'.format(pkt[ARP].hwsrc, pkt[ARP].psrc)


if __name__ == "__main__":
    #sniff(prn=arp_display, filter="arp", store=0, count=10)

    packets = rdpcap("arp.pcap")
    for pkt in packets:
        output = arp_display(pkt)
        if output:
            print(output)

