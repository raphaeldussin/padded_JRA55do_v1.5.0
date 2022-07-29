#!/bin/bash

VARS="friver huss licalvf prra prsn psl rlds rsds siconca siconc tas tos ts uas vas"
FIRSTYEAR=1958
YEARS=$( seq 1958 2019 )
INPUTDIR="/archive/gold/datasets/reanalysis/JRA55-do/v1.5.0/original"

for year in $YEARS ; do

  for var in $VARS ; do

    nfiles=$( ls $INPUTDIR | grep _${year} | grep ${var}_ | wc -l )
    if [ "$nfiles" != 1 ] ; then echo "cannot find a single file for $var for year $year" ; exit 1 ; fi
    infile=$( ls $INPUTDIR | grep _${year} | grep ${var}_ )

    fileout=$( echo $infile | sed -e "s/\.nc/\.padded\.nc/" )
    if [ ! -f $fileout ] ; then
      if [ "$year" == "$FIRSTYEAR" ] ; then
        ./pad_forcing/padding.py --jra -f -d $INPUTDIR -v $var -x 20200715 20200716 -v $var $infile
      else
        ./pad_forcing/padding.py -d $INPUTDIR -v $var -x 20200715 20200716 -v $var $infile
      fi
    fi

  done

done
