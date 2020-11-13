use strict;
use warnings;

our %configuration;

##### ./bdx.pl config_CT.dat ; /GEMC_Mac/gemc/devel-2.6/source/gemc bdx_CT.gcard -USE_GUI=2
###########################################################################################
###########################################################################################
#
# all dimensions are in mm
#


my $degrad = 0.01745329252;
my $cic    = 2.54;


##############################################################################################

###0
sub make_main_volume
    {
     my %detector = init_det();
        
        $detector{"name"}        = "eee_volume";
        $detector{"mother"}      = "root";
        $detector{"description"} = "World";
        $detector{"color"}       = "666666";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        my $X = 0.;
        my $Y = 0.;
        my $Z = 0.;
        
        my $wallthk=15.; # now it's 15cm or 470cm
        my $atticthk=15.; #
        
        my $wallthkmp=30.; # now it's 15cm or 470cm
        my $atticthkmp=15.; #
        
        my $Ymp = 150.;
        
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        my $par1 = 4200;   #in cm
        my $par2 = 2500.;
        my $par3 = 2000.;
        $detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
        $detector{"material"}    = "G4_AIR";
        print_det(\%configuration, \%detector);

     
#######################################
        #######################################
        ###1   detector floor
            $par1 = 300.+$wallthkmp; # 430 cm
            $par2 = 150.+$atticthkmp; # 430 cm
            $par3 = 250.+$wallthkmp; # 500 cm
            my $Y0 = 50.;
            my $p1= $par1-$wallthkmp  ; # 400 cm
            my $p2 =$par2-$atticthkmp ; # 400 cm
            my $p3 =$par3-$wallthkmp ; # 500 cm
        
            my $par1mp = 300.+$wallthkmp;# 500 cm
            my $p1mp = $par1mp -$wallthkmp; #-$wallthk; # 200 cm
            my $par2mp = 150.+$atticthkmp; # 500 cm
            my $p2mp = $par2mp -$atticthkmp; #-$wallthk; # 200 cm
            my $par3mp = 250.+$wallthkmp; # 500 cm
            my $p3mp = $par3mp -$wallthkmp; #-$wallthk; # 200 cm
        
            
            $detector{"name"}        = "eee_real_main_volume0";
            $detector{"mother"}      = "eee_volume";
            $detector{"description"} = "0External room"; #stanza esterna traslata dentro volume
            $detector{"color"}       = "33ffff";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            $X = 0.;
            $Y = $Y0;   #più alto di 50 cm
            $Z = 0.;
            $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$par1mp*cm $par2mp*cm $par3mp*cm";
            $detector{"material"}    = "G4_CONCRETE";
            #$detector{"material"}    = "G4_AIR";
            print_det(\%configuration, \%detector);
            
            
            
            #######################################
        ###2                detector floor
            $detector{"name"}        = "eee_main_volume0";
            $detector{"mother"}      = "eee_real_main_volume0";
            $detector{"description"} = "0concrete walls";#stanza interna traslata dentro stanza esterna
            $detector{"color"}       = "FFFFFF";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            $Y = 0.;
            $detector{"pos"}         = "$X*cm $Y*cm $Z*cm"; #0x 0x 0
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$p1mp*cm $p2mp*cm $p3mp*cm"; #100x 170x 500
            $detector{"material"}    = "G4_AIR";
            print_det(\%configuration, \%detector);

            
            
            ##############################################################
           ###1bis     ### first floor
        
        $detector{"name"}        = "eee_real_main_volume1";
        $detector{"mother"}      = "eee_volume";
        $detector{"description"} = "1External room"; #stanza esterna traslata dentro volume
        $detector{"color"}       = "33ffff";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        my $X1 = -200.;
        $Y = $Y0+ $par2mp*2;   #più alto di 50 cm
        $Z = 0.;
        my $par1mp1 = $par1mp - 90.; #stanza più piccola
        $detector{"pos"}         = "$X1*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$par1mp1*cm $par2mp*cm $par3mp*cm";
        $detector{"material"}    = "G4_CONCRETE";
        #$detector{"material"}    = "G4_AIR";
        print_det(\%configuration, \%detector);
        
        
        
        #######################################
        #######################################
            ###2bis   ### first floor
                $detector{"name"}        = "eee_main_volume1";
                $detector{"mother"}      = "eee_real_main_volume1";
                $detector{"description"} = "1concrete walls";#stanza interna traslata dentro stanza esterna
                $detector{"color"}       = "FFFFFF";
                $detector{"style"}       = 0;
                $detector{"visible"}     = 1;
                $detector{"type"}        = "Box";
                $X1 = 0.;
                $Y = 0.;
                my $p1mp1 = $par1mp1 - $wallthkmp; ; #stanza più piccola
                $detector{"pos"}         = "$X1*cm $Y*cm $Z*cm"; #0x 0x 0
                $detector{"rotation"}    = "0*deg 0*deg 0*deg";
                $detector{"dimensions"}  = "$p1mp1*cm $p2mp*cm $p3mp*cm"; #100x 170x 500
                $detector{"material"}    = "G4_AIR";
                print_det(\%configuration, \%detector);

                
                
                ############################################################
        #######################################
        ###3
             # mother MRPC
             $detector{"name"}        = "eee_real_main_volume";
             $detector{"mother"}      = "eee_main_volume0";
             $detector{"description"} = "External room"; #stanza esterna centrata sugli mrpc dentro atanza interna traslata
             $detector{"color"}       = "FFFFFF";
             $detector{"style"}       = 0;
             $detector{"visible"}     = 0;
             $detector{"type"}        = "Box";
             $X = 0.;
             $Y = -$Y0;   #torna a 0, livello centrale bdx_volume
             $Z = 0.;
             
             $par1 = 150.+$wallthk; # 430 cm
             $par2 = 60.+$atticthk; # 430 cm
             $par3 = 200.+$wallthk; # 500 cm
        
             $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
             $detector{"rotation"}    = "0*deg 0*deg 0*deg";
             $detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
             #$detector{"material"}    = "G4_CONCRETE";
             $detector{"material"}    = "G4_AIR";
             print_det(\%configuration, \%detector);
             
             
             
             #######################################
        
        ###4
             # mother MRPC
             $p1= $par1-$wallthk  ; # 400 cm
             $p2 =$par2-$atticthk ; # 400 cm
             $p3 =$par3-$wallthk ; # 500 cm
             

             $detector{"name"}        = "eee_main_volume";
             $detector{"mother"}      = "eee_real_main_volume";
             $detector{"description"} = "concrete walls";#stanza interna centrata sugli mrpc dentro atanza esterna centrata sugli mrpc
             $detector{"color"}       = "FFFFFF";
             $detector{"style"}       = 0;
             $detector{"visible"}     = 0;
             $detector{"type"}        = "Box";
             $X = 0.;
             $Y = 0.;
             $Z = 0.;
             $detector{"pos"}         = "$X*cm $Y*cm $Z*cm"; #0x 0x 0
             $detector{"rotation"}    = "0*deg 0*deg 0*deg";
             $detector{"dimensions"}  = "$p1*cm $p2*cm $p3*cm"; #150x 60x 200
             $detector{"material"}    = "G4_AIR";
             print_det(\%configuration, \%detector);

             
             
             ############################################################
        ###5 window
                       my $Yw= 0.;
                       my $winthk= $wallthk ; # winthk come wallthk
                       my $winside=120. ; # win distance from attic
                       #Roof on top
                       my $p1w=$par1-$winthk  ; # 700- 500 = 200 cm
                       #$p2 = 100. ;  # 25 cm
                      # $p3 = 200.;  # 167 cm
                       #$p3 =100. ;
                       
                       $X = 0. ;#-(300.+$p1w);  # -500 +200 = - 300 cm
                       my $Zw =  $p3mp + $winthk;# $par2-$wallthk ; #+132; # 650 cm +100
                       #$Y =0. ;
                       
                       $detector{"name"}        = "difi-win";
                       $detector{"mother"}      = "eee_real_main_volume0";
                       $detector{"description"} = "Window";
                       $detector{"color"}       = "ffffff";
                       $detector{"style"}       = 0;
                       $detector{"visible"}     = 1;
                       $detector{"type"}        = "Box";
                       $detector{"pos"}         = "$X*cm $Yw*cm $Zw*cm"; #0x 0x 650
                       $detector{"rotation"}    = "0*deg 0*deg 0*deg";
                       $detector{"dimensions"}  = "$p1w*cm $winside*cm $winthk*cm"; #200x 100 x50
                       $detector{"material"}    = "G4_AIR";
                       #print_det(\%configuration, \%detector);
                       
        ###########################################################
        ###6 window
            
        
        my $Zs = -$Zw ;
                       
                       $detector{"name"}        = "difi-win2";
                       $detector{"mother"}      = "eee_real_main_volume0";
                       $detector{"description"} = "bWindow";
                       $detector{"color"}       = "FFFFFF";
                       $detector{"style"}       = 0;
                       $detector{"visible"}     = 1;
                       $detector{"type"}        = "Box";
                       $detector{"pos"}         = "$X*cm $Yw*cm $Zs*cm"; #0x 0x 650
                       $detector{"rotation"}    = "0*deg 0*deg 0*deg";
                       $detector{"dimensions"}  = "$p1w*cm $winside*cm $winthk*cm"; #200x 100 x50
                       $detector{"material"}    = "G4_AIR";
                      # print_det(\%configuration, \%detector);
                       
    ###########################################################
    ###5bis window 1st floor
    
        $Yw= 0.;
   
            $detector{"name"}        = "1difi-win";
            $detector{"mother"}      = "eee_real_main_volume1";
            $detector{"description"} = "Window";
            $detector{"color"}       = "ffffff";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
             $detector{"type"}        = "Box";
             $detector{"pos"}         = "$X*cm $Yw*cm $Zw*cm"; #0x 0x 650
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$p1w*cm $winside*cm $winthk*cm"; #200x 100 x50
            $detector{"material"}    = "G4_AIR";
            #print_det(\%configuration, \%detector);
                                   
    ###########################################################
        ###6bis  window 1st floor
            $Yw= 0.;
      #  my $Zs1 = -$Zw ;
            $detector{"name"}        = "1difi-win2";
            $detector{"mother"}      = "eee_real_main_volume1";
            $detector{"description"} = "bWindow";
            $detector{"color"}       = "FFFFFF";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            $detector{"pos"}         = "$X*cm $Yw*cm $Zs*cm"; #0x 0x 650
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$p1w*cm $winside*cm $winthk*cm"; #200x 100 x50
            $detector{"material"}    = "G4_AIR";
         #   print_det(\%configuration, \%detector);
        

##############################
       # Concrete   ROOF
    ##############################
        ###5
        #$Y= 200.;
        
         my $roofthk= 30. ; # #sopra il solaio
         my $roofhigh =200.+ $atticthkmp; # roof distance from right  on the valley side
        my $roofside= $par1mp/2. ; # +traslazione
         # #Roof on top
        $X = 0.;
        $Y = 0.;   #a livello
        $Z = 0.;
        $X1 = -200.;
        #$par2mp = 150.+$atticthkmp; # 180 cm
       # my $Irthk = 100.;
     #   my $Xr = - 150. -$wallthk ; #spostato a sinistra
      #  my $par1r = $roofside;
        my $Yr =$Y + $roofhigh + $Y0+ $par2mp*2 - $atticthk ; #sopra il solaio del 1st piano
        my $par1r = $roofside; # diverse dim solaio
        my $par2r = $roofthk;
       # my $par3r = $par1r*2.; # spostato a sinistra diverse dim solaio commentare per uguali

        
        $detector{"name"}        = "Roof";
        $detector{"mother"}      = "eee_volume";
        $detector{"description"} = "floor";
        $detector{"color"}       = "FFFFFF"; #00AA1F"; #<-green A05070"; #
        $detector{"style"}       = 1;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        # $detector{"pos"}         = "$Xr*cm $Yr*cm $Z*cm"; #
        $detector{"pos"}         = "$X1*cm $Yr*cm $Z*cm"; # 0x -105x 200
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
      #  $detector{"dimensions"}  = "$par1mp*cm $par2r*cm $par3mp*cm"; # uguali dim solaio
        $detector{"dimensions"}  = "$par1mp1*cm $par2r*cm $par3mp*cm"; # diverse dim solaio
        $detector{"material"}    = "G4_CONCRETE";
        #$detector{"material"}    = "G4_Fe";
        print_det(\%configuration, \%detector);
 
        
###########################################################
        
        ###6
           #fake mountain on one side
          #  $Y =0. ;
           my $pX1= 1400.  ; #lungo x
           my $pX2= 800.  ; #lungo x
           my $pY = 800.;   #lungo Y
           my $pZ1 = 1100.;   #lungo Y
           my $pZ2 =600. ;  #lungo Z
           
           $detector{"name"}        = "mountain";
           $detector{"mother"}      = "eee_volume";
           $detector{"description"} = "mountain";
           $detector{"color"}       = "7A641B";
           $detector{"style"}       = 1;
           $detector{"visible"}     = 1;
           $detector{"type"}        = "Trd";

           
           $X= -$par1- $pX1 +110. ;
           $Y =-100.+$p2/2 ;
           $Z =0. ;
           $detector{"pos"}         = "$X*cm $Y*cm $Z*cm"; # -2100x -292,5x 0
           $detector{"rotation"}    = "90*deg 0*deg 0*deg";
           $detector{"dimensions"}  = "$pX1*cm $pX2*cm $pZ1*cm $pZ2*cm $pY*cm"; # 1600x900 1100x1100 x 500
           $detector{"material"}    = "G4_CONCRETE";
          print_det(\%configuration, \%detector);
                
######################################################

######################################################
        
    }


