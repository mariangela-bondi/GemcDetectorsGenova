
use strict;
use warnings;

our %configuration;
our %parameters;


sub define_ECAL_hits
{
	# uploading the hit definition
    	my %hit = init_hit();
    	$hit{"name"}            = "JPOS_crs";
    	$hit{"description"}     = "JPOS crystals";
    	$hit{"identifiers"}     = "sector xch ych";
    	$hit{"signalThreshold"} = "200.0*KeV";
    	$hit{"timeWindow"}      = "1000*ns";

	$hit{"prodThreshold"}   = "155769*um";
	#$hit{"prodThreshold"}   = "155768*um";

	#$hit{"prodThreshold"}   = "106910*um";
	#$hit{"prodThreshold"}   = "106909*um";

	#$hit{"prodThreshold"}   = "100*mm";

	$hit{"maxStep"}         = "1000*mm"; ##da togliere 
    	$hit{"delay"}           = "10*ns";
    	$hit{"riseTime"}        = "1*ns";
    	$hit{"fallTime"}        = "1*ns";
    	$hit{"mvToMeV"}         = 100;
    	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);

}

1;
