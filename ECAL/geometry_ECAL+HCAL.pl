use strict;
use warnings;

our %configuration;


sub make_main_volume{
  my %detector = init_det();
  $detector{"name"}        = "main_volume";
  $detector{"mother"}      = "root";
  $detector{"description"} = "World";
  $detector{"color"}       = "666666";
  $detector{"style"}       = 0;
  $detector{"visible"}     = 1;
  $detector{"type"}        = "Box";
  my $X = 0.;
  my $Y = 0.;
  my $Z = 0.;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"rotation"}    = "0*deg 0*deg 0*deg";
  
  my $par1 = 500.;
  my $par2 = 500.;
  my $par3 = 500.;
  $detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
  $detector{"material"}    = "G4_Galactic";
  print_det(\%configuration, \%detector);
}


##########################################
##########################################

# Starting from 0,0,0 define the different shifts
my $shX=0.;
my $shY=0.;
my $shZ=0.;

# Scintillator
my $cri_x=10/2.;
my $cri_y=10/2.;
#my $cri_z=17.8/2; ## 20 X0
my $cri_z=35.6/2; ## 40 X0
#my $cri_z=53.4/2; ## 60 X0

# Flux Detector
my $fluxW = 0.1/2;
#my $fluxW = 10./2;


#HCAL
my $N_layers_L = 10;
my $N_layers_B = 10;

my $PbW = 0.8/2;
#my $PbW = 0.2/2;
my $ScW = 1.2/2;
#my $ScW = 0.3/2;


sub make_PbWO4{

  my %detector = init_det();

  $detector{"mother"}      = "main_volume";
  $detector{"name"}        = "PbWO4";
  $detector{"description"} = "PbWO4";
  $detector{"color"}       = "ff8000";
  $detector{"style"}       = 1;
  $detector{"visible"}     = 1;
  $detector{"type"}        = "Box";
  my $X = $shX;
  my $Y = $shY;
  my $Z = $shZ;
  
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"rotation"}    = "0*deg 0*deg 0*deg";
  $detector{"dimensions"}  = "$cri_x*cm $cri_y*cm $cri_z*cm";
  $detector{"material"}    = "G4_PbWO4";
  $detector{"sensitivity"} = "JPOS_crs"; 
  $detector{"hit_type"}    = "JPOS_crs";
  $detector{"identifiers"} = "sector manual 1234 xch manual 1234 ych manual 1234";
  print_det(\%configuration, \%detector);  
}


sub make_inner_flux{
  
  my %detector = init_det();
      
  $detector{"name"}        = "inner_flux_back";
  $detector{"mother"}      = "main_volume";
  $detector{"description"} = "inner_flux_back";
  $detector{"color"}       = "cc00ff";
  $detector{"style"}       = 0;
  $detector{"visible"}     = 1;
  $detector{"type"}        = "Box";
  my $X = $shX;
  my $Y = $shY;
  my $Z = $shZ + $cri_z + $fluxW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"rotation"}    = "0*deg 0*deg 0*deg";
  $detector{"dimensions"}  = "$cri_x*cm $cri_y*cm $fluxW*cm";
  $detector{"material"}    = "G4_Galactic";
  $detector{"sensitivity"} = "flux";
  $detector{"hit_type"}    = "flux";
  $detector{"identifiers"} = "id manual 106";
  print_det(\%configuration, \%detector);
  

  $detector{"name"}        = "inner_flux_top";
  $detector{"description"} = "inner_flux_top";
  $X = $shX;
  $Y = $shY  + $cri_y + $fluxW;
  $Z = $shZ;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$cri_x*cm $fluxW*cm $cri_z*cm";
  $detector{"identifiers"} = "id manual 102";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "inner_flux_bottom";
  $detector{"description"} = "inner_flux_bottom";
  $X = $shX;
  $Y = $shY  - $cri_y - $fluxW;
  $Z = $shZ;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$cri_x*cm $fluxW*cm $cri_z*cm";
  $detector{"identifiers"} = "id manual 105";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "inner_flux_left";
  $detector{"description"} = "inner_flux_left";
  $X = $shX + $cri_x + $fluxW;
  $Y = $shY;
  $Z = $shZ;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$fluxW*cm $cri_y*cm $cri_z*cm";
  $detector{"identifiers"} = "id manual 103";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "inner_flux_right";
  $detector{"description"} = "inner_flux_right";
  $X = $shX - $cri_x - $fluxW;
  $Y = $shY;
  $Z = $shZ;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$fluxW*cm $cri_y*cm $cri_z*cm";
  $detector{"identifiers"} = "id manual 104";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "inner_flux_front";
  $detector{"description"} = "inner_flux_front";
  $X = $shX;
  $Y = $shY;
  $Z = $shZ - $cri_z - $fluxW;;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$cri_x*cm $cri_y*cm $fluxW*cm";
  $detector{"identifiers"} = "id manual 101";
  print_det(\%configuration, \%detector);       
}

