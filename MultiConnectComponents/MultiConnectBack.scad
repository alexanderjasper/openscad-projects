/*
    This code was lifted from the Git Hub repository for MuliConnectOpenSCAD
    for use in my own projects. I have hard coded some of the configuration
    variables
    
    Source -
    https://github.com/cschneid/MultiConnectOpenSCAD
*/

module multiconnectBack(
  backWidth,
  backHeight,
  distanceBetweenSlots = 25,
  slotQuickRelease = false,
  dimpleScale = 1, //[0.5:.05:1.5]
  slotTolerance = 1.00, //[0.925:0.005:1.075] Scale the size of slots in the back (1.015 scale is default for a tight fit. Increase if your finding poor fit.)
  slotDepthMicroadjustment = 0.05, //[-.5:0.05:.5] Move the slot in (positive) or out (negative)
  onRampEnabled = true, //[true, false]
  onRampEveryXSlots = 1 //frequency of slots for on-ramp. 1 = every slot; 2 = every 2 slots; etc.
) {
  //slot count calculates how many slots can fit on the back. Based on internal width for buffer. 
  //slot width needs to be at least the distance between slot for at least 1 slot to generate
  let (backWidth = max(backWidth, distanceBetweenSlots), backHeight = max(backHeight, 25), slotCount = floor(backWidth / distanceBetweenSlots), backThickness = 6.5) {
    difference() {
      translate(v=[0, -backThickness, 0]) cube(size=[backWidth, backThickness, backHeight]);
      //Loop through slots and center on the item
      //Note: I kept doing math until it looked right. It's possible this can be simplified.
      for (slotNum = [0:1:slotCount - 1]) {
        translate(v=[distanceBetweenSlots / 2 + (backWidth / distanceBetweenSlots - slotCount) * distanceBetweenSlots / 2 + slotNum * distanceBetweenSlots, -2.35 + slotDepthMicroadjustment, backHeight - 13]) {
          slotTool(backHeight);
        }
      }
    }
  }
  //Create Slot Tool
  module slotTool(totalHeight) {
    scale(v=slotTolerance)
    //slot minus optional dimple with optional on-ramp
    let (slotProfile = [[0, 0], [10.15, 0], [10.15, 1.2121], [7.65, 3.712], [7.65, 5], [0, 5]])
    difference() {
      union() {
        //round top
        rotate(a=[90, 0, 0])
          rotate_extrude($fn=50)
            polygon(points=slotProfile);
        //long slot
        translate(v=[0, 0, 0])
          rotate(a=[180, 0, 0])
            linear_extrude(height=totalHeight + 1)
              union() {
                polygon(points=slotProfile);
                mirror([1, 0, 0])
                  polygon(points=slotProfile);
              }
        //on-ramp
        if (onRampEnabled)
          for (y = [1:onRampEveryXSlots:totalHeight / distanceBetweenSlots])
            translate(v=[0, -5, -y * distanceBetweenSlots])
              rotate(a=[-90, 0, 0])
                cylinder(h=5, r1=12, r2=10.15);
      }
      //dimple
      if (slotQuickRelease == false)
        scale(v=dimpleScale)
          rotate(a=[90, 0, 0])
            rotate_extrude($fn=50)
              polygon(points=[[0, 0], [0, 1.5], [1.5, 0]]);
    }
  }
}
