use strict;
use warnings;

our %configuration;


my $degrad = 0.01745329252;
my $cic    = 2.54;


my $BDXmini_externalBox_X = 100;
my $BDXmini_externalBox_Y = 100;
my $BDXmini_externalBox_Z = 100;



sub make_poker_main_volume
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
    
    my $par1 = 100.;
    my $par2 = 100.;
    my $par3 = 100.;

    $detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
    $detector{"material"}    = "G4_Galactic";
    print_det(\%configuration, \%detector);
}
    my $Nx = 10;                          # Number of crystals in horizontal directions
    my $Ny = 10;                          # Number of crystals in vertical directions
    my $Nz =4;                            # Number of layers in z directions.
    my $detPWO_Width = 20.;               # Crystal width in mm
    my $detPWO_Thickness = 250.;          # Crystal lenght in mm
    my $detPWO_preshower_Thickness = 200.;          # Crystal lenght in mm for the preshower
    my $Wrapping =0;                      # Thickness of the wrapping
    my $AGap =0.0;                          # Air Gap between Crystals
    my $Tot_width  = $detPWO_Width+$Wrapping+$AGap;  # Width of the crystal mother volume, total width of crystal including wrapping and air gap
    my $Tot_thickness =$detPWO_Thickness + $Wrapping; # Thickness of the crystal mother volume, total lenght of crystal including wrapping
    my $Tot_preshower_thickness=$detPWO_preshower_Thickness + $Wrapping;

sub make_ecal
{
    my %detector = init_det();

    my $centX = ( int $Nx/2 )+0.5;
    my $centY = ( int $Ny/2 )+0.5;
    my $centZ = ( int $Nz/2 )+0.5;
    my $y_C =0;
    my $x_C =0;
    my $z_C=0;
    my $dx=0;
    my $dy=0;
    my $dz=0;
    my $iZ=0;
    
    #PRESHOWER
    my $iY =$Ny/2;
    for(my $iZ=1; $iZ<=$Nz-1; $iZ++)
    {
        for(my $iX=1; $iX<=$Nx; $iX++)
        {
            $x_C  =($iX-$centX)*$Tot_width;
            $z_C  =(2*$iZ-1)*$Tot_width/2;
            
            $detector{"name"}        = "Crs_volume"."_"."$iX"."_"."$iY"."_"."$iZ";
            $detector{"mother"}      = "main_volume";
            $detector{"description"} = "PbWO4 crystal mother volume "."$iX"."$iY"."$iZ";
            $detector{"color"}       = "838EDE";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
            $detector{"rotation"}    = "90*deg 0*deg 0*deg";
            $dx =$Tot_width/2 ;
            $dy =$Tot_width/2 ;
            $dz =$Tot_preshower_thickness/2 ;
            $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
            $detector{"material"}    = "G4_Galactic";
            print_det(\%configuration, \%detector);
            
            $detector{"name"}        = "Crs"."_"."$iX"."_"."$iY"."_"."$iZ";
            $detector{"mother"}      = "Crs_volume"."_"."$iX"."_"."$iY"."_"."$iZ";
            $detector{"description"} = "PbWO4 crystal "."$iX"."$iY"."$iZ";
            $detector{"color"}       = "1c86ea";
            $detector{"style"}       = 1;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            $x_C=0;
            $y_C=0;
            $z_C=0;
            $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $dx =$detPWO_Width/2 ;
            $dy =$detPWO_Width/2 ;
            $dz =$detPWO_preshower_Thickness/2 ;
            $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
            $detector{"material"}    = "G4_PbWO4";
            $detector{"sensitivity"} = "poker_crs";
            $detector{"hit_type"}    = "poker_crs";
             my $man=400+2;
            $detector{"identifiers"} = "sector manual $man xch manual $iX ych manual $iY zch manual $iZ ";
            print_det(\%configuration, \%detector);
            
        }
    }
    
    
    
    #ECAL
    $iZ =4;
    for(my $iX=1; $iX<=$Nx; $iX++)
    {
        
    for (my $iY=1; $iY<=$Ny; $iY++){

        $x_C  =($iX-$centX)*$Tot_width;
        $y_C = ($iY-$centY)*$Tot_width;
        $z_C  = ($Nz-1)*$Tot_width + $Tot_thickness/2;
        
        $detector{"name"}        = "Crs_volume"."_"."$iX"."_"."$iY"."_"."$iZ";
        $detector{"mother"}      = "main_volume";
        $detector{"description"} = "PbWO4 crystal mother volume "."$iX"."$iY"."$iZ";
        $detector{"color"}       = "838EDE";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $dx =$Tot_width/2 ;
        $dy =$Tot_width/2 ;
        $dz =$Tot_thickness/2 ;
        $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
        $detector{"material"}    = "G4_Galactic";
        print_det(\%configuration, \%detector);
        
        $detector{"name"}        = "Crs"."_"."$iX"."_"."$iY"."_"."$iZ";
        $detector{"mother"}      = "Crs_volume"."_"."$iX"."_"."$iY"."_"."$iZ";
        $detector{"description"} = "PbWO4 crystal "."$iX"."$iY"."$iZ";
        $detector{"color"}       = "1c86ea";
        $detector{"style"}       = 1;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $x_C=0;
        $y_C=0;
        $z_C=0;
        $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $dx =$detPWO_Width/2 ;
        $dy =$detPWO_Width/2 ;
        $dz =$detPWO_Thickness/2 ;
        $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
        $detector{"material"}    = "G4_PbWO4";
        $detector{"sensitivity"} = "poker_crs";
        $detector{"hit_type"}    = "poker_crs";
         my $man=400+3;
        $detector{"identifiers"} = "sector manual $man xch manual $iX ych manual $iY zch manual $iZ ";
        print_det(\%configuration, \%detector);
        
        
    }
    }
}

