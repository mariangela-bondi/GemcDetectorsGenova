use strict;
use warnings;
use POSIX;


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

# Crystal PbWO4 total volume 
my $cri_x=10/2.;
my $cri_y=10/2.;
my $cri_z=17.8/2; ## 20 X0
#my $cri_z=35.6/2; ## 40 X0
#my $cri_z=53.4/2; ## 60 X0

my $cri_h=0.5/2.;   ## hole 
my $cri_h_z=1.78/2; ## 2 X0

my $cri_N_x=1;
my $cri_N_y=1;

if(($cri_N_x%2==0)||($cri_N_y%2==0)){
    print "ERROR: cri_N_x and cri_N_y must be positive and odd numbers!!!\n";
    return 0;
}

# Flux Detector
my $fluxW = 0.1/2;
#my $fluxW = 10./2;

#HCAL
my $N_layers_L = 5;
my $N_layers_B = 13;
my $N_layers_F = 3;

my $PbW = 0.8/2;
#my $PbW = 0.2/2;
my $ScW = 1.2/2;
#my $ScW = 0.3/2;

my $HCAL_h=2/2.;


sub make_PbWO4{

  my %detector = init_det();
  $detector{"mother"}      = "main_volume";
  $detector{"name"}        = "PbWO4_M";
  $detector{"description"} = "PbWO4_M";
  $detector{"color"}       = "e6f2ff";
  $detector{"style"}       = 0;
  $detector{"visible"}     = 1;
  $detector{"type"}        = "Box";
  my $X = $shX;
  my $Y = $shY;
  my $Z = $shZ;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"rotation"}    = "0*deg 0*deg 0*deg";
  $detector{"dimensions"}  = "$cri_x*cm $cri_y*cm $cri_z*cm";
  $detector{"material"}    = "G4_Galactic";
  $detector{"sensitivity"} = "no"; 
  $detector{"hit_type"}    = "no";
  $detector{"identifiers"} = "no";
  print_det(\%configuration, \%detector);

  my $cri_dx= $cri_x/$cri_N_x;
  my $cri_dy= $cri_y/$cri_N_y;
  my $xch;
  my $ych; 
  for($xch = 1 ; $xch <= $cri_N_x ; $xch++ ){
      for($ych = 1 ; $ych <= $cri_N_y ; $ych++ ){
	  
	  %detector = init_det();
	  $detector{"name"}        = "PbWO4_X$xch\_Y$ych";
	  $detector{"mother"}      = "PbWO4_M";
	  $detector{"description"} = "PbWO4_X$xch\_Y$ych";
	  $detector{"color"}       = "ff8000";
	  $detector{"style"}       = 0;
	  $detector{"visible"}     = 1;
	  $detector{"type"}        = "Box";  
	  $X = $cri_dx*(-$cri_N_x + 2*$xch -1);
	  $Y = $cri_dy*(-$cri_N_y + 2*$ych -1);
	  $Z =0;
	  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	  $detector{"rotation"}    = "0*deg 0*deg 0*deg";	  
	  $detector{"dimensions"}  = "$cri_dx*cm $cri_dy*cm $cri_z*cm";
	  $detector{"material"}    = "G4_PbWO4";
	  $detector{"sensitivity"} = "JPOS_crs"; 
	  $detector{"hit_type"}    = "JPOS_crs";
	  $detector{"identifiers"} = "sector manual 1234 xch manual $xch ych manual $ych";
	  print_det(\%configuration, \%detector);

	  if(($xch == ceil($cri_N_x/2)) && ($ych == ceil($cri_N_y/2))){

	      %detector = init_det();
	      $detector{"name"}        = "PbWO4_hole";
	      $detector{"mother"}      = "PbWO4_X$xch\_Y$ych";
	      $detector{"description"} = "PbWO4_hole";
	      $detector{"color"}       = "666666";
	      $detector{"style"}       = 1;
	      $detector{"visible"}     = 1;
	      $detector{"type"}        = "Box";  
	      $X = 0;
	      $Y = 0;  
	      $Z = - $cri_z + $cri_h_z;
	      $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
	      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	      $detector{"dimensions"}  = "$cri_h*cm $cri_h*cm $cri_h_z*cm";
	      $detector{"material"}    = "G4_Galactic";
	      $detector{"sensitivity"} = "no";
	      $detector{"hit_type"}    = "no";
	      $detector{"identifiers"} = "no";
	      print_det(\%configuration, \%detector);
	  }
      }
  }
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
    $detector{"name"}        = "Pb_S2_L$b";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Pb_top_L$b";
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

    $detector{"name"}        = "Pb_S5_L$b";
    $detector{"description"} = "Pb_bottom_L$b";
    $X = $shX;
    $Y = $shY  - $cri_y - 2*$fluxW -(2*$b-1)*$PbW - ($b-1)*2*$ScW;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$Pb_x*cm $PbW*cm $Pb_z*cm";
    print_det(\%configuration, \%detector);
    
    $detector{"name"}        = "Pb_S3_L$b";
    $detector{"description"} = "Pb_left_L$b";
    $X = $shX + $cri_x + 2*$fluxW +(2*$b-1)*$PbW + ($b-1)*2*$ScW;
    $Y = $shY;
    $Z = $shZ;
    my $Pb_y = $cri_y + 2*$fluxW + ($b-1)*2*$PbW + ($b-1)*2*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$PbW*cm $Pb_y*cm $Pb_z*cm";
    print_det(\%configuration, \%detector);
    
    $detector{"name"}        = "Pb_S4_L$b";
    $detector{"description"} = "Pb_right_L$b";
    $X = $shX - $cri_x - 2*$fluxW -(2*$b-1)*$PbW - ($b-1)*2*$ScW;
    $Y = $shY;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"dimensions"}  = "$PbW*cm $Pb_y*cm $Pb_z*cm";
    print_det(\%configuration, \%detector);
    

    ###########Sc HCAL###########
    #############################
    %detector = init_det();
    $detector{"name"}        = "Sc_S2_L$b";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Sc_top_L$b";
    $detector{"color"}       = "e6f2ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    $X = $shX;
    $Y = $shY  + $cri_y + 2*$fluxW +$b*2*$PbW + (2*$b-1)*$ScW;
    $Z = $shZ;
    my $Sc_x = $cri_x + 2*$fluxW + $b*2*$PbW + $b*2*$ScW;
    my $Sc_z = $cri_z + 2*$fluxW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";   
    if ($b%2==0){
      $detector{"rotation"}    = "0*deg 90*deg 0*deg";
      $detector{"dimensions"}  = "$Sc_z*cm $ScW*cm $Sc_x*cm";
      make_tile_XZ($Sc_x,$Sc_z,2,$b);
    }
    else {
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$Sc_x*cm $ScW*cm $Sc_z*cm";
      make_tile_XZ($Sc_z,$Sc_x,2,$b);
    }    
    $detector{"material"}    = "G4_Galactic";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);

    
    $detector{"name"}        = "Sc_S5_L$b";
    $detector{"description"} = "Sc_bottom_L$b";
    $X = $shX;
    $Y = $shY  - $cri_y - 2*$fluxW -$b*2*$PbW - (2*$b-1)*$ScW;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    if ($b%2==0){
      $detector{"rotation"}    = "0*deg 90*deg 0*deg";
      $detector{"dimensions"}  = "$Sc_z*cm $ScW*cm $Sc_x*cm";
      make_tile_XZ($Sc_x,$Sc_z,5,$b);
    }
    else {
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$Sc_x*cm $ScW*cm $Sc_z*cm";
      make_tile_XZ($Sc_z,$Sc_x,5,$b);
    } 
    print_det(\%configuration, \%detector);

    
    $detector{"name"}        = "Sc_S3_L$b";
    $detector{"description"} = "Sc_left_L$b";
    $X = $shX + $cri_x + 2*$fluxW +$b*2*$PbW +(2*$b-1)*$ScW;
    $Y = $shY;
    $Z = $shZ;
    my $Sc_y = $cri_y + 2*$fluxW + $b*2*$PbW + ($b-1)*2*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    if ($b%2==0){
      $detector{"rotation"}    = "-90*deg 0*deg -90*deg";
      $detector{"dimensions"}  = "$Sc_z*cm $ScW*cm $Sc_y*cm";
      make_tile_XZ($Sc_y,$Sc_z,3,$b);
    }
    else {
      $detector{"rotation"}    = "0*deg 0*deg -90*deg";
      $detector{"dimensions"}  = "$Sc_y*cm $ScW*cm $Sc_z*cm";
      make_tile_XZ($Sc_z,$Sc_y,3,$b);
    } 
    print_det(\%configuration, \%detector);

    
    $detector{"name"}        = "Sc_S4_L$b";
    $detector{"description"} = "Sc_right_L$b";
    $X = $shX - $cri_x - 2*$fluxW -$b*2*$PbW -(2*$b-1)*$ScW;
    $Y = $shY;
    $Z = $shZ;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    if ($b%2==0){
      $detector{"rotation"}    = "-90*deg 0*deg -90*deg";
      $detector{"dimensions"}  = "$Sc_z*cm $ScW*cm $Sc_y*cm";
      make_tile_XZ($Sc_y,$Sc_z,4,$b);
    }
    else {
      $detector{"rotation"}    = "0*deg 0*deg -90*deg";
      $detector{"dimensions"}  = "$Sc_y*cm $ScW*cm $Sc_z*cm";
      make_tile_XZ($Sc_z,$Sc_y,4,$b);
    } 
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
    $detector{"name"}        = "Pb_S6_L$b";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Pb_back_L$b";
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
    $detector{"name"}        = "Sc_S6_L$b";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Sc_back_L$b";
    $detector{"color"}       = "e6f2ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    $X = $shX;
    $Y = $shY;
    $Z = $shZ+ $cri_z + 2*$fluxW +$b*2*$PbW + (2*$b-1)*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    my $Sc_x = $cri_x + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    my $Sc_y = $cri_y + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    
    if ($b%2==0){
      $detector{"rotation"}    = "0*deg 0*deg 90*deg";
      $detector{"dimensions"}  = "$Sc_y*cm $Sc_x*cm $ScW*cm";
      make_tile_XY($Sc_y,$Sc_x,6,$b);
    }
    else {
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$Sc_x*cm $Sc_y*cm $ScW*cm";
      make_tile_XY($Sc_x,$Sc_y,6,$b); 
    }
    
    $detector{"material"}    = "G4_Galactic";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);

    
  }
}

