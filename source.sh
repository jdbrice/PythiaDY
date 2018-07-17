#!/bin/bash

rm -rf *_C.*

root -l <<EOF
.L runhfevent.C+
.q
EOF