##########################################
# eee ASTRO
##########################################
# eee ASTRO
# starting from 0,0,0 define the different shifts
my $shX=0.;
my $shY=0.;
my $shZ=0.;

my $shifty=17./2.; # vertical plane semi-distance
my $shiftLong=1.; # distance between long bars
my $shiftShort=42.5/2; # position of the short bars
# ASTRO flux



sub make_eee_ASTRO
{
    my %detector = init_det();
    if ($configuration{"variation"} eq "CT")
    {$detector{"mother"}      = "eee_main_volume";}
    else
    {$detector{"mother"}      = "Det_house_inner";}
    
    $detector{"name"}        = "astro_ltf";
    $detector{"description"} = "bar long top front";
    $detector{"color"}       = "333fff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    my $csi_pad_lx =2*4/2.;
    my $csi_pad_ly =2.0/2 ;
    my $csi_pad_lz =60./2 ; # TO BE CHECKED
    my $X = 0.;
    my $Y = $shifty;
    my $Z = $csi_pad_lx+$shiftLong;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 90*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_lx*cm $csi_pad_ly*cm $csi_pad_lz*cm";
    $detector{"material"}    = "ScintillatorB";
    $detector{"sensitivity"} = "veto";
    $detector{"hit_type"}    = "veto";
    $detector{"identifiers"} = "sector manual 0 veto manual 1100 channel manual 1";
     print_det(\%configuration, \%detector);
##############################################################
    $detector{"name"}        = "astro_ltb";
    $detector{"description"} = "bar long top back";
    $detector{"type"}        = "Box";
    $Z = -$csi_pad_lx-$shiftLong;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 90*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_lx*cm $csi_pad_ly*cm $csi_pad_lz*cm";
    $detector{"identifiers"} = "sector manual 0 veto manual 1100 channel manual 2";
     print_det(\%configuration, \%detector);
##############################################################
    $detector{"name"}        = "astro_lbf";
    $detector{"description"} = "bar long  bottom front";
    $detector{"color"}       = "ff8000";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    $X = 0.;
    $Y = -$shifty;
    $Z = $csi_pad_lx+$shiftLong;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 90*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_lx*cm $csi_pad_ly*cm $csi_pad_lz*cm";
    $detector{"material"}    = "ScintillatorB";
    $detector{"sensitivity"} = "veto";
    $detector{"hit_type"}    = "veto";
    $detector{"identifiers"} = "sector manual 0 veto manual 1100 channel manual 3";
    print_det(\%configuration, \%detector);
##############################################################
    $detector{"name"}        = "astro_lbb";
    $detector{"description"} = "bar long bottom back";
    $detector{"type"}        = "Box";
    $Z = -$csi_pad_lx-$shiftLong;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 90*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_lx*cm $csi_pad_ly*cm $csi_pad_lz*cm";
    $detector{"identifiers"} = "sector manual 0 veto manual 1100 channel manual 4";
    print_det(\%configuration, \%detector);
##############################################################
    
    $detector{"name"}        = "astro_stl";
    $detector{"description"} = "bar short top left";
    $detector{"color"}       = "33ffff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    my $csi_pad_sx =2*4/2.;
    my $csi_pad_sy =2.0/2 ;
    my $csi_pad_sz =18./2 ; # TO BE CHECKED
    $X= -$shiftShort;
    $Y = $shifty+$csi_pad_sy+$csi_pad_ly;
    $Z = 0.;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_sx*cm $csi_pad_sy*cm $csi_pad_sz*cm";
    $detector{"material"}    = "ScintillatorB";
    $detector{"sensitivity"} = "veto";
    $detector{"hit_type"}    = "veto";
    $detector{"identifiers"} = "sector manual 1 veto manual 1100 channel manual 1";
    print_det(\%configuration, \%detector);
##############################################################
    $detector{"name"}        = "astro_str";
    $detector{"description"} = "bar short top right";
    $detector{"color"}       = "33ffff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    $X = $shiftShort;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_sx*cm $csi_pad_sy*cm $csi_pad_sz*cm";
    $detector{"material"}    = "ScintillatorB";
    $detector{"sensitivity"} = "veto";
    $detector{"hit_type"}    = "veto";
    $detector{"identifiers"} = "sector manual 1 veto manual 1100 channel manual 2";
    print_det(\%configuration, \%detector);
##############################################################
    $detector{"name"}        = "astro_sbl";
    $detector{"description"} = "bar short bottom left";
    $detector{"color"}       = "33ffff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    $X = -$shiftShort;
    $Y = -$shifty+$csi_pad_sy+$csi_pad_ly;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_sx*cm $csi_pad_sy*cm $csi_pad_sz*cm";
    $detector{"material"}    = "ScintillatorB";
    $detector{"sensitivity"} = "veto";
    $detector{"hit_type"}    = "veto";
    $detector{"identifiers"} = "sector manual 1 veto manual 1100 channel manual 3";
    print_det(\%configuration, \%detector);
##############################################################
    $detector{"name"}        = "astro_sbr";
    $detector{"description"} = "bar short bottom right";
    $detector{"color"}       = "33ffff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    $X = $shiftShort;
    $Y = -$shifty+$csi_pad_sy+$csi_pad_ly;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$csi_pad_sx*cm $csi_pad_sy*cm $csi_pad_sz*cm";
    $detector{"material"}    = "ScintillatorB";
    $detector{"sensitivity"} = "veto";
    $detector{"hit_type"}    = "veto";
    $detector{"identifiers"} = "sector manual 1 veto manual 1100 channel manual 4";
    print_det(\%configuration, \%detector);
##############################################################

}

