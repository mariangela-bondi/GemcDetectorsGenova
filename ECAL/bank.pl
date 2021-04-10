use strict;
use warnings;

our %configuration;

# Variable Type is two chars.
# The first char:
#  R for raw integrated variables
#  D for dgt integrated variables
#  S for raw step by step variables
#  M for digitized multi-hit variables
#  V for voltage(time) variables
#
# The second char:
# i for integers
# d for doubles

# The ft banks id are:
#
# Tracker (trk):
# Tracker (hodo):
# Tracker (cal):

sub define_ECAL_banks
{
  # uploading the hit definition
  my $bankId   = 100;
  my $bankname = "JPOS_crs";
  
  insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
  insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
  insert_bank_variable(\%configuration, $bankname, "xch",          2, "Di", "xch number");
  insert_bank_variable(\%configuration, $bankname, "ych",          3, "Di", "ych number");
  insert_bank_variable(\%configuration, $bankname, "Etot",         4, "Dd", "TotEnergyDep");
  insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
  
  
  $bankId   = 200;
  $bankname = "JPOS_HCAL";
  
  insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
  insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
  insert_bank_variable(\%configuration, $bankname, "layer",        2, "Di", "layer number");
  insert_bank_variable(\%configuration, $bankname, "channel",      3, "Di", "channel number");
  insert_bank_variable(\%configuration, $bankname, "t0",           4, "Dd", "time 0 ns");
  insert_bank_variable(\%configuration, $bankname, "Etot",         5, "Dd", "TotEnergyDep MeV");
  insert_bank_variable(\%configuration, $bankname, "EtotB",        6, "Dd", "TotEnergyDep_Birks MeV");
  insert_bank_variable(\%configuration, $bankname, "hit_pos",      7, "Dd", "hit mean longitudinal position mm");
  insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number"); 


}













