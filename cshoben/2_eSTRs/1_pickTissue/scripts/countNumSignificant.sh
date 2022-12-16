#!/bin/bash

awk '{ if($21 == "True") print $0;}' Thyroid_master.tab > Thyroid_SigTrue.tab
