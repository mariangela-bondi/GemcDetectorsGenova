#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use math;
use materials;

use Math::Trig;


# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

require "./hit.pl";
require "./bank.pl";
require "./geometry.pl";
require "./materials.pl";


define_ECAL_banks();  
define_ECAL_hits(); 
define_ECAL_materials(); 
make_ECAL();