sub make_astro_flux
{
    # starting from 0,0,0 define the different shifts
    my $shX=0.;
    my $shY=0.;
    my $shZ=0.;
    
    #my $shifty=25./2.; # vertical plane semi-distance
    #my $shiftLong=1.; # distance between long bars
    #my $shiftShort=42.5/2; # distance between long bars
    
    my $csi_pad_lx =2*4/2.;
    my $csi_pad_ly =2.0/2 ;
    my $csi_pad_lz =60./2 ; # TO BE CHECKED

    my %detector = init_det();

    my $par1 = $csi_pad_lz;
    my $par2 = 0.01;
    my $parz3 =$csi_pad_lx;

    my $X = 0.;
    my $Y = $shifty-$csi_pad_ly-$par2;
    my $Z = $csi_pad_lx+$shiftLong;
    
    
    $detector{"name"}        = "flux_astro_top";
    $detector{"mother"}      = "eee_main_volume";
    $detector{"description"} = "ASTRO flux detector";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$par1*cm $par2*cm $parz3*cm";
    $detector{"material"}    = "G4_AIR";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 8000";
    print_det(\%configuration, \%detector);
##############################################################
    %detector = init_det();
    
    $X = 0.;
    $Y = -$shifty-$csi_pad_ly-$par2;
    $Z = $csi_pad_lx+$shiftLong;

    
    $detector{"name"}        = "flux_astro_bottom";
    $detector{"mother"}      = "eee_main_volume";
    $detector{"description"} = "ASTRO flux detector";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$par1*cm $par2*cm $parz3*cm";
    $detector{"material"}    = "G4_AIR";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 8001";
    print_det(\%configuration, \%detector);
    

}

