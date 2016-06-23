# subnetting
![image](https://github.com/thimoonxy/subnetting/blob/master/docs/logo.jpg)

subnetting.py is a CLI help neteng and sysadmin speed up subnetting, calculating and troubleshooting.

For more ops tools, check the master project repo [opsPykit](https://github.com/thimoonxy/opsPyKit).

## Install

```
$easy_install subnetting
```

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

## Examples

#### Mode 1

- If want to know which network 192.168.141.111/28 belongs to, we run this:

```
$ subnetting.py -M 1 -i 192.168.141.111 -c 28
================================================================================================================================================================
avail_hosts  netmask             network_address     first_avail_ip      last_avail_ip       broadcast_address
----------------------------------------------------------------------------------------------------------------------------------------------------------------
14           255.255.255.240     192.168.141.96      192.168.141.97      192.168.141.110     192.168.141.111
```

#### Mode 2

- If want to know what does /28 mean, run this:
```
$ subnetting.py --mode 2 --cidr 28
================================================================================================================================================================
mask                hex_mask
----------------------------------------------------------------------------------------------------------------------------------------------------------------
255.255.255.240     FF.FF.FF.F0
```

#### Mode 3
- If want to know the cidr for 255.255.128.0, run this:
```
$ subnetting.py --mode 3 --mask 255.255.128.0
================================================================================================================================================================
mask                cidr
----------------------------------------------------------------------------------------------------------------------------------------------------------------
255.255.128.0       17
```
- It also correct the invalid mask, e.g. 289 and 265 excess 255, and the last 128 is host address but not network:

```
$ subnetting.py --mode 3 --mask 289.265.128.128
================================================================================================================================================================
mask                cidr
----------------------------------------------------------------------------------------------------------------------------------------------------------------
255.255.128.0       17
```

#### Mode 4
If require 2 subnets for C class network address 192.168.141.0, run this:
```
$ subnetting.py --mode 4 --ip 192.168.141.0 --subnet_amount 2
================================================================================================================================================================
cidr                     class                    type                     subnet_amount            network_address_list     avail_hosts
----------------------------------------------------------------------------------------------------------------------------------------------------------------
25                       C                        subnet                   2                        Details listed below     126
================================================================================================================================================================
avail_hosts         netmask             network_address     first_avail_ip      last_avail_ip       broadcast_address
----------------------------------------------------------------------------------------------------------------------------------------------------------------
126                 255.255.255.128     192.168.141.0       192.168.141.1       192.168.141.126     192.168.141.127
126                 255.255.255.128     192.168.141.128     192.168.141.129     192.168.141.254     192.168.141.255
```

#### Mode 5
- If require 50 available host addresses in each subnet of C class address 192.168.141.0, subnetting in this way:
```
$ subnetting.py --mode 5 --ip 192.168.141.0 --host_amount 50
================================================================================================================================================================
cidr                     class                    type                     subnet_amount            network_address_list     avail_hosts
----------------------------------------------------------------------------------------------------------------------------------------------------------------
26                       C                        subnet                   4                        Details listed below     62
================================================================================================================================================================
avail_hosts         netmask             network_address     first_avail_ip      last_avail_ip       broadcast_address
----------------------------------------------------------------------------------------------------------------------------------------------------------------
62                  255.255.255.192     192.168.141.0       192.168.141.1       192.168.141.62      192.168.141.63
62                  255.255.255.192     192.168.141.64      192.168.141.65      192.168.141.126     192.168.141.127
62                  255.255.255.192     192.168.141.128     192.168.141.129     192.168.141.190     192.168.141.191
62                  255.255.255.192     192.168.141.192     192.168.141.193     192.168.141.254     192.168.141.255

```
- If require too much hosts, it tells you a supernet is needed:
```
$ subnetting.py --mode 5 --ip 172.168.141.111 -h 2000000
================================================================================================================================================================
cidr                     class                    type                     subnet_amount            network_address_list     avail_hosts
----------------------------------------------------------------------------------------------------------------------------------------------------------------
11                       B                        supernet                 1                        Details listed below     2097150
================================================================================================================================================================
avail_hosts         netmask             network_address     first_avail_ip      last_avail_ip       broadcast_address
----------------------------------------------------------------------------------------------------------------------------------------------------------------
2097150             255.224.0.0         172.160.0.0         172.160.0.1         172.191.255.254     172.191.255.255

```

#### Mode 6 - 9

- If require ip address in different system, try mode 6-9:

```
$ subnetting.py --mode 6 --ip 192.168.141.123
================================================================================================================================================================
binstr                                  hexstr                                  long_int
----------------------------------------------------------------------------------------------------------------------------------------------------------------
11000000.10101000.10001101.01111011     C0.A8.8D.7B                             3232271739
```

```
$ subnetting.py --mode 7 --ip 11000000.10101000.10001101.01111011
================================================================================================================================================================
ip                                      hexstr                                  long_int
----------------------------------------------------------------------------------------------------------------------------------------------------------------
192.168.141.123                         C0.A8.8D.7B                             3232271739

```

```
$ subnetting.py --mode 8 --ip c0.A8.8D.7B
================================================================================================================================================================
ip                                      binstr                                  long_int
----------------------------------------------------------------------------------------------------------------------------------------------------------------
192.168.141.123                         11000000.10101000.10001101.01111011     3232271739

```

```
$ subnetting.py --mode 9 --ip 78912634876
================================================================================================================================================================
ip                                      binstr                                  hexstr
----------------------------------------------------------------------------------------------------------------------------------------------------------------
146.252.121.255                         10010010.11111100.01111001.11111111     92.FC.79.FF

```

## Modes help info

- When using a mode, it prompts help info for the specific mode when facing issue, but not all the modes help info:

> e.g. We use mode 1 but did not set cidr or mask, it prompts help info for mode 1:

```
$ subnetting.py --mode 1 --ip 172.16.0.0
========================

Modes Usage:
------------------------

Mode = 1,  Transfer IP to  the Network Address info.

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

------------------------

Other modes Usage, e.g.: --mode 3 --all
. END .

```

- `--help` with `--all` shows usages for every modes:

```
$ subnetting.py --help --all
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
========================

Modes Usage:
------------------------

Mode = 1,  Transfer IP to  the Network Address info.

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

------------------------

Mode = 2, Transfer cidr --> mask,

    e.g.:
        --cidr 28
    output:
        ('255.255.255.240', 'FF.FF.FF.F0')

------------------------

Mode = 3, Transfer  mask --> cidr,

    e.g.:
        --mode 3   --mask 255.255.192.192
    output:
        ('255.255.192.0', 18)

------------------------

Mode = 4, Subnetting for specific number of subnets that we want.

    ip, subnet_amount --> (cidr,c, flag,  subnet_amount, network_address_list, avail_host_amount)

    e.g.:
        -M 4 -i 172.16.2.33 -s 3
    output:
        (18, 'B', 'subnet', 3, ['172.16.0.0', '172.16.64.0', '172.16.128.0', '172.16.192.0'], 16382)

------------------------

Mode = 5, Subnetting for specific number of host addresses in each subnet.

    ip, host_amount --> (cidr,c, flag,  subnet_amount,network_address_list, avail_host_amount)

    e.g.:
        -M 5 --ip 172.16.2.33 -h 9000
    output:
        (18, 'B', 'subnet', 4, ['172.16.0.0', '172.16.64.0', '172.16.128.0', '172.16.192.0'], 16382)

------------------------

Mode = 6, Transfer ip --> (binstr, hexstr,dec),

    e.g.:
        --mode 6 --ip 192.168.141.111
    output:
        ('11000000.10101000.10001101.01101111', 'C0.A8.8D.6F', 3232271727L)

------------------------

Mode = 7, Transfer binstr --> (ip, hexstr, dec),

    e.g.
        --mode 7 --ip 11000000.10101000.10001101.01101111
    output:
        ('192.168.141.111', 'C0.A8.8D.6F', 3232271727L)

------------------------

Mode = 8, Transfer hexstr --> (ip, binstr, dec),

    e.g.:
        --mode 8 --ip C0.A8.8D.6F
    output:
        ('192.168.141.111', '11000000.10101000.10001101.01101111', 3232271727L)

------------------------

Mode = 9, Transfer dec --> (ip, binstr, hexstr),

    e.g.:
        --mode 9 --ip 3232271727
    output:
        ('192.168.141.111', '11000000.10101000.10001101.01101111', 'C0.A8.8D.6F')

------------------------

Other modes Usage, e.g.: --mode 3 --all
. END .

```
![image](https://i-technet.sec.s-msft.com/dynimg/IC213267.gif)
## Todo list
 - [x] **TBD**

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