sub make_HCAL_F{
  my $b;
  for ( $b = 1 ; $b <= $N_layers_F ; $b++ ){
    #print "b= $b\n";
    
    ###########Pb HCAL###########
    #############################
    my %detector = init_det();
    $detector{"name"}        = "Pb_S1_L$b";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Pb_front_L$b";
    $detector{"color"}       = "666699";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    my $X = $shX;
    my $Y = $shY;  
    my $Z = $shZ - $cri_z - 2*$fluxW -(2*$b-1)*$PbW - ($b-1)*2*$ScW;
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

    %detector = init_det();
    $detector{"name"}        = "Pb_S1_L$b\_hole";
    $detector{"mother"}      = "Pb_S1_L$b";
    $detector{"description"} = "Pb_front_L$b\_hole";
    $detector{"color"}       = "666666";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    $X = 0;
    $Y = 0;  
    $Z = 0;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$HCAL_h*cm $HCAL_h*cm $PbW*cm";
    $detector{"material"}    = "G4_Galactic";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);
    

    ###########Sc HCAL###########
    #############################
    %detector = init_det();
    $detector{"name"}        = "Sc_S1_L$b";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "Sc_front_L$b";
    $detector{"color"}       = "e6f2ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";  
    $X = $shX;
    $Y = $shY;
    $Z = $shZ - $cri_z - 2*$fluxW - $b*2*$PbW - (2*$b-1)*$ScW;
    my $Sc_x = $cri_x + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    my $Sc_y = $cri_y + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";  
    if($b%2==0){
      $detector{"rotation"}    = "0*deg 0*deg 90*deg";
      $detector{"dimensions"}  = "$Sc_y*cm $Sc_x*cm $ScW*cm";
      make_tile_XY($Sc_y,$Sc_x,1,$b);
    }
    else{
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$Sc_x*cm $Sc_y*cm $ScW*cm";
      make_tile_XY($Sc_x,$Sc_y,1,$b); 
    }
    $detector{"material"}    = "G4_Galactic";
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);   
  }
}



