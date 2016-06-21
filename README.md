# subnetting
![image](http://www.cocoachina.com/cms/uploads/allimg/130509/4196_130509110536_1.jpg)
## Usage
```
$ python subnetting.py --help
Usage: subnetting.py [options]

Options:
  -i IP, --ip=IP
  -c CIDR, --cidr=CIDR  Specify the cidr of mask to query. e.g. --cidr 24,
                        indicates mask=255.255.255.0
  -m MASK, --mask=MASK  Specify the Dotted Decimal mask to query. e.g. -m
                        255.255.0.0
  -h HOST_AMOUNT, --host_amount=HOST_AMOUNT
                        Specify the number of available hosts we want in each
                        subnet.
  -s SUBNET_AMOUNT, --subnet_amount=SUBNET_AMOUNT
                        Specify the number of subnets we want.
  -M MODE, --mode=MODE  Specify  Mode 1-9 to calculate or transfer.
  -a, --all             Details will be shown
  -?, --help            --help --all shows Mode details.
```

## Modes
```
 info_dict = {
    1: '''Mode = 1,  Transfer IP to  the Network Address info.

    ip, mask/cidr -->
        (avail_host_numbers, netmask, network_address, first_avail_ip,last_avail_ip, broadcast_address),

    e.g.:
        --mode 1 --ip 192.168.141.111 --cidr 29
    output:
        (6, '255.255.255.248', '192.168.141.104', '192.168.141.105', '192.168.141.110','192.168.141.111')

    e.g.:
         -M 1 -i 172.16.1.1 -m 255.255.255.0
    output:
        (254, '255.255.255.0', '172.16.1.0', '172.16.1.1', '172.16.1.254', '172.16.1.255')
    ''',
    2: '''Mode = 2, Transfer cidr --> mask,

    e.g.:
        --cidr 28
    output:
        ('255.255.255.240', 'FF.FF.FF.F0')
    ''',
    3: '''Mode = 3, Transfer  mask --> cidr,

    e.g.:
        --mode 3   --mask 255.255.192.192
    output:
        ('255.255.192.0', 18)
    ''',
    4: '''Mode = 4, Subnetting for specific number of subnets that we want.

    ip, subnet_amount --> (cidr,c, flag,  subnet_amount, network_address_list, avail_host_amount)

    e.g.:
        -M 4 -i 172.16.2.33 -s 3
    output:
        (18, 'B', 'subnet', 3, ['172.16.0.0', '172.16.64.0', '172.16.128.0', '172.16.192.0'], 16382)
    ''',
    5: '''Mode = 5, Subnetting for specific number of host addresses in each subnet.

    ip, host_amount --> (cidr,c, flag,  subnet_amount,network_address_list, avail_host_amount)

    e.g.:
        -M 5 --ip 172.16.2.33 -h 9000
    output:
        (18, 'B', 'subnet', 4, ['172.16.0.0', '172.16.64.0', '172.16.128.0', '172.16.192.0'], 16382)
    ''',
    6: '''Mode = 6, Transfer ip --> (binstr, hexstr,dec),

    e.g.:
        --mode 6 --ip 192.168.141.111
    output:
        ('11000000.10101000.10001101.01101111', 'C0.A8.8D.6F', 3232271727L)
    ''',
    7: '''Mode = 7, Transfer binstr --> (ip, hexstr, dec),

    e.g.
        --mode 7 --ip 11000000.10101000.10001101.01101111
    output:
        ('192.168.141.111', 'C0.A8.8D.6F', 3232271727L)
    ''',
    8: '''Mode = 8, Transfer hexstr --> (ip, binstr, dec),

    e.g.:
        --mode 8 --ip C0.A8.8D.6F
    output:
        ('192.168.141.111', '11000000.10101000.10001101.01101111', 3232271727L)
    ''',
    9: '''Mode = 9, Transfer dec --> (ip, binstr, hexstr),

    e.g.:
        --mode 9 --ip 3232271727
    output:
        ('192.168.141.111', '11000000.10101000.10001101.01101111', 'C0.A8.8D.6F')
    ''',
    }
```

## Todo list
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

## Reference
For more ops tools, check [opsPykit](https://github.com/thimoonxy/opsPyKit).