sub make_flux
{

     my %detector = init_det();
 
    #flux top 
    $detector{"name"}        = "flux_top";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "flux top";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    
    my $X = 0.; 
    my $Y = ($Ny/2)*$Tot_width;
    my $Z = (($Nz-1)*$Tot_width + $Tot_thickness)/2;
    $detector{"pos"}         = "$X*mm $Y*mm $Z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    
    my $par1 = $Nx*$Tot_width/2;
    my $par2 = 1/2;
    my $par3 = (($Nz-1)*$Tot_width + $Tot_thickness)/2;

    $detector{"dimensions"}  = "$par1*mm $par2*mm $par3*mm";
    $detector{"material"}    = "G4_Galactic";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 101";
    print_det(\%configuration, \%detector);

    # flux bottom

    $detector{"name"}        = "flux_bottom";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "flux bottom";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    
     $X = 0.; 
     $Y = -($Ny/2)*$Tot_width;
     $Z = (($Nz-1)*$Tot_width + $Tot_thickness)/2;
    $detector{"pos"}         = "$X*mm $Y*mm $Z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    
     $par1 = $Nx*$Tot_width/2;
     $par2 = 1/2;
     $par3 = (($Nz-1)*$Tot_width + $Tot_thickness)/2;

    $detector{"dimensions"}  = "$par1*mm $par2*mm $par3*mm";
    $detector{"material"}    = "G4_Galactic";       
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 102";
    print_det(\%configuration, \%detector);

 
    #flux left 
    $detector{"name"}        = "flux_left";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "flux left";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    
     $X = -($Nx/2)*$Tot_width;
     $Y = 0.;
     $Z = (($Nz-1)*$Tot_width + $Tot_thickness)/2;
    $detector{"pos"}         = "$X*mm $Y*mm $Z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 90*deg";
    
     $par1 = $Nx*$Tot_width/2;
     $par2 = 1/2;
     $par3 = (($Nz-1)*$Tot_width + $Tot_thickness)/2;

    $detector{"dimensions"}  = "$par1*mm $par2*mm $par3*mm";
    $detector{"material"}    = "G4_Galactic";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
 $detector{"identifiers"} = "id manual 103";
    print_det(\%configuration, \%detector);

   # flux right 
    $detector{"name"}        = "flux_right";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "flux right";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    
     $X = ($Nx/2)*$Tot_width;
     $Y = 0.;
     $Z = (($Nz-1)*$Tot_width + $Tot_thickness)/2;
    $detector{"pos"}         = "$X*mm $Y*mm $Z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 90*deg";
    
     $par1 = $Nx*$Tot_width/2;
     $par2 = 1/2;
     $par3 = (($Nz-1)*$Tot_width + $Tot_thickness)/2;

    $detector{"dimensions"}  = "$par1*mm $par2*mm $par3*mm";
    $detector{"material"}    = "G4_Galactic";    
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 104";
    print_det(\%configuration, \%detector);

   # flux downstream 
    $detector{"name"}        = "flux_downstream";
    $detector{"mother"}      = "main_volume";
    $detector{"description"} = "flux downstream";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    
     $X = 0.;
     $Y = 0.;
     $Z = (($Nz-1)*$Tot_width + $Tot_thickness);
    $detector{"pos"}         = "$X*mm $Y*mm $Z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    
     $par1 = $Nx*$Tot_width/2;
     $par2 = $Ny*$Tot_width/2;
     $par3 = 1/2;

    $detector{"dimensions"}  = "$par1*mm $par2*mm $par3*mm";
    $detector{"material"}    = "G4_Galactic";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 105";
    print_det(\%configuration, \%detector);

}


sub make_poker
{
    make_poker_main_volume();
    make_ecal();
    make_flux();
}




1;

