sudo sudo -i -u postgres
mkdir /tmp/test/$(uname -r)

pgbench -i -s 1000

mkdir /tmp/test/$(uname -r)/pgbench-rw
cd /tmp/test/$(uname -r)/pgbench-rw
iostat -xk 1 300 > iostat.log &
pgbench -c 16 -j 4 -r -T 300 -l --aggregate-interval=1 > report.txt

mkdir /tmp/test/$(uname -r)/pgbench-ro
cd /tmp/test/$(uname -r)/pgbench-ro
iostat -xk 1 300 > iostat.log &
pgbench -S -c 16 -j 4 -r -T 300 -l --aggregate-interval=1 > report.txt
