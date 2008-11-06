// Show_All_LUTs
// This macro displays, as a montage, all the LUTs in the luts folder.
// Author:  Jerome Mutterer

// A 'luts' folder with 68 LUT files is available at
// <http://rsb.info.nih.gov/ij/download/luts/luts.zip>

  saveSettings();
  lutdirname="luts";
  lutdir=getDirectory("startup")+lutdirname+File.separator;
  if (!File.exists(lutdir))
     exit("The 'luts' folder not found in the ImageJ folder");
  list = getFileList(lutdir);
  setBatchMode(true); // runs 40x faster in batch mode!
  newImage("ramp", "8-bit Ramp", 256, 32, 1);
  newImage("luts", "RGB White", 256, 48, 1);
  count = 0;
  setForegroundColor(255, 255, 255);
  setBackgroundColor(255, 255, 255);
  for (i=0; i<list.length; i++) {
      if (endsWith(list[i], ".lut")) {
          selectWindow("ramp");
          open(lutdir+list[i]);
          run("Select All");
          run("Copy");
          selectWindow("luts");
          makeRectangle(0, 0, 256, 32);
          run("Paste");
          setJustification("center");
          setColor(0, 0, 0);
          drawString(list[i],128, 48);
          run("Add Slice");
          count++;
      }
  }
  run("Delete Slice");
  rows = floor(count/4);
  if (rows<count/4) rows++;
  run("Make Montage...", "columns=4 rows="+rows
  +" scale=1 first=1 last="+count+" increment=1 border=1 use");
  rename(lutdir+"montage");
  setBatchMode(false);
  restoreSettings();
