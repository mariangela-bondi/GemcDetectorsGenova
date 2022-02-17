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

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   bdx.pl <configuration filename>\n";
 	print "   Will create the BDX using the variation specified in the configuration file\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
if( scalar @ARGV != 1) 
{
	help();
	exit;
}


# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

print "CONFIGURATION IS ::: ",$configuration{"variation"},"\n";

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# To get the parameters proper authentication is needed.
# our %parameters    = get_parameters(%configuration);

# Loading FT specific subroutines
require "./hit.pl";
require "./bank.pl";
require "./geometry.pl";
require "./materials.pl";

define_banks();
define_bdx_hits();
define_bdx_materials();
    if ($configuration{"variation"} eq "CT")
{
	 print "variation CT\n";
         make_bdx_CT();
   
}
elsif ($configuration{"variation"} eq "BDXmini")
{
    print "variation BDXmini\n";
    make_hallA_bdxMini();
}
elsif ($configuration{"variation"} eq "Proposal")
     {
	 print "variation Proposal\n";
         make_hallA_bdx();
         make_detector_bdx();
         
     }
else
     {
     print "variation nuBDX\n";
           make_hallA_bdx();
          
}
    




#make_beamdump();
#make_crystal();

#make_whole();

#make_hallA_bdx();
#make_crystal_trap();
