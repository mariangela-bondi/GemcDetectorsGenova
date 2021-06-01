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

sub define_poker_bank
{


    my $bankId   = 300;
    my $bankname = "poker_crs";
    
    insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
    insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
    insert_bank_variable(\%configuration, $bankname, "xch",          2, "Di", "xch number");
    insert_bank_variable(\%configuration, $bankname, "ych",          3, "Di", "ych number");
    insert_bank_variable(\%configuration, $bankname, "zch",          4, "Di", "zch number");
    insert_bank_variable(\%configuration, $bankname, "Npe",         5, "Di", "Npe");
    insert_bank_variable(\%configuration, $bankname, "Npe_sat",         6, "Di", "Npe_sat");
    insert_bank_variable(\%configuration, $bankname, "Etot_B",         7, "Di", "Etot_B");
    insert_bank_variable(\%configuration, $bankname, "Etot_noB",         8, "Di", "Etot_noB");
    insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number"); 


}



sub define_banks
{
	define_poker_bank();
}

1;










