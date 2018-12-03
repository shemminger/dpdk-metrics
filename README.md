# dpdk-metrics
Scripts to measure code coverage of DPDK platform

## Getting Started

### Prerequisites

These scripts assume git and basic Linux tools. The tools use an existing DPDK
source tree. The optional Lines Of Code script uses cloc Perl script
https://github.com/AlDanial/cloc/blob/master/cloc

## Generating the symbol table
The symbols script extracts the exported API symbols from DPDK
library export maps. It produces files in the symbol files in the symbols
directory for later usage script.


```
$ ./symbols.sh ~/git/dpdk
```

### Fetching 

The fetch script will download the source for all projects
in projects.list. The total source for current list generates
about 3G so make sure have disk space.

By default, the project source files are placed in $HOME/git/dpdk-projects.


```
$ ./fetch.sh 
13:54:10 Fetching ANS https://github.com/ansyun/dpdk-ans
13:54:11 Fetching BESS https://github.com/NetSys/bess
13:54:11 Fetching contrail-vrouter https://github.com/Juniper/contrail-vrouter.git

```


## Generating the results
The libusage script will generate a table of projects versus DPDK libraries
in comma separated format.


```
$ ./libusage.sh 
14:11:17 Measuring ANS
14:11:18 Measuring BESS
14:11:18 Measuring contrail-vrouter
...
```


## Authors

* **Stephen Hemminger**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