sub make_HCAL_L {
  my $b;
  for ( $b = 1 ; $b <= $N_layers_L ; $b++ ){
    #print "b= $b\n";
    
    ###########Pb HCAL###########
    #############################
    my %detector = init_det();
    $detector{"name"}        = "Pb_L$b\_top";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Pb_L$b\_top";
    $detector{"color"}       = "666699";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    my $X = $shX;
    my $Y = $shY  + $cri_y + 2*$fluxW +(2*$b-1)*$PbW + ($b-1)*2*$ScW;
    my $Z = $shZ;
    my $Pb_x = $cri_x + 2*$fluxW + $b*2*$PbW + ($b-1)*2*$ScW;
    my $Pb_z = $cri_z + 2*$fluxW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$Pb_x*cm $PbW*cm $Pb_z*cm";
    $detector{"material"}    = "G4_Pb";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);

    $detector{"name"}        = "Pb_L$b\_bottom";
    $detector{"description"} = "Pb_L$b\_bottom";
    $X = $shX;
    $Y = $shY  - $cri_y - 2*$fluxW -(2*$b-1)*$PbW - ($b-1)*2*$ScW;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$Pb_x*cm $PbW*cm $Pb_z*cm";
    print_det(\%configuration, \%detector);
    
    $detector{"name"}        = "Pb_L$b\_left";
    $detector{"description"} = "Pb_L$b\_left";
    $X = $shX + $cri_x + 2*$fluxW +(2*$b-1)*$PbW + ($b-1)*2*$ScW;
    $Y = $shY;
    $Z = $shZ;
    my $Pb_y = $cri_y + 2*$fluxW + ($b-1)*2*$PbW + ($b-1)*2*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$PbW*cm $Pb_y*cm $Pb_z*cm";
    print_det(\%configuration, \%detector);
    
    $detector{"name"}        = "Pb_L$b\_right";
    $detector{"description"} = "Pb_L$b\_right";
    $X = $shX - $cri_x - 2*$fluxW -(2*$b-1)*$PbW - ($b-1)*2*$ScW;
    $Y = $shY;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$PbW*cm $Pb_y*cm $Pb_z*cm";
    print_det(\%configuration, \%detector);
    

    ###########Sc HCAL###########
    #############################
    %detector = init_det();
    $detector{"name"}        = "Sc_L$b\_top";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Sc_L$b\_top";
    $detector{"color"}       = "99ccff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    $X = $shX;
    $Y = $shY  + $cri_y + 2*$fluxW +$b*2*$PbW + (2*$b-1)*$ScW;
    $Z = $shZ;
    my $Sc_x = $cri_x + 2*$fluxW + $b*2*$PbW + $b*2*$ScW;
    my $Sc_z = $cri_z + 2*$fluxW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$Sc_x*cm $ScW*cm $Sc_z*cm";
    $detector{"material"}    = "scintillator";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);
    
    $detector{"name"}        = "Sc_L$b\_bottom";
    $detector{"description"} = "Sc_L$b\_bottom";
    $X = $shX;
    $Y = $shY  - $cri_y - 2*$fluxW -$b*2*$PbW - (2*$b-1)*$ScW;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$Sc_x*cm $ScW*cm $Sc_z*cm";
    print_det(\%configuration, \%detector);
    
    $detector{"name"}        = "Sc_L$b\_left";
    $detector{"description"} = "Sc_L$b\_left";
    $X = $shX + $cri_x + 2*$fluxW +$b*2*$PbW +(2*$b-1)*$ScW;
    $Y = $shY;
    $Z = $shZ;
    my $Sc_y = $cri_y + 2*$fluxW + $b*2*$PbW + ($b-1)*2*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$ScW*cm $Sc_y*cm $Sc_z*cm";
    print_det(\%configuration, \%detector);
    
    $detector{"name"}        = "Sc_L$b\_right";
    $detector{"description"} = "Sc_L$b\_right";
    $X = $shX - $cri_x - 2*$fluxW -$b*2*$PbW -(2*$b-1)*$ScW;
    $Y = $shY;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$ScW*cm $Sc_y*cm $Sc_z*cm";
    print_det(\%configuration, \%detector);
  }
}