sub make_outer_flux{
  
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
  my $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW - $N_layers_F*$PbW -$N_layers_F*$ScW;
  #my $Z = $shZ;
  my $Of_x = $cri_x + 2*$fluxW +$N_layers_L*2*$PbW +$N_layers_L*2*$ScW;
  my $Of_z = $cri_z + 2*$fluxW + $N_layers_B*$PbW +$N_layers_B*$ScW + $N_layers_F*$PbW +$N_layers_F*$ScW;
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
  $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW - $N_layers_F*$PbW -$N_layers_F*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$Of_x*cm $fluxW*cm $Of_z*cm";
  $detector{"identifiers"} = "id manual 205";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "outer_flux_left";
  $detector{"description"} = "outer_flux_left";
  $X = $shX + $cri_x + 3*$fluxW+ $N_layers_L*2*$PbW +$N_layers_L*2*$ScW;
  $Y = $shY;
  $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW - $N_layers_F*$PbW -$N_layers_F*$ScW;
  my $Of_y = $cri_y + 2*$fluxW +$N_layers_L*2*$PbW +$N_layers_L*2*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$fluxW*cm $Of_y*cm $Of_z*cm";
  $detector{"identifiers"} = "id manual 203";
  print_det(\%configuration, \%detector);
  
  $detector{"name"}        = "outer_flux_right";
  $detector{"description"} = "outer_flux_right";
  $X = $shX - $cri_x - 3*$fluxW- $N_layers_L*2*$PbW -$N_layers_L*2*$ScW;
  $Y = $shY;
  $Z = $shZ+ $N_layers_B*$PbW +$N_layers_B*$ScW - $N_layers_F*$PbW -$N_layers_F*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$fluxW*cm $Of_y*cm $Of_z*cm";
  $detector{"identifiers"} = "id manual 204";
  print_det(\%configuration, \%detector);

  $detector{"name"}        = "outer_flux_back";
  $detector{"description"} = "outer_flux_back";
  $X = $shX;
  $Y = $shY;
  $Z = $shZ+ $cri_z + 3*$fluxW + $N_layers_B*2*$PbW + $N_layers_B*2*$ScW;
  $Of_x = $cri_x + 2*$fluxW + $N_layers_L*2*$PbW + $N_layers_L*2*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$Of_x*cm $Of_y*cm $fluxW*cm";
  $detector{"identifiers"} = "id manual 206";
  print_det(\%configuration, \%detector);

  $detector{"name"}        = "outer_flux_front";
  $detector{"description"} = "outer_flux_front";
  $X = $shX;
  $Y = $shY;
  $Z = $shZ- $cri_z - 3*$fluxW - $N_layers_F*2*$PbW - $N_layers_F*2*$ScW;
  $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
  $detector{"dimensions"}  = "$Of_x*cm $Of_y*cm $fluxW*cm";
  $detector{"identifiers"} = "id manual 201";
  print_det(\%configuration, \%detector);
  
}



