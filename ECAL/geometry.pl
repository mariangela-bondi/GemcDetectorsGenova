use strict;
use warnings;

our %configuration;


###########################################################################################
###########################################################################################
#
# all dimensions are in mm
#



#################################################################################################
sub make_main_volume
  {
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
    
    
    my $par1 = 600.;
    my $par2 = 400.;
    my $par3 = 600.;
    $detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
    $detector{"material"}    = "G4_Galactic";
    print_det(\%configuration, \%detector);

  }


  

  
  ##########################################
  ##########################################
  # Scintillator
  # starting from 0,0,0 define the different shifts
  my $shX=0.;
  my $shY=0.;
  my $shZ=0.;

  my $cri_x=10/2.;
  my $cri_y=10/2.;
  ##my $cri_z=17.8/2; ## 20 X0
  my $cri_z=35.6/2; ## 40 X0
  ##my $cri_z=53.4/2; ## 60 X0
  ##my $cri_x=20/2.; Dimensione trasversa è okkk
  ##my $cri_y=20/2.;
  my $fluxW = 0.1/2;
  
  sub make_PbWO4
    {
      
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



    sub make_Flux {

     
      my %detector = init_det();
      
      $detector{"name"}        = "flux_back";
      $detector{"mother"}      = "main_volume";
      $detector{"description"} = "flux_back";
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
     
      %detector = init_det();
      $detector{"name"}        = "flux_top";
      $detector{"mother"}      = "main_volume";
      $detector{"description"} = "flux_top";
      $detector{"type"}        = "Box";
      $X = $shX;
      $Y = $shY  + $cri_y + $fluxW;
      $Z = $shZ;
      $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$cri_x*cm $fluxW*cm $cri_z*cm";
      $detector{"material"}    = "G4_Galactic";
      $detector{"sensitivity"} = "flux";
      $detector{"hit_type"}    = "flux";
      $detector{"identifiers"} = "id manual 102";
      print_det(\%configuration, \%detector);

     
      %detector = init_det();
      $detector{"name"}        = "flux_bottom";
      $detector{"mother"}      = "main_volume";
      $detector{"description"} = "flux_bottom";
      $detector{"type"}        = "Box";
      $X = $shX;
      $Y = $shY  - $cri_y - $fluxW;
      $Z = $shZ;
      $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$cri_x*cm $fluxW*cm $cri_z*cm";
      $detector{"material"}    = "G4_Galactic";
      $detector{"sensitivity"} = "flux";
      $detector{"hit_type"}    = "flux";
      $detector{"identifiers"} = "id manual 105";
      print_det(\%configuration, \%detector);

     
      %detector = init_det();
      $detector{"name"}        = "flux_left";
      $detector{"mother"}      = "main_volume";
      $detector{"description"} = "flux_left";
      $detector{"type"}        = "Box";
      $X = $shX + $cri_x + $fluxW;
      $Y = $shY;
      $Z = $shZ;
      $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$fluxW*cm $cri_y*cm $cri_z*cm";
      $detector{"material"}    = "G4_Galactic";
      $detector{"sensitivity"} = "flux";
      $detector{"hit_type"}    = "flux";
      $detector{"identifiers"} = "id manual 103";
      print_det(\%configuration, \%detector);

      %detector = init_det();
      $detector{"name"}        = "flux_right";
      $detector{"mother"}      = "main_volume";
      $detector{"description"} = "flux_right";
      $detector{"type"}        = "Box";
      $X = $shX - $cri_x - $fluxW;
      $Y = $shY;
      $Z = $shZ;
      $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$fluxW*cm $cri_y*cm $cri_z*cm";
      $detector{"material"}    = "G4_Galactic";
      $detector{"sensitivity"} = "flux";
      $detector{"hit_type"}    = "flux";
      $detector{"identifiers"} = "id manual 104";
      print_det(\%configuration, \%detector);

   
      %detector = init_det();
      $detector{"name"}        = "flux_front";
      $detector{"mother"}      = "main_volume";
      $detector{"description"} = "flux_front";
      $detector{"type"}        = "Box";
      $X = $shX;
      $Y = $shY;
      $Z = $shZ - $cri_z - $fluxW;;
      $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
      $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      $detector{"dimensions"}  = "$cri_x*cm $cri_y*cm $fluxW*cm";
      $detector{"material"}    = "G4_Galactic";
      $detector{"sensitivity"} = "flux";
      $detector{"hit_type"}    = "flux";
      $detector{"identifiers"} = "id manual 101";
      print_det(\%configuration, \%detector);

      
   
      
    }
    


    sub make_ECAL
      {
	make_main_volume();
	make_PbWO4();
	make_Flux();
      }