##########################################
# eee chambers


# starting from 0,0,0 define the different shifts
$shX=0.;
$shY=0.;
$shZ=0.;

my $AlBar_h=5/2.;
my $AlBar_l=4/2.;
my $AlBar_longside=220/2.;
my $AlBar_shortside=92/2.;
my $AlBar_th=0.4/2.;


my $AlCover_th=0.2/2.;
my $AlCover_long=200/2.;
my $AlCover_short=100/2.;

my $Honey_th=1.5/2.;
my $Honey_long=180/2.;
my $Honey_short=90/2.;

my $Vetronite_th=0.15/2.;

my $Strip_long=158./2.; #cm 
my $Strip_size=2.5/2.;
my $Strip_gap=0.7/2.;
my $Strip_th=0.05/2.;

my $Mylar_th=0.0175/2.;

my $GlassL_th=0.2/2.;
my $GlassL_long=160/2.;
my $GlassL_short=85/2.;

my $GlassS_th=0.15/2.;
my $GlassS_long=158/2.;
my $GlassS_short=82/2.;

my $Fishline_th=0.0250/2;

my $chmbrs_distance=50.; # prima 44 cm

sub make_eee_MRPC
{
    
    for(my $ia=0; $ia<3; $ia++)
    { my $deltaz=($ia-1)*$chmbrs_distance; # num.ch*50
        
        my %detector = init_det();
        if ($configuration{"variation"} eq "CT")
        {$detector{"mother"}      = "eee_main_volume";}
        else
        {$detector{"mother"}      = "Det_house_inner";}
        #starting  honeycomb
        $detector{"name"}        = "eee_honey_bottom_$ia";
        $detector{"description"} = "eee honey bottom of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        my $X = 0.;
        my $Y = $deltaz-$AlBar_h+$Honey_th; #50-(5- 1.5)/2 = 48,25
        my $Z =0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$Honey_short*cm $Honey_th*cm $Honey_long*cm";
        $detector{"material"}    = "AlHoneycomb";
        print_det(\%configuration, \%detector);
##############################################################
        #estarting vetro
        $detector{"name"}        = "eee_vetro_bottom_$ia";
        $detector{"description"} = "eee vetro bottom of chmbr $ia";
        $detector{"color"}       = "00AA1F";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h+2*$Honey_th+$Vetronite_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$Honey_short*cm $Vetronite_th*cm $Honey_long*cm";
        $detector{"material"}    = "Vetronite-G10";
        print_det(\%configuration, \%detector);
##############################################################
        #ending vetro
        
        #Fake cu strips on vetronite plan
        for(my $im=0; $im<24; $im++)
        {   my $offset=(2*$Honey_short-23*($Strip_size+$Strip_gap)*2-2*$Strip_size)/2.;
            my $X = -$Honey_short+$offset+$im*($Strip_size+$Strip_gap)*2+($Strip_size+$Strip_gap);
            my $Y = $Vetronite_th-$Strip_th;
            my $Z = 0.;
            #print "SSSSSSSSSSSSSSSSSSSS","\n";
            #print $offset,"\n";
            #print $Honey_short,"\n";
            #print $X,"\n";
            $detector{"name"}        = "eee_StripBottom_$im"."_"."$ia";
            $detector{"mother"}      = "eee_vetro_bottom_$ia";
            $detector{"description"} = "eee strip bottom $im of chmbr $ia";
            $detector{"color"}       = "0000AA";
            $detector{"style"}       = 1;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$Strip_size*cm $Strip_th*cm $Strip_long*cm";
            $detector{"material"}    = "G4_Cu";
            $detector{"sensitivity"} = "eee_veto"; # Active materiato mimic the ionization charge on vetronite/strips
            $detector{"hit_type"}    = "eee_veto";  # STRIPS==1
            my $id_man=1000+$ia;
            $detector{"identifiers"} = "sector manual 1 veto manual $id_man channel manual $im";
            # my $id=100+$im;
            # $detector{"identifiers"} = "id manual $id";# bottom strip 100-123
            # $detector{"sensitivity"} = "veto"; # Active materiato mimic the ionization charge on vetronite/strips
            # $detector{"hit_type"}    = "veto";
            print_det(\%configuration, \%detector);
##############################################################
            $detector{"name"}        = "eee_StripGapBottom_$im"."_"."$ia";
            $detector{"description"} = "eee strip gap bottom $im of chmr $ia";
            $detector{"color"}       = "0000AF";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
            my $Xgap=$X+$Strip_size+$Strip_gap;
            $detector{"type"}        = "Box";
            $detector{"pos"}         = "$Xgap*cm $Y*cm $Z*cm";
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$Strip_gap*cm $Strip_th*cm $Strip_long*cm";
            $detector{"material"}    = "G4_Cu";
            # my $id=150+$im;
            # $detector{"identifiers"} = "id manual $id";# bottom strip 150-172 (ignore the last)
            # $detector{"sensitivity"} = "flux";
            # $detector{"hit_type"}    = "flux";
            $detector{"sensitivity"} = "eee_veto"; # Active materiato mimic the ionization charge on vetronite/strips
            $detector{"hit_type"}    = "eee_veto"; # GAPS==2
            $detector{"identifiers"} = "sector manual 2 veto manual $id_man channel manual $im";
            if ($im ne "23") {print_det(\%configuration, \%detector);}
            
        }
        # End cu strips
        
        #Starting Mylar
        $detector{"name"}        = "eee_mylar_bottom_$ia";
        $detector{"mother"}      = "eee_main_volume";
        $detector{"description"} = "eee mylar bottom of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h+2*$Honey_th+2*$Vetronite_th+$Mylar_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$Honey_short*cm $Mylar_th*cm $Honey_long*cm";
        $detector{"material"}    = "eee_mylar";
        $detector{"identifiers"} = "no";
        $detector{"sensitivity"} = "no";
        $detector{"hit_type"}    = "no";
        print_det(\%configuration, \%detector);
##############################################################
        #ending Mylar
        #Starting Glass
        $detector{"name"}        = "eee_glassL_bottom_$ia";
        $detector{"description"} = "eee glass large bottom of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h+2*$Honey_th+2*$Vetronite_th+2*$Mylar_th+$GlassL_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$GlassL_short*cm $GlassL_th*cm $GlassL_long*cm";
        $detector{"material"}    = "G4_Pyrex_Glass";
        print_det(\%configuration, \%detector);
##############################################################
        
        my $shift_glass=0.;
        for(my $im=0; $im<5; $im++)
        {
            my $deltaY=($im+1)*2*$Fishline_th+$im*2*$GlassS_th;
            $detector{"name"}        = "eee_glassS_$im"."_"."$ia";
            $detector{"description"} = "eee glass small $im of chmbr $ia";
            $detector{"color"}       = "0000FF";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            my $X = 0.;
            my $Y = $deltaz-$AlBar_h+2*$Honey_th+2*$Vetronite_th+2*$Mylar_th+2*$GlassL_th+$GlassS_th+$deltaY;
            my $Z = 0.;
            $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$GlassS_short*cm $GlassS_th*cm $GlassS_long*cm";
            $detector{"material"}    = "G4_Pyrex_Glass";
            print_det(\%configuration, \%detector);
##############################################################
            $shift_glass=$deltaY+2*$GlassS_th
        }
        $detector{"name"}        = "eee_glassL_top_$ia";
        $detector{"description"} = "eee glass large top of chmbr $ia";
        $detector{"color"}       = "A05070";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h+2*$Honey_th+2*$Vetronite_th+2*$Mylar_th+2*$GlassL_th+$shift_glass+2*$Fishline_th+$GlassL_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$GlassL_short*cm $GlassL_th*cm $GlassL_long*cm";
        $detector{"material"}    = "G4_Pyrex_Glass";
        print_det(\%configuration, \%detector);
        
        #ending Glass
        #Starting Mylar
        $detector{"name"}        = "eee_mylar_top_$ia";
        $detector{"description"} = "eee mylar top of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h+2*$Honey_th+2*$Vetronite_th+2*$Mylar_th+2*$GlassL_th+$shift_glass+2*$Fishline_th+2*$GlassL_th+$Mylar_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$Honey_short*cm $Mylar_th*cm $Honey_long*cm";
        $detector{"material"}    = "eee_mylar";
        print_det(\%configuration, \%detector);
##############################################################
        #ending Mylar
        #ending vetro
        $detector{"name"}        = "eee_vetro_top_$ia";
        $detector{"description"} = "eee vetro top of chmbr $ia";
        $detector{"color"}       = "00AA1F";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h+2*$Honey_th+2*$Vetronite_th+2*$Mylar_th+2*$GlassL_th+$shift_glass+2*$Fishline_th+2*$GlassL_th+2*$Mylar_th+$Vetronite_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$Honey_short*cm $Vetronite_th*cm $Honey_long*cm";
        $detector{"material"}    = "Vetronite-G10";
        print_det(\%configuration, \%detector);
##############################################################
        #ending vetro
        
        #Fake cu strips on vetronite plan
        for(my $im=0; $im<24; $im++)
        {   my $offset=(2*$Honey_short-23*($Strip_size+$Strip_gap)*2-2*$Strip_size)/2.;
            my $X = -$Honey_short+$offset+$im*($Strip_size+$Strip_gap)*2+($Strip_size+$Strip_gap);
            my $Y = -($Vetronite_th-$Strip_th);
            my $Z = 0.;
            #print "SSSSSSSSSSSSSSSSSSSS","\n";
            #print $offset,"\n";
            #print $Honey_short,"\n";
            #print $X,"\n";
            $detector{"name"}        = "eee_StripTop_$im"."_"."$ia";
            $detector{"mother"}      = "eee_vetro_top_$ia";
            $detector{"description"} = "eee strip top $im of chmbr $ia";
            $detector{"color"}       = "0000AA";
            $detector{"style"}       = 1;
            $detector{"visible"}     = 1;
            $detector{"type"}        = "Box";
            $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$Strip_size*cm $Strip_th*cm $Strip_long*cm";
            $detector{"material"}    = "G4_Cu";
            $detector{"sensitivity"} = "flux";
            $detector{"hit_type"}    = "flux";
            my $id=$ia*1000+200+$im;
            $detector{"identifiers"} = "id manual $id";# top strip 200-223
            print_det(\%configuration, \%detector);
##############################################################
            $detector{"name"}        = "eee_StripGapTop_$im"."_"."$ia";
            $detector{"description"} = "eee strip gap top $im of chmbr $ia";
            $detector{"color"}       = "0000AF";
            $detector{"style"}       = 0;
            $detector{"visible"}     = 1;
            my $Xgap=$X+$Strip_size+$Strip_gap;
            $detector{"type"}        = "Box";
            $detector{"pos"}         = "$Xgap*cm $Y*cm $Z*cm";
            $detector{"rotation"}    = "0*deg 0*deg 0*deg";
            $detector{"dimensions"}  = "$Strip_gap*cm $Strip_th*cm $Strip_long*cm";
            $detector{"material"}    = "G4_Cu";
            $detector{"sensitivity"} = "flux";
            $detector{"hit_type"}    = "flux";
            $id=$ia*1000+250+$im;
            $detector{"identifiers"} = "id manual $id";# top strip 250-272 (ignore the last)
            if ($im ne "23") {print_det(\%configuration, \%detector);}
            
        }
        # End cu strips
        
        
        
        #starting  honeycomb
        $detector{"name"}        = "eee_honey_top_$ia";
        $detector{"mother"}      = "eee_main_volume";
        $detector{"description"} = "eee honey top of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h+2*$Honey_th+2*$Vetronite_th+2*$Mylar_th+2*$GlassL_th+$shift_glass+2*$Fishline_th+2*$GlassL_th+2*$Mylar_th+2*$Vetronite_th+$Honey_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$Honey_short*cm $Honey_th*cm $Honey_long*cm";
        $detector{"material"}    = "AlHoneycomb";
        $detector{"identifiers"} = "no";
        $detector{"sensitivity"} = "no";
        $detector{"hit_type"}    = "no";
        print_det(\%configuration, \%detector);
##############################################################
        #ending honey
        
        
        
        #Starting  external frame
        $detector{"name"}        = "eee_box_top_$ia";
        $detector{"description"} = "eee Al box top of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz+$AlBar_h+$AlCover_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$AlCover_short*cm $AlCover_th*cm $AlCover_long*cm";
        $detector{"material"}    = "G4_Al";
        print_det(\%configuration, \%detector);
##############################################################
        
        $detector{"name"}        = "eee_box_bottom_$ia";
        $detector{"description"} = "eee Al box bottom of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz-$AlBar_h-$AlCover_th;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$AlCover_short*cm $AlCover_th*cm $AlCover_long*cm";
        $detector{"material"}    = "G4_Al";
        print_det(\%configuration, \%detector);
##############################################################
        
        $detector{"name"}        = "eee_box_bar_side1_$ia";
        $detector{"mother"}      = "eee_main_volume";
        $detector{"description"} = "eee Al box side bar1 of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = $AlBar_shortside+$AlBar_l;
        $Y = $deltaz;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$AlBar_l*cm $AlBar_h*cm $AlBar_longside*cm";
        $detector{"material"}    = "G4_Al";
        print_det(\%configuration, \%detector);
##############################################################
        $detector{"name"}        = "eee_box_bar_side_air1_$ia";
        $detector{"mother"}      = "eee_box_bar_side1_$ia";
        $detector{"description"} = "eee Al box side bar_air1 of chmbr $ia";
        $detector{"color"}       = "A05070";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        my $dX = $AlBar_l-$AlBar_th;
        my $dY = $AlBar_h-2*$AlBar_th;
        my $dZ = $AlBar_longside;
        $X = $AlBar_th;
        $Y = 0.;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$dX*cm $dY*cm $dZ*cm";
        $detector{"material"}    = "G4_AIR";
        print_det(\%configuration, \%detector);
##############################################################
        
        $detector{"name"}        = "eee_box_bar_side2_$ia";
        $detector{"mother"}      = "eee_main_volume";
        $detector{"description"} = "eee Al box side bar2 of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = -($AlBar_shortside+$AlBar_l);
        $Y = $deltaz;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$AlBar_l*cm $AlBar_h*cm $AlBar_longside*cm";
        $detector{"material"}    = "G4_Al";
        print_det(\%configuration, \%detector);
##############################################################
        $detector{"name"}        = "eee_box_bar_side_air2_$ia";
        $detector{"mother"}      = "eee_box_bar_side2_$ia";
        $detector{"description"} = "eee Al box side bar_air2 of chmbr $ia";
        $detector{"color"}       = "A05070";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $dX = $AlBar_l-$AlBar_th;
        $dY = $AlBar_h-2*$AlBar_th;
        $dZ = $AlBar_longside;
        $X = -$AlBar_th;
        $Y = 0.;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$dX*cm $dY*cm $dZ*cm";
        $detector{"material"}    = "G4_AIR";
        print_det(\%configuration, \%detector);
##############################################################
        
        $detector{"name"}        = "eee_box_bar_side3_$ia";
        $detector{"mother"}      = "eee_main_volume";
        $detector{"description"} = "eee Al box side bar3 of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz;
        $Z = $AlBar_longside-$AlBar_l-10.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$AlBar_shortside*cm $AlBar_h*cm $AlBar_l*cm";
        $detector{"material"}    = "G4_Al";
        print_det(\%configuration, \%detector);
##############################################################
        $detector{"name"}        = "eee_box_bar_side_air3_$ia";
        $detector{"mother"}      = "eee_box_bar_side3_$ia";
        $detector{"description"} = "eee Al box side bar_air3 of chmbr $ia";
        $detector{"color"}       = "A05070";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $dX = $AlBar_shortside;
        $dY = $AlBar_h-2*$AlBar_th;
        $dZ = $AlBar_l-$AlBar_th;
        $X = 0.;
        $Y =0.;
        $Z = 0.;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$dX*cm $dY*cm $dZ*cm";
        $detector{"material"}    = "G4_AIR";
        print_det(\%configuration, \%detector);
##############################################################
        
        $detector{"name"}        = "eee_box_bar_side4_$ia";
        $detector{"mother"}      = "eee_main_volume";
        $detector{"description"} = "eee Al box side bar4 of chmbr $ia";
        $detector{"color"}       = "0000FF";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $X = 0.;
        $Y = $deltaz;
        $Z = -($AlBar_longside-$AlBar_l-10.);
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$AlBar_shortside*cm $AlBar_h*cm $AlBar_l*cm";
        $detector{"material"}    = "G4_Al";
        print_det(\%configuration, \%detector);
##############################################################
        $detector{"name"}        = "eee_box_bar_side_air4_$ia";
        $detector{"mother"}      = "eee_box_bar_side4_$ia";
        $detector{"description"} = "eee Al box side bar_air4 of chmbr $ia";
        $detector{"color"}       = "A05070";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $dX = $AlBar_shortside;
        $dY = $AlBar_h-2*$AlBar_th;
        $dZ = $AlBar_l-$AlBar_th;
        $X = 0.;
        $Y = 0.;
        $Z = -$AlBar_th;
        $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $detector{"dimensions"}  = "$dX*cm $dY*cm $dZ*cm";
        $detector{"material"}    = "G4_AIR";
        print_det(\%configuration, \%detector);
##############################################################
        #Ending external frame
        
        
    }
}