sub make_tile_XY{
  my $nt = floor(2*$_[1]/5);
  
  if($nt%2==0){
    $nt++;
  }
  my $dt = $_[1]/$nt;
  #print "$_[0] $_[1] $_[2] $nt $dt \n";

  my $sector = $_[2];
  my $layer = $_[3];
  my $channel;

  my $hc = ceil($nt/2);
  
  
  for ( $channel = 1 ; $channel <= $nt ; $channel++ ){
    #print "Sc_L$layer\_$sector\_$channel \n";
    my %detector = init_det();
    $detector{"name"}        = "Sc_S$sector\_L$layer\_$channel";
    $detector{"mother"}      = "Sc_S$sector\_L$layer";
    $detector{"description"} = "Sc_S$sector\_L$layer\_$channel";
    $detector{"color"}       = "99ccff";
    $detector{"style"}       = 1;
    if($channel%2==0){
      $detector{"visible"}     = 1;
    }
    else{
      $detector{"visible"}     = 0;
    }
    $detector{"type"}        = "Box";  
    my $X = 0;
    my $Y = - $_[1] +  (2*$channel-1)*$dt  ;
    my $Z = 0;
   
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$_[0]*cm $dt*cm $ScW*cm";
    $detector{"material"}    = "ScintillatorB";

    $detector{"sensitivity"} = "JPOS_HCAL";
    $detector{"hit_type"}    = "JPOS_HCAL";
    $detector{"identifiers"} = "sector manual $sector layer manual $layer channel manual $channel";
    print_det(\%configuration, \%detector);

    if(($sector == 1) && ($channel == $hc)){
      #print "$sector $hc \n";
      %detector = init_det();
      $detector{"name"}        = "Sc_S1_L$layer\_hole";
      $detector{"mother"}      = "Sc_S1_L$layer\_$channel";
      $detector{"description"} = "Sc_front_L$layer\_hole";
      $detector{"color"}       = "666666";
      $detector{"style"}       = 1;
      $detector{"visible"}     = 1;
      $detector{"type"}        = "Box";  
      $X = 0;
      $Y = 0;  
      $Z = 0;
      $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$HCAL_h*cm $HCAL_h*cm $ScW*cm";
      $detector{"material"}    = "G4_Galactic";
      $detector{"sensitivity"} = "no";
      $detector{"hit_type"}    = "no";
      $detector{"identifiers"} = "no";
      print_det(\%configuration, \%detector);
    }   
  } 
}


