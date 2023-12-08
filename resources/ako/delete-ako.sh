#!/bin/bash
helm delete $(helm list -n avi-system -q) -n avi-system 
