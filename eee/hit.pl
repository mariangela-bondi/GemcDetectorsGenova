
use strict;
use warnings;

our %configuration;
our %parameters;


sub define_eee_hits
{
	# uploading the hit definition
	my %hit = init_hit();

	$hit{"name"}            = "eee_veto";
	$hit{"description"}     = "EEE cormorino veto";
	$hit{"identifiers"}     = "sector veto channel";
	$hit{"signalThreshold"} = "200.0*KeV";
	$hit{"timeWindow"}      = "1000*ns";
	$hit{"prodThreshold"}   = "100*um";
	$hit{"maxStep"}         = "500*um";
	$hit{"delay"}           = "10*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "1*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);

	%hit = init_hit();
	$hit{"name"}            = "eee_eee";
	$hit{"description"}     = "EEE crystals";
	$hit{"identifiers"}     = "sector layer paddle";
	$hit{"signalThreshold"} = "200.0*KeV";
	$hit{"timeWindow"}      = "1000*ns";
	$hit{"prodThreshold"}   = "100*um";
	$hit{"maxStep"}         = "1*mm";
	$hit{"delay"}           = "10*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "1*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
	
}



1;