sub make_HCAL_B {
  my $b;
  for ( $b = 1 ; $b <= $N_layers_B ; $b++ ){
    #print "b= $b\n";
    
    ###########Pb HCAL###########
    #############################
    my %detector = init_det();
    $detector{"name"}        = "Pb_L$b\_back";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Pb_L$b\_back";
    $detector{"color"}       = "666699";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    my $X = $shX;
    my $Y = $shY;  
    my $Z = $shZ + $cri_z + 2*$fluxW +(2*$b-1)*$PbW + ($b-1)*2*$ScW;
    my $Pb_x = $cri_x + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    my $Pb_y = $cri_y + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$Pb_x*cm $Pb_y*cm $PbW*cm";
    $detector{"material"}    = "G4_Pb";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);

    ###########Sc HCAL###########
    #############################
    %detector = init_det();
    $detector{"name"}        = "Sc_L$b\_back";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Sc_L$b\_back";
    $detector{"color"}       = "99ccff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    $X = $shX;
    $Y = $shY;
    $Z = $shZ+ $cri_z + 2*$fluxW +$b*2*$PbW + (2*$b-1)*$ScW;
    my $Sc_x = $cri_x + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    my $Sc_y = $cri_y + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$Sc_x*cm $Sc_y*cm $ScW*cm";
    $detector{"material"}    = "scintillator";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);
    
  }
}


sub make_outer_flux_LB{
  
  my %detector = init_det();
      
  $detector{"name"}        = "outer_flux_top";
  $detector{"mother"}      = "main_volume";
  $detector{"description"} = "outer_flux_top";
  $detector{"color"}       = "cc00ff";
  $detector{"style"}       = 0;
  $detector{"visible"}     = 1;
  $detector{"type"}        = "Box";
  my $X = $shX;
  my $Y = $shY+ $cri_y+ 3*$fluxW+ $N_layers_L*2*$PbW +$N_layers_L*2*$ScW;
  my $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW;
  #my $Z = $shZ;
  my $Of_x = $cri_x + 2*$fluxW +$N_layers_L*2*$PbW +$N_layers_L*2*$ScW;
  my $Of_z = $cri_z + 2*$fluxW + $N_layers_B*$PbW +$N_layers_B*$ScW;
  #my $Of_z = $cri_z + 2*$fluxW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"rotation"}    = "0*deg 0*deg 0*deg";
  $detector{"dimensions"}  = "$Of_x*cm $fluxW*cm $Of_z*cm";
  $detector{"material"}    = "G4_Galactic";
  $detector{"sensitivity"} = "flux";
  $detector{"hit_type"}    = "flux";
  $detector{"identifiers"} = "id manual 202";
  print_det(\%configuration, \%detector);

  $detector{"name"}        = "outer_flux_bottom";
  $detector{"description"} = "outer_flux_bottom";
  $X = $shX;
  $Y = $shY- $cri_y- 3*$fluxW- $N_layers_L*2*$PbW -$N_layers_L*2*$ScW;
  $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$Of_x*cm $fluxW*cm $Of_z*cm";
  $detector{"identifiers"} = "id manual 205";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "outer_flux_left";
  $detector{"description"} = "outer_flux_left";
  $X = $shX + $cri_x + 3*$fluxW+ $N_layers_L*2*$PbW +$N_layers_L*2*$ScW;
  $Y = $shY;
  $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW;
  my $Of_y = $cri_y + 2*$fluxW +$N_layers_L*2*$PbW +$N_layers_L*2*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$fluxW*cm $Of_y*cm $Of_z*cm";
  $detector{"identifiers"} = "id manual 203";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "outer_flux_right";
  $detector{"description"} = "outer_flux_right";
  $X = $shX - $cri_x - 3*$fluxW- $N_layers_L*2*$PbW -$N_layers_L*2*$ScW;
  $Y = $shY;
  $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$fluxW*cm $Of_y*cm $Of_z*cm";
  $detector{"identifiers"} = "id manual 204";
  print_det(\%configuration, \%detector);

  $detector{"name"}        = "outer_flux_back";
  $detector{"description"} = "outer_flux_back";
  $X = $shX;
  $Y = $shY;
  $Z = $shZ+ $cri_z + 3*$fluxW + $N_layers_B*2*$PbW + $N_layers_B*2*$ScW;
  my $Of_x = $cri_x + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$Of_x*cm $Of_y*cm $fluxW*cm";
  $detector{"identifiers"} = "id manual 206";
  print_det(\%configuration, \%detector);
  
}

sub make_ECAL  {
  make_main_volume();

  make_PbWO4();
  make_inner_flux();

  make_HCAL_L();
  make_outer_flux_LB();

  make_HCAL_B();
}




