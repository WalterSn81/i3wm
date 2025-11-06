#!/bin/sh
vol=$(mixer vol | cut -c 14-15)
echo "  $vol% "
