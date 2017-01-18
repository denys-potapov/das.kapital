# das.kapital

Automated fixes:

* merge hyphen words - (char probably U+002D)
* replace double equal signs on line break
* fix quotation marks („…“ to «…») in Book II and Franko

Rename files:

    find -name '*.txt' | sort | gawk 'BEGIN{ a=61 }{ printf "mv %s %04d.txt\n", $0, a++ }' | bash

Test rename:

    find -name '*.txt' | sort | gawk 'BEGIN{ a=61 }{ printf "echo %s %04d.txt\n", $0, a++ }' | bash 

Task sizes:
	
- franko = 5
- ii = 10
- iii.2 = 7

Download single photo via ssh from your local home folder

    scp <source> <destination>

    scp /home/chmen/franko.web/0061.jpg root@46.101.228.108:/home/rails/scharwerk/public/scans

Download folder via ssh from your local home folder:

    scp -r /home/chmen/franko.web root@46.101.228.108:/home/rails/scharwerk/public/scans
