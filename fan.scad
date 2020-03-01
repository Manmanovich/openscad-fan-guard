//written by Michiel Brink
//fridgefire@irc.freenode.net

//length fan,distance hole,circle diameter
    //25,20,
    //30,24,
    //40,33,
    //50,40,
    //60,50,
    //70,60,
    //80,70,86
    //90,83,100
    //120,105,130
    //140,125,150
//Choose a size of your fan
FanLength =  80;//[25,30,40,50,60,70,80,90,100,120,140]
FanCutType       = 1;// [0:Hole, 1:Circles, 2:Holes]
FanCutSrewHoleSize = 4.8; 


//Size circle cut. Used if "Circles" cut chosen
FanCirclesCutThickness = 5;
//Size circle cut distance. Used if "Circles" cut chosen
FanCirclesCutDistance = 5;
//Size circle cut croses. Used if "Circles" cut chosen
FanCirclesCutCrossThickness = 5;
//Holes cut size . Used if "Holes" cut chosen
FanHolesCutDiameter = 5;
//Holes cut size . Used if "Holes" cut chosen
FanHolesCutDistance = 2;

//Want yours? Uncomment below, comment if else system 
//FanHoleDistance = 70;
FanHoleDistance = FanLength == 25  ? 20 : 
                 (FanLength == 25  ? 20 :
                 (FanLength == 30  ? 24 :
                 (FanLength == 40  ? 33 :
                 (FanLength == 50  ? 40 :
                 (FanLength == 60  ? 50 :
                 (FanLength == 70  ? 60 :
                 (FanLength == 80  ? 70 :
                 (FanLength == 90  ? 83 :
                 (FanLength == 100  ? 90 :
                 (FanLength == 120 ? 105:125))))))))));
FanDiameter = FanLength+6;
//diameter = 86;

intersection() {
    fanHole();

    //choose one effect:
    if(FanCutType == 0)  {none();}
	else if(FanCutType == 1)  {FanCirclesEffect();}
	else if(FanCutType == 2)  {FanHolesCut();}
	
}

FanScrewHoles();

module fanHole() {
    intersection() {
        translate([-FanLength/2,-FanLength/2]){
            square([FanLength,FanLength],0);
        }
        circle(FanDiameter/2,$fn=0);
    }
}

module FanScrewHoles() {
    translate([FanHoleDistance/2,FanHoleDistance/2]){
            circle(FanCutSrewHoleSize/2,$fn=0);
        }
    translate([-FanHoleDistance/2,FanHoleDistance/2]){
            circle(FanCutSrewHoleSize/2,$fn=0);
        }
    translate([-FanHoleDistance/2,-FanHoleDistance/2]){
            circle(FanCutSrewHoleSize/2,$fn=0);
        }
    translate([FanHoleDistance/2,-FanHoleDistance/2]){
            circle(FanCutSrewHoleSize/2,$fn=0);
        }
}

module FanCirclesEffect() {
    //circles
    for (x = [0:FanCirclesCutDistance*2:60]) {
        difference() {
            circle(x+FanCirclesCutThickness,$fn=0);
            circle(x,$fn=0);
        }
    }
    //cross
    rotate([0,0,45]){
        translate([-FanCirclesCutCrossThickness/2,-FanLength/2]){
            square([FanCirclesCutCrossThickness,FanLength],0);
         }
        translate([-FanLength/2,-FanCirclesCutCrossThickness/2]){
            square([FanLength,FanCirclesCutCrossThickness],0);
         }
     }
}

module FanHolesCut() {
    for (x = [0:FanHolesCutDiameter+FanHolesCutDistance:FanLength]) {
        for (y = [FanHolesCutDiameter:FanHolesCutDiameter+FanHolesCutDistance*2:FanLength]) {
            translate([x-FanLength/2,y-FanLength/2]){
                circle((FanHolesCutDiameter/2),$fn=0);
            }
            translate([x-FanHolesCutDistance/2-FanHolesCutDiameter/2-FanLength/2,y-FanHolesCutDistance-FanHolesCutDiameter/2-FanLength/2]){
                circle(FanHolesCutDiameter/2,$fn=0);
            }
        }
    }
}
