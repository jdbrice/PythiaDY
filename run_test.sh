#!/bin/bash

mkdir -p test
rm -rf test/test.log
rm -rf test/pythiaevent_test.root

root -b <<EOF >& test/test.log
.O2
.L runhfevent_C.so
runhfevent(888,10000,3128,1);
.q
EOF