# eee chamber flux
sub make_eee_MRPC_flux
{
    my %detector = init_det();
    
    my $X = 0.;
    my $Y = -0*$chmbrs_distance-$AlBar_h-1.0;
    my $Z = 0.;
    
    
    my $par1 = 0.;
    my $par2 = 600/2;
    my $par3 = 0.1/2;
    my $par4 = 0.;
    my $par5 = 360.;
    
    
    $detector{"name"}        = "eee_MRPC_flux";
    $detector{"mother"}      = "eee_main_volume";
    $detector{"description"} = "MRPC flux detector";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Tube";
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "90*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm $par4*deg $par5*deg";
    $detector{"material"}    = "G4_AIR";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"material"}    = "G4_AIR";
    $detector{"identifiers"} = "id manual 7000";
    print_det(\%configuration, \%detector);
##############################################################
}


sub make_flux_cosmic_sph
{
    my %detector = init_det();
    my $cosmicradius=150.;

    my $X = $shX + 0. ;
    my $Y = $shY  -50. ;
    my $Z = $shZ +  0.;
    
    my $par1 = $cosmicradius;
    my $par2 = $cosmicradius+0.01;
    my $parz3 = 0.;
    my $par4 = 360.;
    my $par5 = 0.;
    my $par6 = 90.;
    
    $detector{"name"}        = "flux_cosmic_sph";
    $detector{"mother"}      = "eee_main_volume";
    $detector{"description"} = "Beamdump flux detector";
    $detector{"color"}       = "cc00ff";
    $detector{"style"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Sphere";
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "90*deg 0*deg 0*deg";
    $detector{"dimensions"}  = "$par1*cm $par2*cm $parz3*cm $par4*deg $par5*deg $par6*deg";
    $detector{"material"}    = "G4_AIR";
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 1001";
    print_det(\%configuration, \%detector);
##############################################################
    
}



# END eee chambers
################################


sub make_eee_CT
{
    make_main_volume();
    make_eee_MRPC;
    #make_eee_MRPC_flux;
    #make_astro_flux;
    #make_eee_ASTRO;
    #make_flux_cosmic_sph;
}








1;