sub make_tile_XZ{
  my $nt = floor(2*$_[1]/5);
  
  if($nt%2==0){
    $nt++;
  }
  my $dt = $_[1]/$nt;
  #print "$_[0] $_[1] $_[2] $nt $dt \n";

  my $sector = $_[2];
  my $layer = $_[3];
  my $channel;
  
  for ( $channel = 1 ; $channel <= $nt ; $channel++ ){
    #print "Sc_L$layer\_$sector\_$channel \n";
    my %detector = init_det();
    $detector{"name"}        = "Sc_S$sector\_L$layer\_$channel";
    $detector{"mother"}      = "Sc_S$sector\_L$layer";
    $detector{"description"} = "Sc_S$sector\_L$layer\_$channel";
    $detector{"color"}       = "99ccff";
    $detector{"style"}       = 1;
    if($channel%2==0){
      $detector{"visible"}     = 1;
    }
    else{
      $detector{"visible"}     = 0;
    }
    $detector{"type"}        = "Box";  
    my $X =  - $_[1] +  (2*$channel-1)*$dt  ;
    my $Y = 0;
    my $Z = 0;
   
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$dt*cm $ScW*cm $_[0]*cm";
    $detector{"material"}    = "ScintillatorB";

    $detector{"sensitivity"} = "JPOS_HCAL";
    $detector{"hit_type"}    = "JPOS_HCAL";
    $detector{"identifiers"} = "sector manual $sector layer manual $layer channel manual $channel";
    print_det(\%configuration, \%detector); 
  } 
}






sub make_ECAL  {
  make_main_volume();

  make_PbWO4();
  make_inner_flux();

  make_HCAL_L();
  make_outer_flux();
  make_HCAL_B();
  make_HCAL_F();
}




