# subnetting


# Todo list
 - [x] **Final Target:**
To enable every func in http://tool.chinaz.com/Tools/subnetmask

---
- [x] NetworkID  -   ip2network_address(ip, net)
> **Input:**
- ip
- cidr
1.  - [x] avail host amount
2.  - [x] network address
```
def subnet_correct(ip, postfix='32'):
    """
    This func corrects wrong subnet, e.g.
    if found 10.69.231.70/29, it'll be corrected to 10.69.231.64
    """
```
3.  - [x] 1st avail ip
4.  - [x] last avail ip
5.  - [x] broadcast address

---
- [x] Subnetting calculator
> **Function 1 Input:**
- ip
- host amount
1. - [x] dotted dec. mask/cidr
2. - [x] subnet amount
3. - [x] network class          -   def ip2class()
   - references: [wikipedia](https://en.wikipedia.org/wiki/Classful_network#Introduction_of_address_classes), [tcpipguide](http://www.tcpipguide.com/free/t_IPAddressClassABandCNetworkandHostCapacities.htm).
4. - [x] details list for each subnet
    - network address
    - 1st avail ip
    - last avail ip
    - broadcast address
> **Function 2 Input:**
- ip
- subnet amount
1. - [x] dotted dec. mask/cidr
2. - [x] network class          -   def ip2class()
3. - [x] details list for each subnet
    - network address
    - 1st avail ip
    - last avail ip
    - broadcast address
4. - [x] host amount

---
- [x] subnet mask transfer
> **Input:**
- cidr
1. - [x] cidr2mask
2. - [x] cidr2Hex

---
- [x]  hostamount2cidr
> **Input:**
- hosts numbers we need
1. - [x] cidr
2. - [x] dotted dec. mask                   - ipmask2network_address(ip, mask)[1]
3. - [x] avail hosts number                 - ipmask2network_address(ip, mask)[0]

---
- [x]  ipmask2network_address(ip, mask)
> **Input:**
- dotted dec. mask
- ip
1. - [x] network address
2. - [x] broadcast address
3. - [x] avail hosts number

---
- [x] IP system transfer
> **Input:**
- ip
1. - [x] ip2binlist
2. - [x] ip2hexlist
3. - [x] binlist2ip
4. - [x] binlist2hexlist
5. - [x] hexlist2ip
6. - [x] hexlist2binlist

---
- [x] mask2complement_bin_list(mask='255.255.255.0')
> **Input:**
- dotted dec. mask
- [x]  one-complement code mask

---
- [x] ~~mask2avail_hosts~~  -  duplicated with ip2network_address(ip, cidr)
> **Input:**
- cidr
1. - [x] ~~avail hosts numbers~~
2. - [x] all hosts numbers (+2: net, broadcast)
3. - [x] ~~dotted dec. mask~~

---
- [x] mask2cidr
> **Input:**
- dotted dec. mask
- [x] mask2cidr

```
def mask2cidr(mask='255.255.255.0'):
    '''
    1.  '255.11111.266.4' to '255.255.255.0' to 24
    2.  '255.128.255.0'  to 9
    '''
```


