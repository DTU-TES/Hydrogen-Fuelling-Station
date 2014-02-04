within ;
package HydrogenRefuelingCoolProp "Final hydrogen library used for PhD thesis"
  model HRSInfo "Sets the parameters for the fueling based on J2601"
  //Decideds the average pressure ramp rate, final pressure in HSS,
  //final state of charge and temperature out of the fueling station based on J2601
  //using ambient temperature, starting pressure in HSS and refueling protocol as input
  import SI =
            Modelica.SIunits;
    /*************************************************/
    /*General parameters*/
    /*************************************************/
  parameter Integer Fueling_protocol=1 "Fueling protocol" annotation (choices(
  choice=1 "A70 1-7 kg",
   choice=2 "A70 7-10 kg",
  choice=3 "A35",
  choice=4 "B70 1-7 kg",
   choice=5 "B70 7-10 kg",
   choice=6 "B35",
   choice=7 "C35",
   choice=8 "D35"));
  parameter SI.Temperature T_amb=293 "Ambient temperature";
  parameter SI.Pressure P_amb=101000 "Ambient pressure";
  parameter SI.Pressure P_start=2e6 "Start pressure i the HSS";
    /*************************************************/
    /*APRR*/
    /*************************************************/

    Real T=T_amb;
    Real P=P_start;
    Real  T_cool;
    Real APRR;

    SI.Pressure FP;
    Real SOC;
    SI.Pressure P_ref;
    Real APRR_1;
    SI.Pressure FP_1;
    Real SOC_1;
    Real APRR_2;
    SI.Pressure FP_2;
    Real SOC_2;
    Real APRR_3;
    SI.Pressure FP_3;
    Real SOC_3;
    Real APRR_4;
    SI.Pressure FP_4;
    Real SOC_4;
    Real APRR_5;
    SI.Pressure FP_5;
    Real SOC_5;
    Real APRR_6;
    SI.Pressure FP_6;
    Real SOC_6;
    Real APRR_7;
    SI.Pressure FP_7;
    Real SOC_7;
    Real APRR_8;
    SI.Pressure FP_8;
    Real SOC_8;

    /*************************************************/
    /*Consstants from SAE*/
    /*************************************************/
  constant SI.Temperature T1=273.15-40;
  constant SI.Temperature T2=273.15-20;
  constant SI.Temperature T3=273.15;

  constant SI.Pressure P_ref1=70e6;
  constant SI.Pressure P_ref2=35e6;

    /*************************************************/
    /*Look up tables for SAE*/
    /*************************************************/
    // A70 1-7 kg
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR1(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_A1",
      fileName="External files/Lookuptables/APRR.mat")
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP1(
      tableOnFile=true,
      tableName="FP_A1",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      fileName=
          "External files/Lookuptables/FP.mat")
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC1(
      tableOnFile=true,
      tableName="SOC_A1",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      fileName=
          "External files/Lookuptables/SOC.mat")
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

    // A70 7-10 kg
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR2(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_A2",
      fileName="External files/Lookuptables/APRR.mat");

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP2(
      tableOnFile=true,
      tableName="FP_A2",
      fileName="External files/Lookuptables/FP.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC2(
      tableOnFile=true,
      tableName="SOC_A2",
      fileName="External files/Lookuptables/SOC.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    // A35
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR3(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_A3",
      fileName="External files/Lookuptables/APRR.mat");

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP3(
      tableOnFile=true,
      tableName="FP_A3",
      fileName="External files/Lookuptables/FP.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC3(
      tableOnFile=true,
      tableName="SOC_A3",
      fileName="External files/Lookuptables/SOC.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    // B70 1-7kg
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR4(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_B1",
      fileName="External files/Lookuptables/APRR.mat");

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP4(
      tableOnFile=true,
      tableName="FP_B1",
      fileName="External files/Lookuptables/FP.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC4(
      tableOnFile=true,
      tableName="SOC_B1",
      fileName="External files/Lookuptables/SOC.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    // B70 7-10kg
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR5(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_B2",
      fileName="External files/Lookuptables/APRR.mat");

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP5(
      tableOnFile=true,
      tableName="FP_B2",
      fileName="External files/Lookuptables/FP.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC5(
      tableOnFile=true,
      tableName="SOC_B2",
      fileName="External files/Lookuptables/SOC.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    // B35
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR6(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_B3",
      fileName="External files/Lookuptables/APRR.mat");

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP6(
      tableOnFile=true,
      tableName="FP_B3",
      fileName="External files/Lookuptables/FP.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC6(
      tableOnFile=true,
      tableName="SOC_B3",
      fileName="External files/Lookuptables/SOC.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    // C35
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR7(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_C1",
      fileName="External files/Lookuptables/APRR.mat");

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP7(
      tableOnFile=true,
      tableName="FP_C1",
      fileName="External files/Lookuptables/FP.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC7(
      tableOnFile=true,
      tableName="SOC_C1",
      fileName="External files/Lookuptables/SOC.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    // D35
    // For the APRR (Average pressure ramprate)
    Modelica.Blocks.Tables.CombiTable1Ds APRR8(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      tableName="APRR_D1",
      fileName="External files/Lookuptables/APRR.mat");

    // For FP (final pressure)
    Modelica.Blocks.Tables.CombiTable2D FP8(
      tableOnFile=true,
      tableName="FP_D1",
      fileName="External files/Lookuptables/FP.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    //For SOC (state of charge)
    Modelica.Blocks.Tables.CombiTable2D SOC8(
      tableOnFile=true,
      tableName="SOC_D1",
      fileName="External files/Lookuptables/SOC.mat",
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

    /*************************************************/
    /*Equations*/
    /*************************************************/
  equation
    FP1.u1 = T;
    FP1.u2 = P;
    FP1.y = FP_1;
    SOC1.u1 = T;
    SOC1.u2 = P;
    SOC1.y = SOC_1;
    APRR1.u = T;
    APRR1.y[1] = APRR_1;

    FP2.u1 = T;
    FP2.u2 = P;
    FP2.y = FP_2;
    SOC2.u1 = T;
    SOC2.u2 = P;
    SOC2.y = SOC_2;
    APRR2.u = T;
    APRR2.y[1] = APRR_2;

    FP3.u1 = T;
    FP3.u2 = P;
    FP3.y = FP_3;
    SOC3.u1 = T;
    SOC3.u2 = P;
    SOC3.y = SOC_3;
    APRR3.u = T;
    APRR3.y[1] = APRR_3;

    FP4.u1 = T;
    FP4.u2 = P;
    FP4.y = FP_4;
    SOC4.u1 = T;
    SOC4.u2 = P;
    SOC4.y = SOC_4;
    APRR4.u = T;
    APRR4.y[1] = APRR_4;

    FP5.u1 = T;
    FP5.u2 = P;
    FP5.y = FP_5;
    SOC5.u1 = T;
    SOC5.u2 = P;
    SOC5.y = SOC_5;
    APRR5.u = T;
    APRR5.y[1] = APRR_5;

    FP6.u1 = T;
    FP6.u2 = P;
    FP6.y = FP_6;
    SOC6.u1 = T;
    SOC6.u2 = P;
    SOC6.y = SOC_6;
    APRR6.u = T;
    APRR6.y[1] = APRR_6;

    FP7.u1 = T;
    FP7.u2 = P;
    FP7.y = FP_7;
    SOC7.u1 = T;
    SOC7.u2 = P;
    SOC7.y = SOC_7;
    APRR7.u = T;
    APRR7.y[1] = APRR_7;

    FP8.u1 = T;
    FP8.u2 = P;
    FP8.y = FP_8;
    SOC8.u1 = T;
    SOC8.u2 = P;
    SOC8.y = SOC_8;
    APRR8.u = T;
    APRR8.y[1] = APRR_8;

    /*************************************************/
    /*Deciding output values*/
    /*************************************************/

    if Fueling_protocol == 1 then //A70 1-7 kg
      APRR = APRR_1;
      FP = FP_1;
      SOC = SOC_1;
      T_cool=T1;
      P_ref=P_ref1;
    elseif Fueling_protocol == 2 then //A70 7-10 kg
      APRR = APRR_2;
      FP = FP_2;
      SOC= SOC_2;
      T_cool=T1;
      P_ref=P_ref1;
    elseif Fueling_protocol == 3 then //A35
      APRR = APRR_3;
      FP = FP_3;
      SOC = SOC_3;
      T_cool=T1;
      P_ref=P_ref2;
    elseif Fueling_protocol == 4 then //B70 1-7 kg
      APRR = APRR_4;
      FP = FP_4;
      SOC = SOC_4;
      T_cool=T2;
      P_ref=P_ref1;
    elseif Fueling_protocol == 5 then //B70 7-10 kg
      APRR = APRR_5;
      FP = FP_5;
      SOC = SOC_5;
      T_cool=T2;
      P_ref=P_ref1;
    elseif Fueling_protocol == 6 then //B35
      APRR = APRR_6;
      FP = FP_6;
      SOC = SOC_6;
      T_cool=T2;
      P_ref=P_ref2;
    elseif Fueling_protocol == 7 then //C35
      APRR = APRR_7;
      FP = FP_7;
      SOC = SOC_7;
      T_cool=T3;
      P_ref=P_ref2;
    elseif Fueling_protocol == 8 then //D35
      APRR = APRR_8;
      FP = FP_8;
      SOC = SOC_8;
      T_cool=T;
      P_ref=P_ref2;
    else
      APRR = 0;
      FP = 0;
      SOC = 0;
      T_cool=0;
      P_ref=0;
    end if;

    /*************************************************/
    /*Checking input values*/
    /*************************************************/

  algorithm
    assert(Fueling_protocol < 9, "Not a valid fueling procedure. Choose one between 1 and 8;
  1: A70 1-7 kg,
  2: A70 7-10 kg,
  3: A35,
  4: B70 1-7 kg,
  5: B70 7-10 kg,
  6: B35,
  7: C35,
  8: D35");
    assert(if Fueling_protocol == 3 or Fueling_protocol == 6 or
    Fueling_protocol == 7 or Fueling_protocol == 8 then P <= 35e6
       else P <= 70e6,
      "The initial HSS pressure is above allowance of fuelling procedure -
     No need for refilling, HSS is already full!");

    annotation (preferedView="text", Icon(graphics={Bitmap(
            extent={{-98,88},{98,-80}},
            imageSource=
                "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AAAAADhCSU0EJQAAAAAAEPX8gST4liPF6RM/r7Xuli44QklNA+oAAAAAHa08P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJVVEYtOCI/Pgo8IURPQ1RZUEUgcGxpc3QgUFVCTElDICItLy9BcHBsZSBDb21wdXRlci8vRFREIFBMSVNUIDEuMC8vRU4iICJodHRwOi8vd3d3LmFwcGxlLmNvbS9EVERzL1Byb3BlcnR5TGlzdC0xLjAuZHRkIj4KPHBsaXN0IHZlcnNpb249IjEuMCI+CjxkaWN0PgoJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTUhvcml6b250YWxSZXM8L2tleT4KCTxkaWN0PgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5jcmVhdG9yPC9rZXk+CgkJPHN0cmluZz5jb20uYXBwbGUucHJpbnRpbmdtYW5hZ2VyPC9zdHJpbmc+CgkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lml0ZW1BcnJheTwva2V5PgoJCTxhcnJheT4KCQkJPGRpY3Q+CgkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC5QYWdlRm9ybWF0LlBNSG9yaXpvbnRhbFJlczwva2V5PgoJCQkJPHJlYWw+NzI8L3JlYWw+CgkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY2xpZW50PC9rZXk+CgkJCQk8c3RyaW5nPmNvbS5hcHBsZS5wcmludGluZ21hbmFnZXI8L3N0cmluZz4KCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5tb2REYXRlPC9rZXk+CgkJCQk8ZGF0ZT4yMDA0LTA4LTA0VDE4OjUzOjI0WjwvZGF0ZT4KCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5zdGF0ZUZsYWc8L2tleT4KCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+CgkJCTwvZGljdD4KCQk8L2FycmF5PgoJPC9kaWN0PgoJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTU9yaWVudGF0aW9uPC9rZXk+Cgk8ZGljdD4KCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQk8YXJyYXk+CgkJCTxkaWN0PgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTU9yaWVudGF0aW9uPC9rZXk+CgkJCQk8aW50ZWdlcj4xPC9pbnRlZ2VyPgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNsaWVudDwva2V5PgoJCQkJPHN0cmluZz5jb20uYXBwbGUucHJpbnRpbmdtYW5hZ2VyPC9zdHJpbmc+CgkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQubW9kRGF0ZTwva2V5PgoJCQkJPGRhdGU+MjAwNC0wOC0wNFQxODo1MzoyNFo8L2RhdGU+CgkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuc3RhdGVGbGFnPC9rZXk+CgkJCQk8aW50ZWdlcj4wPC9pbnRlZ2VyPgoJCQk8L2RpY3Q+CgkJPC9hcnJheT4KCTwvZGljdD4KCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhZ2VGb3JtYXQuUE1TY2FsaW5nPC9rZXk+Cgk8ZGljdD4KCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQk8YXJyYXk+CgkJCTxkaWN0PgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTVNjYWxpbmc8L2tleT4KCQkJCTxyZWFsPjE8L3JlYWw+CgkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY2xpZW50PC9rZXk+CgkJCQk8c3RyaW5nPmNvbS5hcHBsZS5wcmludGluZ21hbmFnZXI8L3N0cmluZz4KCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5tb2REYXRlPC9rZXk+CgkJCQk8ZGF0ZT4yMDA0LTA4LTA0VDE4OjUzOjI0WjwvZGF0ZT4KCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5zdGF0ZUZsYWc8L2tleT4KCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+CgkJCTwvZGljdD4KCQk8L2FycmF5PgoJPC9kaWN0PgoJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTVZlcnRpY2FsUmVzPC9rZXk+Cgk8ZGljdD4KCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQk8YXJyYXk+CgkJCTxkaWN0PgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTVZlcnRpY2FsUmVzPC9rZXk+CgkJCQk8cmVhbD43MjwvcmVhbD4KCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5jbGllbnQ8L2tleT4KCQkJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lm1vZERhdGU8L2tleT4KCQkJCTxkYXRlPjIwMDQtMDgtMDRUMTg6NTM6MjRaPC9kYXRlPgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJPGludGVnZXI+MDwvaW50ZWdlcj4KCQkJPC9kaWN0PgoJCTwvYXJyYXk+Cgk8L2RpY3Q+Cgk8a2V5PmNvbS5hcHBsZS5wcmludC5QYWdlRm9ybWF0LlBNVmVydGljYWxTY2FsaW5nPC9rZXk+Cgk8ZGljdD4KCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQk8YXJyYXk+CgkJCTxkaWN0PgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTVZlcnRpY2FsU2NhbGluZzwva2V5PgoJCQkJPHJlYWw+MTwvcmVhbD4KCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5jbGllbnQ8L2tleT4KCQkJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lm1vZERhdGU8L2tleT4KCQkJCTxkYXRlPjIwMDQtMDgtMDRUMTg6NTM6MjRaPC9kYXRlPgoJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJPGludGVnZXI+MDwvaW50ZWdlcj4KCQkJPC9kaWN0PgoJCTwvYXJyYXk+Cgk8L2RpY3Q+Cgk8a2V5PmNvbS5hcHBsZS5wcmludC5zdWJUaWNrZXQucGFwZXJfaW5mb190aWNrZXQ8L2tleT4KCTxkaWN0PgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhZ2VGb3JtYXQuUE1BZGp1c3RlZFBhZ2VSZWN0PC9rZXk+CgkJPGRpY3Q+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5jcmVhdG9yPC9rZXk+CgkJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuaXRlbUFycmF5PC9rZXk+CgkJCTxhcnJheT4KCQkJCTxkaWN0PgoJCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhZ2VGb3JtYXQuUE1BZGp1c3RlZFBhZ2VSZWN0PC9rZXk+CgkJCQkJPGFycmF5PgoJCQkJCQk8cmVhbD4wLjA8L3JlYWw+CgkJCQkJCTxyZWFsPjAuMDwvcmVhbD4KCQkJCQkJPHJlYWw+NzM0PC9yZWFsPgoJCQkJCQk8cmVhbD41NzY8L3JlYWw+CgkJCQkJPC9hcnJheT4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY2xpZW50PC9rZXk+CgkJCQkJPHN0cmluZz5jb20uYXBwbGUucHJpbnRpbmdtYW5hZ2VyPC9zdHJpbmc+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lm1vZERhdGU8L2tleT4KCQkJCQk8ZGF0ZT4yMDA3LTExLTMwVDA5OjIzOjU3WjwvZGF0ZT4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuc3RhdGVGbGFnPC9rZXk+CgkJCQkJPGludGVnZXI+MDwvaW50ZWdlcj4KCQkJCTwvZGljdD4KCQkJPC9hcnJheT4KCQk8L2RpY3Q+CgkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFnZUZvcm1hdC5QTUFkanVzdGVkUGFwZXJSZWN0PC9rZXk+CgkJPGRpY3Q+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5jcmVhdG9yPC9rZXk+CgkJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuaXRlbUFycmF5PC9rZXk+CgkJCTxhcnJheT4KCQkJCTxkaWN0PgoJCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhZ2VGb3JtYXQuUE1BZGp1c3RlZFBhcGVyUmVjdDwva2V5PgoJCQkJCTxhcnJheT4KCQkJCQkJPHJlYWw+LTE4PC9yZWFsPgoJCQkJCQk8cmVhbD4tMTg8L3JlYWw+CgkJCQkJCTxyZWFsPjc3NDwvcmVhbD4KCQkJCQkJPHJlYWw+NTk0PC9yZWFsPgoJCQkJCTwvYXJyYXk+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNsaWVudDwva2V5PgoJCQkJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5tb2REYXRlPC9rZXk+CgkJCQkJPGRhdGU+MjAwNy0xMS0zMFQwOToyMzo1N1o8L2RhdGU+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+CgkJPC9kaWN0PgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhcGVySW5mby5QTVBhcGVyTmFtZTwva2V5PgoJCTxkaWN0PgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCQk8c3RyaW5nPmNvbS5hcHBsZS5wcmludC5wbS5Qb3N0U2NyaXB0PC9zdHJpbmc+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQkJPGFycmF5PgoJCQkJPGRpY3Q+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFwZXJJbmZvLlBNUGFwZXJOYW1lPC9rZXk+CgkJCQkJPHN0cmluZz5uYS1sZXR0ZXI8L3N0cmluZz4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY2xpZW50PC9rZXk+CgkJCQkJPHN0cmluZz5jb20uYXBwbGUucHJpbnQucG0uUG9zdFNjcmlwdDwvc3RyaW5nPgoJCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5tb2REYXRlPC9rZXk+CgkJCQkJPGRhdGU+MjAwMC0wNy0yOFQyMjo1NzowNFo8L2RhdGU+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJCTxpbnRlZ2VyPjE8L2ludGVnZXI+CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+CgkJPC9kaWN0PgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhcGVySW5mby5QTVVuYWRqdXN0ZWRQYWdlUmVjdDwva2V5PgoJCTxkaWN0PgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCQk8c3RyaW5nPmNvbS5hcHBsZS5wcmludC5wbS5Qb3N0U2NyaXB0PC9zdHJpbmc+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQkJPGFycmF5PgoJCQkJPGRpY3Q+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFwZXJJbmZvLlBNVW5hZGp1c3RlZFBhZ2VSZWN0PC9rZXk+CgkJCQkJPGFycmF5PgoJCQkJCQk8cmVhbD4wLjA8L3JlYWw+CgkJCQkJCTxyZWFsPjAuMDwvcmVhbD4KCQkJCQkJPHJlYWw+NzM0PC9yZWFsPgoJCQkJCQk8cmVhbD41NzY8L3JlYWw+CgkJCQkJPC9hcnJheT4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY2xpZW50PC9rZXk+CgkJCQkJPHN0cmluZz5jb20uYXBwbGUucHJpbnRpbmdtYW5hZ2VyPC9zdHJpbmc+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lm1vZERhdGU8L2tleT4KCQkJCQk8ZGF0ZT4yMDA0LTA4LTA0VDE4OjUzOjI0WjwvZGF0ZT4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuc3RhdGVGbGFnPC9rZXk+CgkJCQkJPGludGVnZXI+MDwvaW50ZWdlcj4KCQkJCTwvZGljdD4KCQkJPC9hcnJheT4KCQk8L2RpY3Q+CgkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFwZXJJbmZvLlBNVW5hZGp1c3RlZFBhcGVyUmVjdDwva2V5PgoJCTxkaWN0PgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuY3JlYXRvcjwva2V5PgoJCQk8c3RyaW5nPmNvbS5hcHBsZS5wcmludC5wbS5Qb3N0U2NyaXB0PC9zdHJpbmc+CgkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5pdGVtQXJyYXk8L2tleT4KCQkJPGFycmF5PgoJCQkJPGRpY3Q+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQuUGFwZXJJbmZvLlBNVW5hZGp1c3RlZFBhcGVyUmVjdDwva2V5PgoJCQkJCTxhcnJheT4KCQkJCQkJPHJlYWw+LTE4PC9yZWFsPgoJCQkJCQk8cmVhbD4tMTg8L3JlYWw+CgkJCQkJCTxyZWFsPjc3NDwvcmVhbD4KCQkJCQkJPHJlYWw+NTk0PC9yZWFsPgoJCQkJCTwvYXJyYXk+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNsaWVudDwva2V5PgoJCQkJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50aW5nbWFuYWdlcjwvc3RyaW5nPgoJCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5tb2REYXRlPC9rZXk+CgkJCQkJPGRhdGU+MjAwNC0wOC0wNFQxODo1MzoyNFo8L2RhdGU+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnN0YXRlRmxhZzwva2V5PgoJCQkJCTxpbnRlZ2VyPjA8L2ludGVnZXI+CgkJCQk8L2RpY3Q+CgkJCTwvYXJyYXk+CgkJPC9kaWN0PgoJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhcGVySW5mby5wcGQuUE1QYXBlck5hbWU8L2tleT4KCQk8ZGljdD4KCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LmNyZWF0b3I8L2tleT4KCQkJPHN0cmluZz5jb20uYXBwbGUucHJpbnQucG0uUG9zdFNjcmlwdDwvc3RyaW5nPgoJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuaXRlbUFycmF5PC9rZXk+CgkJCTxhcnJheT4KCQkJCTxkaWN0PgoJCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LlBhcGVySW5mby5wcGQuUE1QYXBlck5hbWU8L2tleT4KCQkJCQk8c3RyaW5nPkxldHRlcjwvc3RyaW5nPgoJCQkJCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5jbGllbnQ8L2tleT4KCQkJCQk8c3RyaW5nPmNvbS5hcHBsZS5wcmludC5wbS5Qb3N0U2NyaXB0PC9zdHJpbmc+CgkJCQkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0Lm1vZERhdGU8L2tleT4KCQkJCQk8ZGF0ZT4yMDAwLTA3LTI4VDIyOjU3OjA0WjwvZGF0ZT4KCQkJCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQuc3RhdGVGbGFnPC9rZXk+CgkJCQkJPGludGVnZXI+MTwvaW50ZWdlcj4KCQkJCTwvZGljdD4KCQkJPC9hcnJheT4KCQk8L2RpY3Q+CgkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LkFQSVZlcnNpb248L2tleT4KCQk8c3RyaW5nPjAwLjIwPC9zdHJpbmc+CgkJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LnByaXZhdGVMb2NrPC9rZXk+CgkJPGZhbHNlLz4KCQk8a2V5PmNvbS5hcHBsZS5wcmludC50aWNrZXQudHlwZTwva2V5PgoJCTxzdHJpbmc+Y29tLmFwcGxlLnByaW50LlBhcGVySW5mb1RpY2tldDwvc3RyaW5nPgoJPC9kaWN0PgoJPGtleT5jb20uYXBwbGUucHJpbnQudGlja2V0LkFQSVZlcnNpb248L2tleT4KCTxzdHJpbmc+MDAuMjA8L3N0cmluZz4KCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC5wcml2YXRlTG9jazwva2V5PgoJPGZhbHNlLz4KCTxrZXk+Y29tLmFwcGxlLnByaW50LnRpY2tldC50eXBlPC9rZXk+Cgk8c3RyaW5nPmNvbS5hcHBsZS5wcmludC5QYWdlRm9ybWF0VGlja2V0PC9zdHJpbmc+CjwvZGljdD4KPC9wbGlzdD4KADhCSU0D6QAAAAAAeAADAAAASABIAAAAAALeAkD/7v/uAwYCUgNnBSgD/AACAAAASABIAAAAAALYAigAAQAAAGQAAAABAAMDAwAAAAF//wABAAEAAAAAAAAAAAAAAABoCAAZAZAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADhCSU0D7QAAAAAAEACWAAAAAQACAJYAAAABAAI4QklNBCYAAAAAAA4AAAAAAAAAAAAAP4AAADhCSU0EDQAAAAAABAAAAHg4QklNBBkAAAAAAAQAAAAeOEJJTQPzAAAAAAAJAAAAAAAAAAABADhCSU0ECgAAAAAAAQAAOEJJTScQAAAAAAAKAAEAAAAAAAAAAjhCSU0D9QAAAAAASAAvZmYAAQBsZmYABgAAAAAAAQAvZmYAAQChmZoABgAAAAAAAQAyAAAAAQBaAAAABgAAAAAAAQA1AAAAAQAtAAAABgAAAAAAAThCSU0D+AAAAAAAcAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAAAAA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"
                 +
                "IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+CiAgICAgIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPGV4aWY6Q29sb3JTcGFjZT4tMTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAgICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+Mjk1PC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjMxNDwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOk5hdGl2ZURpZ2VzdD4zNjg2NCw0MDk2MCw0MDk2MSwzNzEyMSwzNzEyMiw0MDk2Miw0MDk2MywzNzUxMCw0MDk2NCwzNjg2NywzNjg2OCwzMzQzNCwzMzQzNywzNDg1MCwzNDg1MiwzNDg1NSwzNDg1NiwzNzM3NywzNzM3OCwzNzM3OSwzNzM4MCwzNzM4MSwzNzM4MiwzNzM4MywzNzM4NCwzNzM4NSwzNzM4NiwzNzM5Niw0MTQ4Myw0MTQ4NCw0MTQ4Niw0MTQ4Nyw0MTQ4OCw0MTQ5Miw0MTQ5Myw0MTQ5NSw0MTcyOCw0MTcyOSw0MTczMCw0MTk4NSw0MTk4Niw0MTk4Nyw0MTk4OCw0MTk4OSw0MTk5MCw0MTk5MSw0MTk5Miw0MTk5Myw0MTk5NCw0MTk5NSw0MTk5Niw0MjAxNiwwLDIsNCw1LDYsNyw4LDksMTAsMTEsMTIsMTMsMTQsMTUsMTYsMTcsMTgsMjAsMjIsMjMsMjQsMjUsMjYsMjcsMjgsMzA7NjFCODExQzQ1Mjg4QjBBNkE3NUU1NTAwMDQ1MjY5OEM8L2V4aWY6TmF0aXZlRGlnZXN0PgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iPgogICAgICAgICA8dGlmZjpYUmVzb2x1dGlvbj4xNTAwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj4xNTAwMDAwLzEwMDAwPC90aWZmOllSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpSZXNvbHV0aW9uVW5pdD4yPC90aWZmOlJlc29sdXRpb25Vbml0PgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpOYXRpdmVEaWdlc3Q+MjU2LDI1NywyNTgsMjU5LDI2MiwyNzQsMjc3LDI4NCw1MzAsNTMxLDI4MiwyODMsMjk2LDMwMSwzMTgsMzE5LDUyOSw1MzIsMzA2LDI3MCwyNzEsMjcyLDMwNSwzMTUsMzM0MzI7MTNBNEY3NkIwNzk1NTIyQjhFQkI0QTU0NkI3QTFGNkI8L3RpZmY6TmF0aXZlRGlnZXN0PgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6eGFwPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIj4KICAgICAgICAgPHhhcDpDcmVhdGVEYXRlPjIwMDctMTEtMzBUMTA6MjQ6MDUrMDE6MDA8L3hhcDpDcmVhdGVEYXRlPgogICAgICAgICA8eGFwOk1vZGlmeURhdGU+MjAwNy0xMS0zMFQxMDoyNDowNSswMTowMDwveGFwOk1vZGlmeURhdGU+CiAgICAgICAgIDx4YXA6TWV0YWRhdGFEYXRlPjIwMDctMTEtMzBUMTA6MjQ6MDUrMDE6MDA8L3hhcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDx4YXA6Q3JlYXRvclRvb2w+QWRvYmUgUGhvdG9zaG9wIENTMiBNYWNpbnRvc2g8L3hhcDpDcmVhdG9yVG9vbD4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgICAgIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiCiAgICAgICAgICAgIHhtbG5zOnhhcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgICAgICAgICB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyI+CiAgICAgICAgIDx4YXBNTTpEb2N1bWVudElEPnV1aWQ6QUM2QkU5RTFBMEMwMTFEQ0E4QUI4NTVGQzdEMTczNzE8L3hhcE1NOkRvY3VtZW50SUQ+CiAgICAgICAgIDx4YXBNTTpJbnN0YW5jZUlEPnV1aWQ6QUM2QkU5RTJBMEMwMTFEQ0E4QUI4NTVGQzdEMTczNzE8L3hhcE1NOkluc3RhbmNlSUQ+CiAgICAgICAgIDx4YXBNTTpEZXJpdmVkRnJvbSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgIDxzdFJlZjppbnN0YW5jZUlEPnV1aWQ6RDQ5NEVBOThBMEJGMTFEQ0E4QUI4NTVGQzdEMTczNzE8L3N0UmVmOmluc3RhbmNlSUQ+CiAgICAgICAgICAgIDxzdFJlZjpkb2N1bWVudElEPnV1aWQ6RDQ5NEVBOTdBMEJGMTFEQ0E4QUI4NTVGQzdEMTczNzE8L3N0UmVmOmRvY3VtZW50SUQ+CiAgICAgICAgIDwveGFwTU06RGVyaXZlZEZyb20+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iPgogICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL2pwZWc8L2RjOmZvcm1hdD4KICAgICAgICAgPGRjOnN1YmplY3Q+CiAgICAgICAgICAgIDxyZGY6QmFnPgogICAgICAgICAgICAgICA8cmRmOmxpPjE4NDM5IEdORyA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT53b3JsZCBpbiB5b3VyIGhhbmRzIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPndpcmUgZ2xvYmUgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+dmVydGljYWwgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+VVNBPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+VVMgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+dW5pdGVkIHN0YXRlcyA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT50cmF2ZWwgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+dGhlIGFtZXJpY2FzIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPnNvdXRoIGFtZXJpY2EgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+c2lsaG91ZXR0ZSA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5wb3dlciA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5wbGFuZXQ8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5ub3J0aCBhbWVyaWNhIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPmxpZnRpbmcgdXAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+aG9sZGluZyA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5oYW5kIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPmdsb2JlIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPmdsb2JhbCB2aWxsYWdlIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPkdsb2JhbCBOYXZpZ2F0b3IgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+ZWFydGggPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+Y29udHJvbCA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5jb2xvdXIgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+Y29sb3IgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+Y2xvc2UtdXA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5DRDEwODwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPkNEIDEwODwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPmJsdWUgdG9uZSA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5ibGFjayA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaT5hbWVyaWNhIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpPmFjY2Vzc2libGUgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGk+MTg0MzlHTkcgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOkJhZz4KICAgICAgICAgPC9kYzpzdWJqZWN0PgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIj4KICAgICAgICAgPHBob3Rvc2hvcDpDb2xvck1vZGU+MzwvcGhvdG9zaG9wOkNvbG9yTW9kZT4KICAgICAgICAgPHBob3Rvc2hvcDpIaXN0b3J5Lz4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg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"
                 +
                "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",
            fileName=
                "modelica://HRS_package/../../Desktop/Dymola billeder/Global1.jpg")}));
  end HRSInfo;

  package Ports "Flow connectors, 6 different flow connectors"

    connector FlowPort "Flow port passing on mass flow, pressure and enthalpy"
     import SI = Modelica.SIunits;
     SI.Pressure p "Pressure";
     flow SI.MassFlowRate m_flow "Mass flow rate";
     stream SI.SpecificEnthalpy h_outflow "Specific enthalpy";

      annotation (Icon(coordinateSystem(extent={{-80,-80},{80,80}}),
                       graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
                                Diagram(coordinateSystem(extent={{-80,-80},{80,
                80}}),                  graphics={Ellipse(
              extent={{-60,60},{60,-60}},
              lineColor={0,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,94},{100,54}},
              lineColor={0,0,255},
              fillColor={255,153,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}),
                   Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"));
    end FlowPort;

    connector PressurePort "Passes on pressure"
      import SI = Modelica.SIunits;
      SI.Pressure p "Pressure";
      annotation (Icon(graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid)}),
                             Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"),
        Diagram(graphics={                    Text(
              extent={{-100,112},{100,72}},
              lineColor={0,0,255},
              fillColor={255,153,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),     Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid)}));
    end PressurePort;

    connector HeatFlow
      "Heat flow port passing on temperature, heat flow, pressure and area"
      import SI = Modelica.SIunits;
      SI.Temperature T "Temperature";
      flow SI.HeatFlowRate Q "Heat flow";
      SI.Pressure P "Pressure";
      Real Counter "Count pieces of walls";

      annotation (Icon(graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}),
                             Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"),
        Diagram(graphics={                    Text(
              extent={{-104,112},{96,72}},
              lineColor={0,0,255},
              fillColor={255,153,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),     Ellipse(
              extent={{-80,78},{80,-82}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}));
    end HeatFlow;

    connector HeatFlow2
      "Heat flow port passing on temperature, heat flow, pressure and area"
      import SI = Modelica.SIunits;
      SI.Temperature T "Temperature";
      flow SI.HeatFlowRate Q "Heat flow";
      SI.Pressure P "Pressure";
      Real Counter "Count pieces of walls";
      SI.MassFlowRate m_flow;
      annotation (Icon(graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}),
                             Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"),
        Diagram(graphics={                    Text(
              extent={{-104,112},{96,72}},
              lineColor={0,0,255},
              fillColor={255,153,0},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),     Ellipse(
              extent={{-80,78},{80,-82}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}));
    end HeatFlow2;

    connector TemperaturePort
      import SI = Modelica.SIunits;
      SI.Temperature T;

      annotation (Icon(graphics={Ellipse(
              extent={{-70,90},{90,-70}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}));
    end TemperaturePort;

    connector HeatFlowTube
      import SI = Modelica.SIunits;
     SI.Temperature T;
     flow SI.MassFlowRate m_flow;
     SI.SpecificHeatCapacity cp;
     SI.CoefficientOfHeatTransfer h;
      annotation (Icon(graphics={Ellipse(
              extent={{-70,90},{90,-70}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}));
    end HeatFlowTube;
  end Ports;

  package Tanks "The different tanks used for hydrogen refueling"
    model Tank1 "Volume with one entrance"
    import SI =
              Modelica.SIunits;

     /****************** Thermodynamic property call *************************/
        replaceable package Medium =
         CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));

           Medium.ThermodynamicState medium;
           Medium.ThermodynamicState mediumStream;

     /******************** Connectors *****************************/

      Ports.FlowPort portA "port connection component to other components"
        annotation (Placement(transformation(extent={{50,-10},{70,10}},    rotation=
               0), iconTransformation(extent={{92,-10},{114,10}})));
    //( m_flow(final start=m_flowStart))
      Ports.HeatFlow2 heatFlow "connection to heat transfer model"
        annotation (Placement(transformation(extent={{-112,-62},{-82,-32}}),
            iconTransformation(extent={{-10,-48},{10,-30}})));
      Ports.PressurePort pp "Connection for control of system"
        annotation (Placement(transformation(extent={{-114,38},{-72,78}}),
            iconTransformation(extent={{-12,26},{12,50}})));

     /****************** General parameters *******************/
      parameter Boolean Adiabatic = false "If true, adiabatic tank model" annotation(Dialog(group="Tank data"));
      parameter SI.Volume V=1 "Volume of the tank" annotation(Dialog(group="Tank data"));

     /******************  Initial and start values *******************/

      parameter SI.Pressure pInitial=1.013e5 "Initial pressure in the tank"
        annotation(Dialog(group="Initial Values"));
      parameter Boolean fixedInitialPressure = true "Fixed intial pressure"
                                annotation(Dialog(group="Initial Values"));

      parameter SI.Temperature TInitial=T_amb "Initial temperature in the tank"
        annotation(Dialog(group="Initial Values"));

      parameter SI.MassFlowRate m_flowStart=0 "Initial mass flow rate"
        annotation(Dialog(group="Initial Values"));

      outer parameter SI.Temperature T_amb "Ambient temperature";

     /****************** variables *******************/

      SI.Mass M "Gas mass in control volume";
      Real drhodt;
      SI.Heat Q;
      SI.InternalEnergy U;
      SI.SpecificInternalEnergy u;
      SI.Pressure p(start=pInitial, fixed=fixedInitialPressure);
      SI.SpecificEnthalpy h;
      Real HeatOfCompression "heat of compression";
      constant Real Counter=0;

    //Exergy varialbles
    //outer SI.Pressure P_amb;
    outer SI.SpecificEntropy s_0;
    outer SI.SpecificEnthalpy h_0;
    outer SI.SpecificInternalEnergy u_0;
    SI.Heat E_tank;
    SI.Heat E_stream;
    SI.SpecificEnthalpy e_tank;
    SI.SpecificEnthalpy e_stream;

    SI.Heat E_D;

    /****************** Initial equations *******************/
    initial equation
    h=Medium.specificEnthalpy_pT(pInitial, TInitial);

    /****************** equations *******************/
    equation

    medium=Medium.setState_ph(p, h);
    u=(h-p*1/medium.d);
    U=u*M;
    HeatOfCompression=V*der(p);

    if Adiabatic == false then
    der(Q)=heatFlow.Q;
    else
    der(Q)=0;
    end if;

     der(h) = 1/M*(noEvent(actualStream(portA.h_outflow))*portA.m_flow - portA.m_flow*h
     + V*der(p)+der(Q)) "Energy balance";

      p = portA.p;
      portA.h_outflow = h;
      M = V*medium.d "Mass in cv";
     drhodt = Medium.density_derp_h(medium)*der(p)+Medium.density_derh_p(medium)*der(h)
        "Derivative of density";

     drhodt*V = portA.m_flow "Mass balance";

    // Exergy
    if portA.m_flow >= 0 then
    mediumStream=Medium.setState_ph(p, inStream(portA.h_outflow));
    else
     mediumStream=Medium.setState_ph(p, h);
    end if;

    //u_0=h_0-P_amb*V;
    e_stream=mediumStream.h-h_0-T_amb*(mediumStream.s-s_0);
    e_tank=u-u_0-T_amb*(medium.s-s_0);
    der(E_tank)=e_tank*abs(portA.m_flow);
    der(E_stream)=e_stream*abs(portA.m_flow);
    E_tank=der(Q)*(1-T_amb/medium.T)+E_stream-E_D;
    //der(E_tank)=der(Q)*(1-T_amb/medium.T)+E_stream-E_D;

    //heatFlow.Q=der(Q);
    heatFlow.m_flow=portA.m_flow;
    heatFlow.T=medium.T;
    heatFlow.P=p;
    heatFlow.Counter=Counter;

    pp.p=p;

      annotation (preferedView="text",Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-40},{120,40}},
            initialScale=0.1), graphics={Bitmap(extent={{-96,42},{102,-42}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/TankHorizontal.png")}),
                                 Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-40},{120,40}},
            initialScale=0.1), graphics),
            Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"));
    end Tank1;

    model Tank2 "Volume with two entrances"
    import SI = Modelica.SIunits;
     /****************** Gas *************************/
        replaceable package Medium =
         CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));

           Medium.ThermodynamicState medium;
           Medium.ThermodynamicState mediumStreamA;
           Medium.ThermodynamicState mediumStreamB;

     /******************** Connectors *****************************/

      Ports.FlowPort portB(
                          m_flow(final start=m_flowStart))
        "port connection component to other components"
        annotation (Placement(transformation(extent={{50,-10},{70,10}},    rotation=
               0), iconTransformation(extent={{92,-10},{114,10}})));

      Ports.HeatFlow2 heatFlow "connection to heat transfer model"
        annotation (Placement(transformation(extent={{-112,-62},{-82,-32}}),
            iconTransformation(extent={{-10,-48},{10,-30}})));
      Ports.PressurePort pp "Connection for control of system"
        annotation (Placement(transformation(extent={{-114,38},{-72,78}}),
            iconTransformation(extent={{-12,26},{12,50}})));
      Ports.FlowPort portA(m_flow(final start=m_flowStart))
        "port connection component to other components"
        annotation (Placement(transformation(extent={{50,-10},{70,10}},    rotation=
               0), iconTransformation(extent={{-104,-10},{-82,10}})));
     /****************** General parameters *******************/
      parameter Boolean Adiabatic = false "If true, adiabatic tank model" annotation(Dialog(group="Tank data"));
      parameter SI.Volume V=1 "Volume of the tank" annotation(Dialog(group="Tank data"));

     /******************  Initial and start values *******************/

      parameter SI.Pressure pInitial=1.013e5 "Initial pressure in the tank"
        annotation(Dialog(group="Initial Values"));
      parameter Boolean fixedInitialPressure = true "Fixed intial pressure"
                                annotation(Dialog(group="Initial Values"));

      parameter SI.Temperature TInitial=T_amb "Initial temperature in the tank"
        annotation(Dialog(group="Initial Values"));

      parameter SI.MassFlowRate m_flowStart=0 "Initial mass flow rate"
        annotation(Dialog(group="Initial Values"));

     outer parameter SI.Temperature T_amb "Ambient temperature";

     /****************** variables *******************/

      SI.Mass M "Gas mass in control volume";
      Real drhodt;
      SI.HeatFlowRate Q;
      SI.InternalEnergy U;
      SI.SpecificInternalEnergy u;
      SI.Pressure p(start=pInitial, fixed=fixedInitialPressure);
      SI.SpecificEnthalpy h;
      Real HeatOfCompression "heat of compression";
      constant Real Counter=0;

    //Exergy varialbles
    //outer SI.Pressure P_amb;
    outer SI.SpecificEntropy s_0;
    // SI.SpecificEntropy s;
    outer SI.SpecificEnthalpy h_0;
    outer SI.SpecificInternalEnergy u_0;
    SI.Heat E_tank;
    SI.Heat E_streamA;
    SI.Heat E_streamB;
    SI.HeatFlowRate e_tank;
    SI.HeatFlowRate e_streamA;
    SI.HeatFlowRate e_streamB;
    SI.Heat E_D;

    /****************** Initial equations *******************/
    initial equation
    h=Medium.specificEnthalpy_pT(pInitial, TInitial);

    /****************** equations *******************/
    equation
    u=(h-p*1/medium.d);
    U=u*M;
    medium=Medium.setState_ph(p, h);

    HeatOfCompression=V*der(p);

    if Adiabatic == false then
    der(Q)=heatFlow.Q;
    else
    der(Q)=0;
    end if;

    der(h) = 1/M*(noEvent(actualStream(portA.h_outflow))*portA.m_flow - portA.m_flow*h
     + noEvent(actualStream(portB.h_outflow))*portB.m_flow - portB.m_flow*h
     + V*der(p)+der(Q));

      p = portA.p;
      portA.p-portB.p=0;

      portA.h_outflow = h;
      portB.h_outflow = h;

      M = V*medium.d "Mass in cv";
      drhodt = Medium.density_derp_h(medium)*der(p)+Medium.density_derh_p(medium)*der(h)
        "Derivative of density";

    drhodt*V = portA.m_flow + portB.m_flow "Mass balance";

    // Exergy
    if portA.m_flow >= 0 then
    mediumStreamA=Medium.setState_ph(p, inStream(portA.h_outflow));
    else
     mediumStreamA=Medium.setState_ph(p, h);
    end if;

    if portB.m_flow >= 0 then
    mediumStreamB=Medium.setState_ph(p, inStream(portA.h_outflow));
    else
     mediumStreamB=Medium.setState_ph(p, h);
    end if;

    //u_0=(h_0-P_amb*V);
    e_streamA=mediumStreamA.h-h_0-T_amb*(mediumStreamA.s-s_0);
    e_streamB=mediumStreamB.h-h_0-T_amb*(mediumStreamB.s-s_0);
    e_tank=u-u_0-T_amb*(medium.s-s_0);
    der(E_tank)=e_tank*(portA.m_flow+portB.m_flow) "Exergy in tank";
    der(E_streamA)=e_streamA*portA.m_flow "Exergy in stream from port A";
    der(E_streamB)=e_streamB*portB.m_flow "Exergy in stream from port B";
    E_tank=der(Q)*(1-T_amb/medium.T)+E_streamA+E_streamB-E_D "Exergy balance";

    //heatFlow.Q=der(Q);
    heatFlow.m_flow=portA.m_flow-portB.m_flow;
    heatFlow.T=medium.T;
    heatFlow.P=p;
    heatFlow.Counter=Counter;

    pp.p=p;

      annotation (preferedView="text",Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-40},{120,40}},
            initialScale=0.1), graphics={Bitmap(extent={{-96,42},{102,-42}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/TankHorizontal.png")}),
                                 Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-40},{120,40}},
            initialScale=0.1), graphics),
            Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"));
    end Tank2;
  end Tanks;

  package HeatTransfer

    model HeatTransferTank

    import SI =
              Modelica.SIunits;

    /******************** Connectors *****************************/
      Ports.HeatFlow2 heatFlow
        annotation (Placement(transformation(extent={{-26,80},{-6,100}})));

    /****************** General parameters *******************/
    parameter Integer tank=4 "Tank type" annotation (Dialog(group= " Heat Transfer"),choices(
    choice=1 "Tyep 1 Steel",
    choice=2 "Tyep 2 Aluminium",
    choice=3 "Tyep 3 Aluminium liner",
    choice=4 "Type 4 Plastic liner"));

      inner parameter Boolean Charging = true
        "If true, tank is charging with given heat transfer coefficient" annotation(Dialog(group= " Heat Transfer"));
      parameter SI.CoefficientOfHeatTransfer  h_charging=150 "Charging, Heat transfer 
  coefficient inside HSS tank 150 w/m2K - 500w/m2K  
    according to monde (0 is adiabatic fuelling)"                                                           annotation(Dialog(group= " Heat Transfer"));

      parameter SI.CoefficientOfHeatTransfer  h_discharging=-1 "Discharging heat transfer 
  coefficient, if <0 then Daney relation
     is used, if >0 then the given number is used "                                                         annotation(Dialog(group= " Heat Transfer"));
      inner parameter SI.CoefficientOfHeatTransfer  h_o=8
        "Heat transfer coefficient outside the tanks (typical natural convection)"
                                                                                   annotation(Dialog(group= " Heat Transfer"));
     // inner parameter Real  T_amb=273;

     inner parameter SI.Length xLiner=0.003 "Thickness of liner" annotation(Dialog(group= "Geometry"));
     inner parameter SI.Length  xCFRP=0.022 "Thickness of wrapping/tank" annotation(Dialog(group= "Geometry"));
     parameter SI.Length dInner=0.4 "Inside diameter of cylinder" annotation(Dialog(group= "Geometry"));
     parameter SI.Length LInner = 1 "Inside length of tank" annotation(Dialog(group= "Geometry"));
     parameter Boolean Area = true
        "If true, area is calcualted from length and diameter" annotation(Dialog(group= "Geometry"));
     parameter SI.Area AInner= 1 "Inside tank area "
                                  annotation(Dialog(group= "Geometry", enable = Area == false));

    protected
     inner parameter SI.Length x1=xLiner/(t1-0.5);
     inner parameter SI.Length x2=xCFRP/(t2-0.5);
     inner constant Real t1=5.5;
     inner constant Real t2=10.5;
     inner Real y1;
     inner Real y2;

    public
     inner SI.CoefficientOfHeatTransfer  h_i = (if Charging == true
     then h_charging else h_discharging);
     inner SI.Length   d = (if Area == false then AInner/(Modelica.Constants.pi)
     else dInner);
     inner SI.Length   L= (if Area == false then 0.8 else LInner);
     inner SI.Area   A = (if Area == false then AInner else 2*
     Modelica.Constants.pi*d/2*L+2*(d/2)^2*Modelica.Constants.pi);

      WallPieces.InnerWallCell
                             wallCell_discharging
        annotation (Placement(transformation(extent={{-26,36},{-6,56}})));
      WallPieces.OuterWallCell
                             outer_wall
        annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
      WallPieces.Liner5Pieces wall_liner
        annotation (Placement(transformation(extent={{-4,14},{16,34}})));
      WallPieces.Tank10Pieces wall_CFRP
        annotation (Placement(transformation(extent={{-40,-16},{-20,4}})));

    /****************** equations *******************/
    equation
    //Deciding which calls to make in lookup tables in wallpieces for tank properties
     if tank==1 then
       y1=1;
       y2=1;
     elseif tank==2 then
       y1=2;
       y2=2;
     elseif tank==3 then
       y1=2;
       y2=4;
     elseif tank==4 then
       y1=3;
       y2=4;
     else
       y1=3;
       y2=4;
       end if;

      connect(wall_CFRP.heatFlow, wall_liner.heatFlow1) annotation (Line(
          points={{-30,2.4},{-30,10},{6,10},{6,17}},
          color={255,0,0},
          smooth=Smooth.None));
      connect(wall_liner.heatFlow, wallCell_discharging.portB) annotation (Line(
          points={{6,32.6},{6,40},{-16,40}},
          color={255,0,0},
          smooth=Smooth.None));
      connect(wall_CFRP.heatFlow1, outer_wall.portA) annotation (Line(
          points={{-30,-13.8},{-30,-16},{0,-16},{0,-22}},
          color={255,0,0},
          smooth=Smooth.None));
      connect(wallCell_discharging.portA, heatFlow) annotation (Line(
          points={{-16,52},{-14,52},{-14,90},{-16,90}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}}),
                                          graphics={Bitmap(
              extent={{-90,74},{96,-80}},
              imageSource=
                  "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"
                   +
                  "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"
                   +
                  "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",
              fileName=
                  "U:/Documents/PHD/Articles/1st paper/gfx/tank_wall.jpg")}));
    end HeatTransferTank;

    model HeatTransferTube

      import SI = Modelica.SIunits;

    /******************** Connectors *****************************/
        Ports.HeatFlowTube HTIn
        annotation (Placement(transformation(extent={{-76,30},{-56,50}}),
            iconTransformation(extent={{-76,30},{-56,50}})));
      Ports.TemperaturePort
                          HT2
        annotation (Placement(transformation(extent={{54,30},{74,50}}),
            iconTransformation(extent={{54,30},{74,50}})));

    protected
      Ports.TemperaturePort                     HT1
        annotation (Placement(transformation(extent={{-68,12},{-48,32}})));

    /****************** General parameters *******************/
    public
    inner SI.MassFlowRate m_flow;
    inner SI.SpecificHeatCapacity cp_h2;
    inner SI.CoefficientOfHeatTransfer h;
    inner parameter SI.Length d_i=0.0052;
    inner parameter SI.Length d_o=0.00952;
    parameter SI.Length Length=6;
    parameter SI.CoefficientOfHeatTransfer h_o=8;
    protected
    inner parameter SI.CoefficientOfHeatTransfer h_amb=h_o;
    inner SI.Length L=Length/30;

      WallPieces.Tube5Pieces                         steel5Cells
        annotation (Placement(transformation(extent={{-50,46},{-30,66}})));
      WallPieces.Tube5Pieces                         steel5Cells1
        annotation (Placement(transformation(extent={{-32,14},{-12,34}})));
      WallPieces.Tube5Pieces                         steel5Cells2
        annotation (Placement(transformation(extent={{-8,14},{12,34}})));
      WallPieces.Tube5Pieces                         steel5Cells3
        annotation (Placement(transformation(extent={{14,14},{34,34}})));
      WallPieces.Tube5Pieces                         steel5Cells4
        annotation (Placement(transformation(extent={{36,14},{56,34}})));
      WallPieces.Tube5Pieces                         steel5Cells5
        annotation (Placement(transformation(extent={{38,44},{58,64}})));
    /****************** equations *******************/
    equation
    HTIn.m_flow=m_flow;
    HTIn.cp=cp_h2;
    HTIn.h=h;
    HT1.T=HTIn.T;

      connect(steel5Cells.HT1, HT1) annotation (Line(
          points={{-46.2,62},{-46.2,-4.3},{-58,-4.3},{-58,22}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(steel5Cells.HT2, steel5Cells1.HT1) annotation (Line(
          points={{-34.2,62},{-24,62},{-24,30},{-28.2,30}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(steel5Cells1.HT2, steel5Cells2.HT1) annotation (Line(
          points={{-16.2,30},{-4.2,30}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(steel5Cells2.HT2, steel5Cells3.HT1) annotation (Line(
          points={{7.8,30},{17.8,30}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(steel5Cells3.HT2, steel5Cells4.HT1) annotation (Line(
          points={{29.8,30},{39.8,30}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(steel5Cells4.HT2, steel5Cells5.HT1) annotation (Line(
          points={{51.8,30},{50,30},{50,40},{41.8,40},{41.8,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(steel5Cells5.HT2, HT2) annotation (Line(
          points={{53.8,60},{64,60},{64,40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,0},
                {80,80}}),         graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-80,0},{80,80}}),       graphics={Bitmap(
                extent={{-80,68},{80,16}}, fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/TubeQ.png")}));
    end HeatTransferTube;

    package WallPieces

      model InnerWallCell

        import SI = Modelica.SIunits;
      /*********************** Thermodynamic property call ***********************************/

                   replaceable package Medium =
            CoolProp2Modelica.Media.Hydrogen (onePhase=true) constrainedby
          Modelica.Media.Interfaces.PartialMedium annotation (
            choicesAllMatching=true);
      Medium.ThermodynamicState medium;

      /******************** Connectors *****************************/
        Ports.HeatFlow2 portA "Heat flow is pos when added to the wall"
          annotation (Placement(transformation(extent={{-10,50},{10,70}},
                rotation=0)));
        Ports.HeatFlow portB "Heat flow is pos when subtracted from the wall"
          annotation (Placement(transformation(extent={{-10,-70},{10,-50}},
                rotation=0)),HideResult=true);

      /****************** variables *******************/
        SI.Temperature T "Temperature of the wall element";
        SI.Pressure p "Pressure of the hydrogen";
        SI.ThermalResistance R "Thermal resistance of liner";
        SI.CoefficientOfHeatTransfer h "Heat transfer coefficient";
        SI.ThermalConductivity k "Thermal conductivity of liner";
        SI.SpecificHeatCapacity cp "Specific heat capacity of liner";
        SI.Density rho "Density of liner";
        Real Tau "Dimenasionless time";
        Real Ra "Dimensionless hydrogen properties number";
        Real beta "Thermal expansion coefficient";
        Real v "kinematic viscosity";
        Real a "thermal diff€usivity of hydrogen";
        Real Nu "Dimensionless heat transfer number";

      /****************** General parameters *******************/
        constant Real g=9.82 "accelaration due to gravity";
        SI.Length dx=x1/2;

            outer SI.Length d "inside diameter of cylinder";
            outer SI.Temperature T_amb "Ambient temperature";
            outer Real y1;
            outer SI.CoefficientOfHeatTransfer  h_i;
            outer SI.Area A;
            outer SI.Length x1;
      /****************** Tables *******************/
        Modelica.Blocks.Tables.CombiTable1Ds tank_prop(
          tableName="properties",
          tableOnFile=true,
          table=[1,850,15,481; 2,2700,236,900; 3,1286,1.17,1578; 4,1374,1.14,1075],
          fileName=
              "External files/Lookuptables/HeatTransferProperties.txt")
          annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

      /****************** Initial equations *******************/
      initial equation
        T=T_amb;

      /****************** equations *******************/
      equation
      medium=Medium.setState_pT(p, T);
      tank_prop.u=y1;
      tank_prop.y[1]=rho;
      tank_prop.y[2]=k;
      tank_prop.y[3]=cp;

      portA.P=p;

       Medium.thermalConductivity(medium)=a;
       Medium.dynamicViscosity(medium)/Medium.density(medium)=v;

      //calculation of rayleighs number taken from 'Natural convection cooling of
      //rectangular and cylindrical containers' by Wenxian Lin, S.W. Armfield
      Ra=g*beta*d^3*Medium.specificHeatCapacityCp(medium)*
      Medium.density(medium)^2*abs(portA.T-T)/(v*k);
      beta=1/portA.T;
      Tau=time/(d^2/(a*Ra^(1/2)));
      Nu=0.104*Ra^(0.352);

      if portA.m_flow < 0.00 then
        h=Nu*k/d;
      elseif portA.m_flow > 0.00 then
        h=h_i;
      else
        h=50;
      end if;

      R = dx / (A*k);

        portA.Q = (portA.T-T) / (1/(h*A));
        portB.Q = (portB.T-T) / (R/2);

        A*dx*rho*cp*der(T) = portA.Q + portB.Q;

      portA.P=portB.P;
      portA.Counter+1=portB.Counter;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
                  {100,100}}),       graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Rectangle(extent={{-90,60},{90,-60}}, lineColor={0,
                    0,255}), Text(
                extent={{-86,16},{86,-4}},
                lineColor={0,0,255},
                textString="Inner_wall_discharging")}));
      end InnerWallCell;

      model OuterWallCell "Outer wall with natural convection given by h_o"
        import SI = Modelica.SIunits;

      /******************** Connectors *****************************/
       Ports.HeatFlow portA "Heat flow is pos when added to the wall"
         annotation (Placement(transformation(extent={{-10,50},{10,70}},
               rotation=0)));

      /****************** variables *******************/
       SI.Temperature T "Temperature of the wall element";
       SI.ThermalResistance R;
       SI.ThermalConductivity k;
       SI.SpecificHeatCapacity cp;
       SI.Density rho;
       SI.Area  A "heat flow surface area, dz*dy";
       SI.Length dx=x2/2;
       SI.HeatFlowRate Q;

      /****************** General parameters *******************/
            outer parameter SI.CoefficientOfHeatTransfer h_o;
            outer SI.Temperature T_amb;
            outer Real y1;
            outer Real x2;
            outer SI.Length d;
            outer SI.Length xLiner;
            outer SI.Length  xCFRP;
            outer SI.Length L;

      /****************** Tables *******************/
       Modelica.Blocks.Tables.CombiTable1Ds tank_prop(
          tableName="properties",
          tableOnFile=true,
          table=[1,850,15,481; 2,2700,236,900; 3,1286,1.17,1578; 4,1374,1.14,1075],
          fileName=
              "External files/Lookuptables/HeatTransferProperties.txt")
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      /****************** Initial equations *******************/
      initial equation
       T=T_amb;
      /****************** equations *******************/
      equation
      A=(d/2+xLiner+xCFRP)*2*Modelica.Constants.pi*L+2*
      (d/2+xLiner+xCFRP)^2*Modelica.Constants.pi;

      tank_prop.u=y1;
      tank_prop.y[1]=rho;
      tank_prop.y[2]=k;
      tank_prop.y[3]=cp;

       R = dx / (A*k);

      portA.Q = (portA.T-T) / (R/2);
      Q=h_o*(T_amb-T)*A;

       A*dx*rho*cp*der(T) = portA.Q+Q;

       annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
                  {100,100}}),      graphics), Icon(coordinateSystem(
               preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
             graphics={Rectangle(extent={{-90,60},{90,-60}}, lineColor={0,
                   0,255}), Text(
               extent={{-78,22},{78,-14}},
               lineColor={0,0,255},
                textString="Outer_Wall")}));
      end OuterWallCell;

      model LinerCell
        import SI = Modelica.SIunits;

        /******************** Connectors *****************************/
       Ports.HeatFlow portA "Heat flow is pos when added to the wall"
          annotation (Placement(transformation(extent={{-10,50},{10,70}},
                rotation=0)));
        Ports.HeatFlow portB "Heat flow is pos when subtracted from the wall"
          annotation (Placement(transformation(extent={{-10,-70},{10,-50}},
                rotation=0)),HideResult=true);

      /****************** variables *******************/
        SI.Temperature T "Temperature of the wall element";
        SI.ThermalResistance R;
        SI.ThermalConductivity k;
        SI.SpecificHeatCapacity cp;
        SI.Density rho;
        SI.Area A "heat flow surface area, dz*dy";
        SI.Length dx=x1;

      /****************** General parameters *******************/
       outer SI.Temperature T_amb;
       outer Real x1;
       outer Real y1;
       outer Real t1;
       outer SI.Length d;
       outer SI.Length L;

      /****************** Tables *******************/
      Modelica.Blocks.Tables.CombiTable1Ds tank_prop(
          tableName="properties",
          table=[1,850,15,481; 2,2700,167,1106; 3,1286,1.17,1578; 4,1374,1.14,
              1075],
          tableOnFile=true,
          fileName=
              "External files/Lookuptables/HeatTransferProperties.txt")
          annotation (Placement(transformation(extent={{-74,46},{-54,66}})));

      /****************** Initial equations *******************/
      initial equation
        T=T_amb;
      /****************** equations *******************/
      equation
      A=((portA.Counter-0.5)*x1+d/2)*Modelica.Constants.pi*2*L+2*
      ((portA.Counter-0.5)*x1+d/2)^2*Modelica.Constants.pi;

      tank_prop.u=y1;
      tank_prop.y[1]=rho;
      tank_prop.y[2]=k;
      tank_prop.y[3]=cp;

        R = dx / (A*k);
        portA.Q = (portA.T-T) / (R/2);
        portB.Q = (portB.T-T) / (R/2);

        A*dx*rho*cp*der(T) = portA.Q + portB.Q;

      if portA.Counter>=t1+0.5 then
        portB.Counter =0;
        else
      portA.Counter+1=portB.Counter;
      end if;

      portA.P=portB.P;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),       graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Rectangle(extent={{-90,60},{90,-60}}, lineColor={0,
                    0,255}), Text(
                extent={{-82,36},{84,-38}},
                lineColor={0,0,255},
                textString="Liner")}));
      end LinerCell;

      model TankCell
        import SI = Modelica.SIunits;

        /******************** Connectors *****************************/
       Ports.HeatFlow portA "Heat flow is pos when added to the wall"
          annotation (Placement(transformation(extent={{-10,50},{10,70}},
                rotation=0)));
       Ports.HeatFlow portB "Heat flow is pos when subtracted from the wall"
          annotation (Placement(transformation(extent={{-10,-70},{10,-50}},
                rotation=0)),HideResult=true);

        /****************** variables *******************/
       SI.Temperature T "Temperature of the wall element";
       SI.ThermalResistance R;
       SI.ThermalConductivity k;
       SI.SpecificHeatCapacity cp;
       SI.Density rho;

        SI.Area A "heat flow surface area, dz*dy";

        SI.Length dx=x2;

        /****************** General parameters *******************/
        outer SI.Temperature T_amb;
        outer SI.Length x2;
        outer SI.Length x1;
        outer Real y2;
        outer SI.Length d;
        outer SI.Length L;
        outer Real t1;
        outer Real t2;

      /****************** Tables *******************/
      Modelica.Blocks.Tables.CombiTable1Ds tank_prop(
          tableName="properties",
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          table=[1,850,15,481; 2,2700,236,900; 3,1286,1.17,1578; 4,1500,0.5,940],
          tableOnFile=true,
          fileName=
              "External files/Lookuptables/HeatTransferProperties.txt")
          annotation (Placement(transformation(extent={{-76,46},{-56,66}})));
        /****************** Initial equations *******************/
      initial equation
        T=T_amb;
        /****************** equations *******************/
      equation
      A=((portA.Counter-0.5)*x2+x1*t1+d/2)*Modelica.Constants.pi*2*L+2*
      ((portA.Counter-0.5)*x2+x1*t1+d/2)^2*Modelica.Constants.pi;

      tank_prop.u=y2;
      tank_prop.y[1]=rho;
      tank_prop.y[2]=k;
      tank_prop.y[3]=cp;

        R = dx / (A*k);
        portA.Q = (portA.T-T) / (R/2);
        portB.Q = (portB.T-T) / (R/2);

      A*dx*rho*cp*der(T) = portA.Q + portB.Q;
      portA.P=portB.P;
      if portA.Counter>=t2-0.5 then
        portB.Counter =0;
        else
      portA.Counter+1=portB.Counter;
      end if;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),       graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Rectangle(extent={{-90,60},{90,-60}}, lineColor={0,
                    0,255}), Text(
                extent={{-68,26},{66,-32}},
                lineColor={0,0,255},
                textString="CFRP")}));
      end TankCell;

      model TubeCell
        import SI = Modelica.SIunits;
        import C = Modelica.Constants;

      /******************** Connectors *****************************/
          Ports.TemperaturePort                     HT1
          annotation (Placement(transformation(extent={{-56,60},{-36,80}}),
              iconTransformation(extent={{-56,60},{-36,80}})));
        Ports.TemperaturePort                     HT2
          annotation (Placement(transformation(extent={{40,60},{60,80}})));

      /****************** General parameters *******************/
       outer SI.MassFlowRate m_flow;
       outer SI.SpecificHeatCapacity cp_h2;
       outer SI.CoefficientOfHeatTransfer h;
       outer SI.CoefficientOfHeatTransfer h_amb;
       outer parameter SI.Length d_i;
       outer parameter SI.Length d_o;
       outer parameter SI.Temperature T_amb;
       outer SI.Length L;
      parameter SI.Length dx=(d_o-d_i)/12;

      /****************** variables *******************/
      flow SI.HeatFlowRate[8] Q;
      SI.Temperature[7] T;
      Real R;
      SI.SpecificHeatCapacity cp;
      SI.Density rho;
      SI.Conductivity k;

      /****************** Tables *******************/
      Modelica.Blocks.Tables.CombiTable1Ds tank_prop(
          tableName="properties",
          table=[1,850,15,481; 2,2700,167,1106; 3,1286,1.17,1578; 4,1374,1.14,
              1075],
          tableOnFile=true,
          fileName=
              "External files/Lookuptables/HeatTransferProperties.txt")
          annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      /****************** Initial equations *******************/
      initial equation
        T[1]=T_amb;
        T[3]=T_amb;
        T[5]=T_amb;
        T[7]=T_amb;

      /****************** equations *******************/
      equation

        tank_prop.u=1;
        tank_prop.y[1]=rho;
        tank_prop.y[2]=k;
        tank_prop.y[3]=cp;

        R=dx/((d_i*C.pi*L)*k);
      //Between hydrogen and inner wall
        Q[1]=(HT1.T-T[1])/(1/(h*(d_i*C.pi*L)));
        Q[2]=(T[2]-T[1])/(R/2);
        (d_i*C.pi*L)*dx*rho*cp*der(T[1]) = Q[1] + Q[2];
      //Between two wall volumes
        -Q[2]=Q[3];
        Q[3]=(T[2]-T[3])/(R/2);
        Q[4]=(T[4]-T[3])/(R/2);
        ((d_i/2+dx*2)*2*C.pi*L)*2*dx*rho*cp*der(T[3]) = Q[3] + Q[4];
      //Between two wall volumes
        -Q[4]=Q[5];
        Q[5]=(T[4]-T[5])/(R/2);
        Q[6]=(T[6]-T[5])/(R/2);
        ((d_i/2+dx*4)*2*C.pi*L)*2*dx*rho*cp*der(T[5]) = Q[5] + Q[6];
      //Between outer wall volume and ambient
        -Q[6]=Q[7];
        Q[7]=(T[6]-T[7])/(R/2);
        Q[8]=h_amb*(T_amb-T[7])*((d_i/2+dx*6)*2*C.pi*L);
        ((d_i/2+dx*6)*2*C.pi*L)*dx*rho*cp*der(T[7]) = Q[7] + Q[8];

        -Q[1]=cp_h2*m_flow*(HT1.T-HT2.T);

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Rectangle(extent={{-84,70},{96,-50}}, lineColor={0,
                    0,255}), Text(
                extent={{-56,24},{66,-28}},
                lineColor={0,0,255},
                textString="Tube cell
")}));
      end TubeCell;

      model Liner5Pieces
      //Import of models
        LinerCell
              liner
          annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        LinerCell
              liner1
          annotation (Placement(transformation(extent={{-10,24},{10,44}})));
        LinerCell
              liner2
          annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        LinerCell
              liner3
          annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));
        LinerCell
              liner4
          annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
        Ports.HeatFlow heatFlow
          annotation (Placement(transformation(extent={{-10,76},{10,96}})));
       Ports.HeatFlow heatFlow1
          annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
      equation
        connect(liner.portB, liner1.portA) annotation (Line(
            points={{0,54},{0,40}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(liner1.portB, liner2.portA) annotation (Line(
            points={{0,28},{0,16}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(liner2.portB, liner3.portA) annotation (Line(
            points={{0,4},{0,-8}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(liner3.portB, liner4.portA) annotation (Line(
            points={{0,-20},{0,-34}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(liner.portA, heatFlow) annotation (Line(
            points={{0,66},{0,86}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(liner4.portB, heatFlow1) annotation (Line(
            points={{0,-46},{0,-70}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (Diagram(graphics));
      end Liner5Pieces;

      model Tank10Pieces
      //import models
        TankCell
             cFRP
          annotation (Placement(transformation(extent={{-50,36},{-30,56}})));
        TankCell
             cFRP1
          annotation (Placement(transformation(extent={{-50,12},{-30,32}})));
        TankCell
             cFRP2
          annotation (Placement(transformation(extent={{-50,-12},{-30,8}})));
        TankCell
             cFRP3
          annotation (Placement(transformation(extent={{-50,-36},{-30,-16}})));
        TankCell
             cFRP4
          annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
        TankCell
             cFRP5
          annotation (Placement(transformation(extent={{-10,36},{10,56}})));
        TankCell
             cFRP6
          annotation (Placement(transformation(extent={{-10,12},{10,32}})));
        TankCell
             cFRP7
          annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
        TankCell
             cFRP8
          annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
        TankCell
             cFRP9
          annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
        Ports.HeatFlow heatFlow
          annotation (Placement(transformation(extent={{-10,74},{10,94}})));
        Ports.HeatFlow heatFlow1
          annotation (Placement(transformation(extent={{-10,-88},{10,-68}})));
      equation
        connect(cFRP.portA, heatFlow) annotation (Line(
            points={{-40,52},{-40,84},{0,84}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP.portB, cFRP1.portA) annotation (Line(
            points={{-40,40},{-40,28}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP1.portB, cFRP2.portA) annotation (Line(
            points={{-40,16},{-40,4}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP2.portB, cFRP3.portA) annotation (Line(
            points={{-40,-8},{-40,-20}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP3.portB, cFRP4.portA) annotation (Line(
            points={{-40,-32},{-40,-44}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP4.portB, cFRP5.portA) annotation (Line(
            points={{-40,-56},{-40,-64},{-18,-64},{-18,60},{0,60},{0,52}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP5.portB, cFRP6.portA) annotation (Line(
            points={{0,40},{0,28}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP6.portB, cFRP7.portA) annotation (Line(
            points={{0,16},{0,4}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP7.portB, cFRP8.portA) annotation (Line(
            points={{0,-8},{0,-20}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP8.portB, cFRP9.portA) annotation (Line(
            points={{0,-32},{0,-44}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(cFRP9.portB, heatFlow1) annotation (Line(
            points={{0,-56},{0,-56},{0,-78}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (Diagram(graphics));
      end Tank10Pieces;

      model Tube5Pieces

        TubeCell   tubeHeatTransfer3Testing
          annotation (Placement(transformation(extent={{-60,4},{-40,24}})));
        TubeCell   tubeHeatTransfer3Testing1
          annotation (Placement(transformation(extent={{-34,4},{-14,24}})));
        TubeCell   tubeHeatTransfer3Testing2
          annotation (Placement(transformation(extent={{-8,4},{12,24}})));
        TubeCell  tubeHeatTransfer3Testing3
          annotation (Placement(transformation(extent={{18,4},{38,24}})));
        TubeCell  tubeHeatTransfer3Testing4
          annotation (Placement(transformation(extent={{44,4},{64,24}})));

        Ports.TemperaturePort                     HT1
          annotation (Placement(transformation(extent={{-72,50},{-52,70}}),
              iconTransformation(extent={{-72,50},{-52,70}})));

        Ports.TemperaturePort                     HT2
          annotation (Placement(transformation(extent={{48,50},{68,70}}),
              iconTransformation(extent={{48,50},{68,70}})));
      equation
        connect(HT1,tubeHeatTransfer3Testing. HT1) annotation (Line(
            points={{-62,60},{-54.6,60},{-54.6,21}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None));
        connect(tubeHeatTransfer3Testing1.HT2,tubeHeatTransfer3Testing2. HT1)
          annotation (Line(
            points={{-19,21},{-10,22},{-2.6,21}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None));
        connect(tubeHeatTransfer3Testing2.HT2,tubeHeatTransfer3Testing3. HT1)
          annotation (Line(
            points={{7,21},{7,18.5},{23.4,18.5},{23.4,21}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None));
        connect(tubeHeatTransfer3Testing3.HT2,tubeHeatTransfer3Testing4. HT1)
          annotation (Line(
            points={{33,21},{49.4,21}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None));
        connect(tubeHeatTransfer3Testing4.HT2, HT2) annotation (Line(
            points={{59,21},{59,28.5},{58,28.5},{58,60}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None));
        connect(tubeHeatTransfer3Testing1.HT1, tubeHeatTransfer3Testing.HT2)
          annotation (Line(
            points={{-28.6,21},{-45,21}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics));
      end Tube5Pieces;
    end WallPieces;

  end HeatTransfer;

  package PressureLosses
    model ReductionValve
      import SI = Modelica.SIunits;
    /*********************** Thermodynamic properties ***********************************/
         replaceable package Medium =
           CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="thermodynamic properties"));
    //
            Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumB;

    /******************** Connectors *****************************/
    public
      Ports.FlowPort portA(
     p(final start=pInitialIn),
      h_outflow(final start=hInitial),
     m_flow(final start=m_flowInitial))
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}}, rotation=
                0), iconTransformation(extent={{-70,-10},{-50,10}})));

      Ports.FlowPort portB(
      p(final start=pInitialOut),
       h_outflow(final start=hInitial))
        annotation (Placement(transformation(extent={{50,-10},{70,10}}, rotation=0),
            iconTransformation(extent={{50,-10},{70,10}})));

       Ports.PressurePort pp1 annotation (Placement(transformation(extent={{-50,18},
                 {-30,38}}),         iconTransformation(extent={{-50,18},{-30,38}})));
       Ports.PressurePort pp2 annotation (Placement(transformation(extent={
                 {18,10},{38,30}}), iconTransformation(extent={{30,18},{50,38}})));
     /****************** parameters *******************/

      parameter SI.Pressure pInitialIn = 1.013e5  annotation(Dialog(group="Initial Values"));
      parameter SI.Temperature TInitialIn = T_amb  annotation(Dialog(group="Initial Values"));
      parameter SI.Pressure pInitialOut=20e5 annotation(Dialog(group="Initial Values"));
      outer parameter SI.Temperature T_amb;

     /****************** Variables *******************/
      SI.Pressure pressureDrop "calculated pressure drop";

      //Exergy
      outer SI.SpecificEntropy s_0;
      outer SI.SpecificEnthalpy h_0;
      SI.Power EA;
      SI.Power EB;
      SI.Power E_D;
     /****************** Start values *******************/
    //exergy
    protected
      parameter SI.SpecificEnthalpy hInitial=Medium.specificEnthalpy_pT(T=TInitialIn,
      p=pInitialIn) annotation(Dialog(group="Initial Values"));
      parameter SI.MassFlowRate m_flowInitial = 0 annotation(Dialog(group="Initial Values"));

    equation
      //Passing on enthalpy between the ports
      portB.h_outflow = inStream(portA.h_outflow);
      portA.h_outflow = inStream(portB.h_outflow);

      portA.m_flow + portB.m_flow = 0 "mass balance";

      pressureDrop = portA.p - portB.p "Momentum balance";

    //Deciding propeties depending on the flow direction
       if portA.p > portB.p then
           mediumA=Medium.setState_ph(portA.p, actualStream(portA.h_outflow));
           mediumB=Medium.setState_ph(portB.p, portB.h_outflow);
           der(E_D)=der(EA)-der(EB);
       else
         mediumA=Medium.setState_ph(portB.p, actualStream(portB.h_outflow));
         mediumB=Medium.setState_ph(portA.p,portA.h_outflow);
         der(E_D)=-der(EA)+der(EB);
       end if;

    // Exergy
    der(EA)=abs(portA.m_flow)*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)=abs(portA.m_flow)*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));

     pp1.p=portA.p;
     pp2.p=portB.p;

      annotation (
        preferedView="text",
        Documentation(info="<html>
<p>
HydraulicResistor is a simple pressure drop model.
</p>
<p>
For a given dp:
<br>&Delta;p = &Delta;p_0 * &rho;/&rho;_0 * (Vdot/Vdot_0)        &sup2;
<br>Vdot =         &plusmn; sqrt(|&Delta;p|/&Delta;p_0 * &rho;_0/&rho; Vdot_0&sup2;)
</p>
<p>
For a given zeta:
<br>&Delta;p = &zeta; * &rho;/2 * w&sup2;
<br>Vdot = A * w
<br>Vdot = &plusmn; A * sqrt(|&Delta;p|*2 / (&Delta;p * &zeta;))
</p>
</html>"),        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-60,-40},{60,40}},
            initialScale=0.1), graphics={Bitmap(extent={{-60,28},{60,-28}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/NeedleValve.png")}),
        Diagram(coordinateSystem(extent={{-60,-40},{60,40}}, preserveAspectRatio=false),
            graphics));
    end ReductionValve;

    model AveragePressureRampRate
      import SI = Modelica.SIunits;
    /*********************** Thermodynamic properties ***********************************/
         replaceable package Medium =
          CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Thermodynamic properties"));

    /******************** Connectors *****************************/
    public
       Ports.FlowPort portA(
         p(final start=pInitial),
         h_outflow(final start=hInitial),
         m_flow(final start=m_flowInitial))
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}}, rotation=
                0), iconTransformation(extent={{-60,-10},{-40,10}})));

      Ports.FlowPort portB(
        p(final start=pInitial),
        h_outflow(final start=hInitial))
            annotation (Placement(transformation(extent={{50,-10},{70,10}}, rotation=0),
            iconTransformation(extent={{42,-10},{62,10}})));
       Ports.PressurePort pp1
         annotation (Placement(transformation(extent={{-10,26},{10,46}}),
             iconTransformation(extent={{-10,38},{10,58}})));

     /****************** parameters *******************/

      parameter Boolean SAEJ2601 = true
        "If true, the ramp rate is retrieved from J2601"                              annotation(Evaluate=true, Dialog(group="Average pressure ramp rate"));
      parameter SI.Pressure APRR2=28e6 "MPa/min - Alternative refueling rate" annotation(Dialog(group="Average pressure ramp rate", enable = SAEJ2601 == false));

       parameter SI.Pressure pInitial = 1.013e5  annotation(Dialog(group="Initial Values"));
       parameter SI.Temperature TInitial = T_amb  annotation(Dialog(group="Initial Values"));

      outer SI.Pressure APRR "MPa/min";
      outer Integer z3;
      outer Integer z5;
      outer parameter SI.Temperature T_amb;
      Real APRR_used;
      SI.Pressure dp;

     /****************** Start values *******************/
    protected
       parameter SI.SpecificEnthalpy hInitial=Medium.specificEnthalpy_pT(T=TInitial,
        p=pInitial) annotation(Dialog(group="Initial Values"));
       parameter SI.MassFlowRate m_flowInitial = 0.0000 annotation(Dialog(group="Initial Values",enable = SAE2601==false));

    equation
      portB.h_outflow =inStream(portA.h_outflow);
      portA.h_outflow= inStream(portB.h_outflow);
    //Deciding which ramp rate to be used
    if SAEJ2601==true then
      APRR=APRR_used;
    else
      APRR_used=APRR2;
    end if;

    portA.p-portB.p=dp "Momentum balance";

    //Deciding APRR for controls and mass balances
    if z3==0 or z5==0 then
      der(portA.p) = APRR_used/60;
      dp=0;
      portA.m_flow + portB.m_flow = 0;
    else
    der(portA.p) = 0;
    portB.m_flow=0;
    portA.m_flow=0;
    end if;

       pp1.p=portA.p;
      annotation (
        preferedView="text",
        Documentation(info="<html>
<p>
HydraulicResistor is a simple pressure drop model.
</p>
<p>
For a given dp:
<br>&Delta;p = &Delta;p_0 * &rho;/&rho;_0 * (Vdot/Vdot_0)        &sup2;
<br>Vdot =         &plusmn; sqrt(|&Delta;p|/&Delta;p_0 * &rho;_0/&rho; Vdot_0&sup2;)
</p>
<p>
For a given zeta:
<br>&Delta;p = &zeta; * &rho;/2 * w&sup2;
<br>Vdot = A * w
<br>Vdot = &plusmn; A * sqrt(|&Delta;p|*2 / (&Delta;p * &zeta;))
</p>
</html>"),        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-60,-40},{60,60}},
            initialScale=0.1), graphics={Bitmap(extent={{-50,56},{54,-48}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/APRR.png")}),
        Diagram(coordinateSystem(extent={{-60,-40},{60,60}})));
    end AveragePressureRampRate;

    model PressureLoss

      import SI = Modelica.SIunits;
    /*********************** Thermodynamic properties ***********************************/
        replaceable package Medium =
          CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium
        "The library called to obtain properties for the fluid";
    //Modelica.Media.Interfaces.PartialMedium
           Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState medium1;
           Medium.ThermodynamicState medium2;

    /******************** Connectors *****************************/

    public
      Ports.FlowPort portA(
        p(final start=pInitial),
        h_outflow(final start=hInitial),
        m_flow(final start=m_flowStart))
        annotation (Placement(transformation(extent={{-86,-10},{-66,10}}, rotation=
                0), iconTransformation(extent={{-88,-10},{-68,10}})));
      Ports.FlowPort portB(
        p(final start=pInitial),
        h_outflow(final start=hInitial))
        annotation (Placement(transformation(extent={{64,-10},{84,10}}, rotation=0),
            iconTransformation(extent={{64,-10},{84,10}})));
     /****************** parameters *******************/

      parameter String inputChoice = "Tube" "|Input|"
      annotation(choices(choice = "Tube", choice="Valve",
      choice="Filter and Mass flow meter"));

      parameter Real kv = 1 "pressure loss coefficient"
                                      annotation(Dialog(group="Input", enable = inputChoice == "Valve"));

     parameter Real kp = 1 "pressure loss coefficient"
                                      annotation(Dialog(group="Input", enable = inputChoice == "Filter and Mass flow meter"));
     inner parameter SI.Diameter Diameter = 0.0052
        "represented inner diameter of tube"   annotation(Dialog(group="Geometry", enable = inputChoice == "Tube"));

     inner parameter SI.Length  Length = 1 "represented Length"
                                           annotation(Dialog(group="Geometry", enable = inputChoice ==  "Tube"));
      parameter Real Roughness = 0.000007 "Roughness of pipe"   annotation(choices(choice = 0 "Glass", choice=0.000005
            "Cobber/brass tubing", choice= 0.000007 "Stainless steel",
                                choice= 0.00015 "Commercial steel"),
                                 Dialog(group="Geometry", enable = inputChoice ==  "Tube"));

      parameter Real K_length = 0
        "Pressure loss from bends given in equivalent length"                             annotation(Dialog(group="Geometry", enable = inputChoice ==  "Tube"),choices(
      choice = 0 "No bends",
      choice = 0.4 "45 degree bend",
      choice = 0.9 "90 degree bend",
      choice = 1.5 "180 degree bend or a tee",
      choice = 0.08 "Threaded union",
      choice = 10 "Globe valve fully open",
      choice = 5 "Angle valve fully open",
      choice = 0.05 "Ball valve fully open",
      choice = 2 "Swing check valve",
      choice = 0.2 "Gate valve fully open",
      choice = 0.3 "Gate vale 1/4 closed",
      choice = 2.1 "Gate valve 1/2 closed",
      choice = 17 "Gate valve 3/4 closed",
      choice =  0 "Type of own equivalent length, eg. sum of 3 bends"));

      SI.Pressure pressureDrop "calculated pressure drop";

      parameter SI.Pressure pInitial = 1.013e5  annotation(Dialog(group="Nominal state"));
      parameter SI.Temperature TInitial = T_amb  annotation(Dialog(group="Nominal state"));

      outer parameter SI.Temperature  T_amb;

     /****************** Start values *******************/
    protected
      parameter SI.SpecificEnthalpy  hInitial=
      Medium.specificEnthalpy_pT(T=TInitial, p=pInitial) annotation(Dialog(tab="Nominal state"));
     // constant Real X[1]={1};
      parameter SI.MassFlowRate m_flowStart = 0.000 annotation(Dialog(tab="Start Values"));
    /******************** Variables *****************************/

    public
      SI.Area A "Area";
      SI.Velocity w "Velocity";
      SI.VolumeFlowRate Vdot "Volume flow rate";
      SI.Density d_in "density";

      SI.DynamicViscosity mu_in "Dynamic viscosity";
      Real ReynoldsNumber "ReynoldsNumber";
      Real FrictionFactor "Friction factor";
      constant SI.Density rho_w = 1000
        "Density for water at 0 C and 1.0314 bars";

      //Exergy
      outer SI.SpecificEntropy s_0;
      outer SI.SpecificEnthalpy h_0;
      SI.Power EA;
      SI.Power EB;
      SI.Power E_D;

    /******************** Equatuions *****************************/

    equation
      medium1=Medium.setState_ph(portA.p,inStream(portA.h_outflow));
      medium2=Medium.setState_ph(portB.p,portB.h_outflow);
      A=Diameter*Diameter*Modelica.Constants.pi/4 "Cross sectional area";
      Vdot=portA.m_flow/d_in "Volume flow";
      w=Vdot/A "Velocity";

    // Setting the enthalpies in the connectors
      portB.h_outflow = inStream(portA.h_outflow);
      portA.h_outflow = inStream(portB.h_outflow);

    // mass and momentum balance
      portA.m_flow + portB.m_flow = 0;
      pressureDrop = portA.p - portB.p;

    //Giving reynolds number if mass flow = 0
        if Vdot <> 0 then
        ReynoldsNumber=d_in*abs(Vdot/A)*Diameter/mu_in;
        else
         ReynoldsNumber=1;
        end if;

    // Calculation of the friction factor
       FrictionFactor=(1/(-1.8*log((6.9/ReynoldsNumber)+
       ((Roughness/Diameter)/3.7)^1.11)))^2;

    //Deciding properties denpendent on the flow direction
      if portA.m_flow >= 0 then
      mediumA=Medium.setState_ph(portA.p,inStream(portA.h_outflow));
      mediumB=Medium.setState_ph(portB.p,portB.h_outflow);
        d_in = max(medium1.d,0.1);
        mu_in=Medium.dynamicViscosity(medium1);
         der(E_D)=der(EA)-der(EB);
      else
      mediumA=Medium.setState_ph(portA.p,portA.h_outflow);
      mediumB=Medium.setState_ph(portB.p,inStream(portB.h_outflow));
        d_in = max(medium2.d,0.1);
        mu_in=Medium.dynamicViscosity(medium2);
        der(E_D)=-der(EA)+der(EB);
      end if;

    //Pressure loss equations
    if inputChoice == "Tube" then
      Vdot=A*Functions.squareRootFunction(pressureDrop, 10)/
      sqrt(0.5*d_in*(K_length+FrictionFactor*Length/Diameter));
    elseif inputChoice == "Valve" then
     Vdot=sqrt(rho_w)*(kv/3600)/sqrt(d_in)*Functions.squareRootFunction(pressureDrop/
     10^5, 1e-3);
     //abs(Vdot)=sqrt(rho_w)*(kv/3600)/sqrt(d_in)*sqrt(max(pressureDrop/10^5,1));
    else
        Vdot=Functions.squareRootFunction(pressureDrop/10^5, 1e-3)/sqrt(0.5*kp*d_in)/3600;
    end if;

    // Exergy
    der(EA)=abs(portA.m_flow)*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)=abs(portA.m_flow)*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));

      annotation (
        preferedView="text",
        Documentation(info="<html>
<p>
HydraulicResistor is a simple pressure drop model.
</p>
<p>
For a given dp:
<br>&Delta;p = &Delta;p_0 * &rho;/&rho;_0 * (Vdot/Vdot_0)        &sup2;
<br>Vdot =         &plusmn; sqrt(|&Delta;p|/&Delta;p_0 * &rho;_0/&rho; Vdot_0&sup2;)
</p>
<p>
For a given zeta:
<br>&Delta;p = &zeta; * &rho;/2 * w&sup2;
<br>Vdot = A * w
<br>Vdot = &plusmn; A * sqrt(|&Delta;p|*2 / (&Delta;p * &zeta;))
</p>
For a tube with a given roughness
<br>ReynoldsNumber=d_in*|Vdot/A|*hydraulicDiameter/mu_in
<br>FrictionFactor=(1/(-1.8*log((6.9/ReynoldsNumber)+((Roughness/hydraulicDiameter)/3.7)^1.11)))^2
<br>Vdot = A * sqrt(2*L / (FrictionFactor * rho * d_h))*sqrt(&Delta;p)
</html>"),        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-80,-40},{80,40}},
            initialScale=0.1), graphics={Bitmap(extent={{-78,38},{76,-40}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/Tube.png")}),
        Diagram(coordinateSystem(extent={{-80,-40},{80,40}}, preserveAspectRatio=false),
                                                              graphics));
    end PressureLoss;

    model TubeWithheatTransfer
      import SI = Modelica.SIunits;
      import Constant = Modelica.Constants;

    /*********************** Thermodynamic property call ***********************************/
     replaceable package Medium = CoolProp2Modelica.Media.Hydrogen
                                                   annotation (choicesAllMatching=true);

    Medium.ThermodynamicState mediumA;
    Medium.ThermodynamicState mediumB;

    /******************** Connectors *****************************/
      Ports.FlowPort portA(
        p(final start=pInitial),
        h_outflow(final start=hInitial),
        m_flow(final start=m_flowStart))
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Ports.FlowPort portB(p(final start=pInitial), h_outflow(
            final start=hInitial))
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      Ports.TemperaturePort                     HTIn
        annotation (Placement(transformation(extent={{66,-38},{86,-18}}),
            iconTransformation(extent={{66,-42},{86,-22}})));
      Ports.HeatFlowTube                       HTOut
        annotation (Placement(transformation(extent={{-88,-42},{-68,-22}}),
            iconTransformation(extent={{-88,-42},{-68,-22}})));

    /****************** General parameters *******************/
     parameter SI.Diameter DiameterInner = 0.0052
        "represented hydraulic inner diameter of tube"   annotation(Dialog(group="Geometry", enable = inputChoice == "zeta" or "Tube"));

          parameter SI.Diameter DiameterOuter = 0.0095 "Outer diameter of tube"
                                   annotation(Dialog(group="Geometry", enable = inputChoice == "zeta" or "Tube"));

     parameter SI.Length  Length = 1 "represented Length"
                                           annotation(Dialog(group="Geometry", enable = inputChoice ==  "Tube"));
      parameter Real Roughness = 0.000007 "Roughness of pipe"   annotation(choices(choice = 0 "Glass", choice=0.000005
            "Cobber/brass tubing",                                                                                                    choice= 0.000007
            "Stainless steel",                                                                                                    choice= 0.00015
            "Commercial steel"),                                                                                                    Dialog(group="Geometry", enable = inputChoice ==  "Tube"));

    protected
     parameter SI.MassFlowRate m_flowStart = 0.000 annotation(Dialog(tab="Start Values"));
     parameter SI.SpecificEnthalpy  hInitial=
     Medium.specificEnthalpy_pT(T=TInitial, p=pInitial) annotation(Dialog(tab="Nominal state"));

    //Initial values
    public
     parameter SI.Pressure pInitial = 1.013e5  annotation(Dialog(group="Nominal state", enable = inputChoice == "dp" or "zeta" or "tube"));
     parameter SI.Temperature TInitial = T_amb  annotation(Dialog(group="Nominal state", enable = inputChoice == "dp" or "zeta" or "tube"));
     outer parameter SI.Temperature  T_amb;

    /****************** variables *******************/
    SI.Area A_cross=(DiameterInner/2)^2*Constant.pi;
    SI.Area A_surface=DiameterInner*Constant.pi*Length;
    SI.Temperature T_in;
    //SI.Temperature T_b;
    SI.Temperature T_out(start=T_amb);
    SI.Density d_in;
    SI.VolumeFlowRate Vdot;
    SI.Pressure pressureDrop;

    //Heat Transfer unknowns
    SI.CoefficientOfHeatTransfer h;
      SI.DynamicViscosity mu_in;
      Real ReynoldsNumber;
      Real FrictionFactor;
      Real Pr;
      Real Nu;
      Real BiotNumber;
      SI.SpecificHeatCapacity cp;
      SI.HeatFlowRate Q_new;
       SI.SpecificEnthalpy dh;

    /****************** equations *******************/
    equation
    portA.m_flow+portB.m_flow=0;
    T_in=HTOut.T;

    Vdot=portA.m_flow/d_in;

    //Heat transfer equations
        if Vdot<>0 then
        ReynoldsNumber=d_in*abs(Vdot/A_cross)*DiameterInner/mu_in;
        else
        ReynoldsNumber=0.1;
        end if;

       BiotNumber=h*((DiameterOuter-DiameterInner)/2)/14;
       FrictionFactor=(1/(-1.8*log((6.9/ReynoldsNumber)+
       ((Roughness/DiameterInner)/3.7)^1.11)))^2;

       Nu=0.023*ReynoldsNumber^(4/5)*Pr^(0.3);

    if Vdot>=0 then
     mediumA = Medium.setState_ph(portA.p, inStream(portA.h_outflow));
     mediumB = Medium.setState_pT(portB.p,HTIn.T);
     mediumA.T=T_in;
     d_in=mediumA.d;
     mu_in=Medium.dynamicViscosity(mediumA);
     Pr=mediumA.cp*mu_in/mediumA.lambda;
     h=Nu*mediumA.lambda/DiameterInner;
     cp=mediumA.cp;
       else
    mediumB = Medium.setState_ph(portB.p, inStream(portB.h_outflow));
    mediumA = Medium.setState_pT(portA.p, HTIn.T);
    mediumB.T=T_in;
    d_in=mediumB.d;
    mu_in=Medium.dynamicViscosity(mediumB);
    Pr=mediumB.cp*mu_in/mediumB.lambda;
     h=Nu*mediumB.lambda/DiameterInner;
    cp=mediumB.cp;
       end if;

    //inStream(portA.h_outflow)*portA.m_flow+portB.h_outflow*portA.m_flow+Q_new=0;
    inStream(portB.h_outflow)=portA.h_outflow+dh;
    inStream(portA.h_outflow)=portB.h_outflow+dh;

    dh=Medium.specificEnthalpy(mediumA)-Medium.specificEnthalpy(mediumB);
    actualStream(portA.h_outflow)*portA.m_flow+
    actualStream(portB.h_outflow)*portA.m_flow+Q_new=0;

     Vdot = A_cross*sqrt(2*DiameterInner/(FrictionFactor*d_in*Length))*
     TIL_Hydrogen_CoolProp.Functions.squareRootFunction(pressureDrop, 10);
    pressureDrop = portA.p - portB.p;
    HTIn.T=T_out;
    HTOut.cp=cp;
    HTOut.h=h;
    HTOut.m_flow=portA.m_flow;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                                         Bitmap(extent={{-76,38},{78,-40}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/Tube.png")}));
    end TubeWithheatTransfer;

    model PressureLossWithControl

      import SI = Modelica.SIunits;
    /*********************** Thermodynamic properties ***********************************/
        replaceable package Medium =
          CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium
        "The library called to obtain properties for the fluid";
    //Modelica.Media.Interfaces.PartialMedium
           Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState medium1;
           Medium.ThermodynamicState medium2;

    /******************** Connectors *****************************/

    public
      Ports.FlowPort portA(
        p(final start=pInitial),
        h_outflow(final start=hInitial),
        m_flow(final start=m_flowStart))
        annotation (Placement(transformation(extent={{-86,-10},{-66,10}}, rotation=
                0), iconTransformation(extent={{-88,-10},{-68,10}})));
      Ports.FlowPort portB(
        p(final start=pInitial),
        h_outflow(final start=hInitial))
        annotation (Placement(transformation(extent={{64,-10},{84,10}}, rotation=0),
            iconTransformation(extent={{64,-10},{84,10}})));
      Ports.PressurePort pp1 annotation (Placement(transformation(extent={{
                -70,20},{-50,40}}), iconTransformation(extent={{-70,20},{-50,40}})));
      Ports.PressurePort pp2 annotation (Placement(transformation(extent={
                {50,20},{70,40}}), iconTransformation(extent={{50,20},{70,40}})));
     /****************** parameters *******************/

      parameter String inputChoice = "Tube" "|Input|"
      annotation(choices(choice = "Tube", choice="Valve",
      choice="Filter and Mass flow meter"));

      parameter Real kv = 1 "pressure loss coefficient"
                                      annotation(Dialog(group="Input", enable = inputChoice == "Valve"));

     parameter Real kp = 1 "pressure loss coefficient"
                                      annotation(Dialog(group="Input", enable = inputChoice == "Filter and Mass flow meter"));
     inner parameter SI.Diameter Diameter = 0.0052
        "represented inner diameter of tube"   annotation(Dialog(group="Geometry", enable = inputChoice == "Tube"));

     inner parameter SI.Length  Length = 1 "represented Length"
                                           annotation(Dialog(group="Geometry", enable = inputChoice ==  "Tube"));
      parameter Real Roughness = 0.000007 "Roughness of pipe"   annotation(choices(choice = 0 "Glass", choice=0.000005
            "Cobber/brass tubing", choice= 0.000007 "Stainless steel",
                                choice= 0.00015 "Commercial steel"),
                                 Dialog(group="Geometry", enable = inputChoice ==  "Tube"));

      parameter Real K_length = 0
        "Pressure loss from bends given in equivalent length"                             annotation(Dialog(group="Geometry", enable = inputChoice ==  "Tube"),choices(
      choice = 0 "No bends",
      choice = 0.4 "45 degree bend",
      choice = 0.9 "90 degree bend",
      choice = 1.5 "180 degree bend or a tee",
      choice = 0.08 "Threaded union",
      choice = 10 "Globe valve fully open",
      choice = 5 "Angle valve fully open",
      choice = 0.05 "Ball valve fully open",
      choice = 2 "Swing check valve",
      choice = 0.2 "Gate valve fully open",
      choice = 0.3 "Gate vale 1/4 closed",
      choice = 2.1 "Gate valve 1/2 closed",
      choice = 17 "Gate valve 3/4 closed",
      choice =  0 "Type of own equivalent length, eg. sum of 3 bends"));

      SI.Pressure pressureDrop "calculated pressure drop";

      parameter SI.Pressure pInitial = 1.013e5  annotation(Dialog(group="Nominal state"));
      parameter SI.Temperature TInitial = T_amb  annotation(Dialog(group="Nominal state"));

      outer parameter SI.Temperature  T_amb;

     /****************** Start values *******************/
    protected
      parameter SI.SpecificEnthalpy  hInitial=
      Medium.specificEnthalpy_pT(T=TInitial, p=pInitial) annotation(Dialog(tab="Nominal state"));
     // constant Real X[1]={1};
      parameter SI.MassFlowRate m_flowStart = 0.000 annotation(Dialog(tab="Start Values"));
    /******************** Variables *****************************/

    public
      SI.Area A "Area";
      SI.Velocity w "Velocity";
      SI.VolumeFlowRate Vdot "Volume flow rate";
      SI.Density d_in "density";

      SI.DynamicViscosity mu_in "Dynamic viscosity";
      Real ReynoldsNumber "ReynoldsNumber";
      Real FrictionFactor "Friction factor";
      constant SI.Density rho_w = 1000
        "Density for water at 0 C and 1.0314 bars";

      //Exergy
      outer SI.SpecificEntropy s_0;
      outer SI.SpecificEnthalpy h_0;
      SI.Power EA;
      SI.Power EB;
      SI.Power E_D;

    /******************** Equatuions *****************************/

    equation
      medium1=Medium.setState_ph(portA.p,inStream(portA.h_outflow));
      medium2=Medium.setState_ph(portB.p,portB.h_outflow);
      A=Diameter*Diameter*Modelica.Constants.pi/4 "Cross sectional area";
      Vdot=portA.m_flow/d_in "Volume flow";
      w=Vdot/A "Velocity";

    // Setting the enthalpies in the connectors
      portB.h_outflow = inStream(portA.h_outflow);
      portA.h_outflow = inStream(portB.h_outflow);

    // mass and momentum balance
      portA.m_flow + portB.m_flow = 0;
      pressureDrop = portA.p - portB.p;

    //Giving reynolds number if mass flow = 0
        if Vdot <> 0 then
        ReynoldsNumber=d_in*abs(Vdot/A)*Diameter/mu_in;
        else
         ReynoldsNumber=1;
        end if;

    // Calculation of the friction factor
       FrictionFactor=(1/(-1.8*log((6.9/ReynoldsNumber)+
       ((Roughness/Diameter)/3.7)^1.11)))^2;

    //Deciding properties denpendent on the flow direction
      if portA.p > portB.p then
      mediumA=Medium.setState_ph(portA.p,inStream(portA.h_outflow));
      mediumB=Medium.setState_ph(portB.p,portB.h_outflow);
        d_in = max(medium1.d,0);
        mu_in=Medium.dynamicViscosity(medium1);
         der(E_D)=der(EA)-der(EB);
      else
      mediumA=Medium.setState_ph(portA.p,portA.h_outflow);
      mediumB=Medium.setState_ph(portB.p,inStream(portB.h_outflow));
        d_in = max(medium2.d,0);
        mu_in=Medium.dynamicViscosity(medium2);
        der(E_D)=-der(EA)+der(EB);
      end if;

    //Pressure loss equations
    if inputChoice == "Tube" then
      Vdot=A*Functions.squareRootFunction(pressureDrop, 10)/
      sqrt(0.5*d_in*(K_length+FrictionFactor*Length/Diameter));
    elseif inputChoice == "Valve" then
     Vdot=sqrt(rho_w)*(kv/3600)/sqrt(d_in)*Functions.squareRootFunction(pressureDrop/
     10^5, 1e-3);
     //abs(Vdot)=sqrt(rho_w)*(kv/3600)/sqrt(d_in)*sqrt(max(pressureDrop/10^5,1));
    else
        Vdot=Functions.squareRootFunction(pressureDrop/10^5, 1e-3)/sqrt(0.5*kp*d_in)/3600;
    end if;

    pp1.p=portA.p;
    pp2.p=portB.p;

    // Exergy
    der(EA)=abs(portA.m_flow)*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)=abs(portA.m_flow)*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));

      annotation (
        preferedView="text",
        Documentation(info="<html>
<p>
HydraulicResistor is a simple pressure drop model.
</p>
<p>
For a given dp:
<br>&Delta;p = &Delta;p_0 * &rho;/&rho;_0 * (Vdot/Vdot_0)        &sup2;
<br>Vdot =         &plusmn; sqrt(|&Delta;p|/&Delta;p_0 * &rho;_0/&rho; Vdot_0&sup2;)
</p>
<p>
For a given zeta:
<br>&Delta;p = &zeta; * &rho;/2 * w&sup2;
<br>Vdot = A * w
<br>Vdot = &plusmn; A * sqrt(|&Delta;p|*2 / (&Delta;p * &zeta;))
</p>
For a tube with a given roughness
<br>ReynoldsNumber=d_in*|Vdot/A|*hydraulicDiameter/mu_in
<br>FrictionFactor=(1/(-1.8*log((6.9/ReynoldsNumber)+((Roughness/hydraulicDiameter)/3.7)^1.11)))^2
<br>Vdot = A * sqrt(2*L / (FrictionFactor * rho * d_h))*sqrt(&Delta;p)
</html>"),        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-80,-40},{80,40}},
            initialScale=0.1), graphics={Bitmap(extent={{-78,38},{76,-40}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/Tube.png")}),
        Diagram(coordinateSystem(extent={{-80,-40},{80,40}}, preserveAspectRatio=false),
                                                              graphics));
    end PressureLossWithControl;

    model AveragePressureRampRateNewSystem
      import SI = Modelica.SIunits;
    /*********************** Thermodynamic properties ***********************************/
         replaceable package Medium =
          CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Thermodynamic properties"));

    /******************** Connectors *****************************/
    public
       Ports.FlowPort portA(
         p(final start=pInitial),
         h_outflow(final start=hInitial),
         m_flow(final start=m_flowInitial))
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}}, rotation=
                0), iconTransformation(extent={{-60,-10},{-40,10}})));

      Ports.FlowPort portB(
        p(final start=pInitial),
        h_outflow(final start=hInitial))
            annotation (Placement(transformation(extent={{50,-10},{70,10}}, rotation=0),
            iconTransformation(extent={{42,-10},{62,10}})));
       Ports.PressurePort pp1
         annotation (Placement(transformation(extent={{-10,26},{10,46}}),
             iconTransformation(extent={{-10,38},{10,58}})));

     /****************** parameters *******************/

      parameter Boolean SAEJ2601 = true
        "If true, the ramp rate is retrieved from J2601"                              annotation(Evaluate=true, Dialog(group="Average pressure ramp rate"));
      parameter SI.Pressure APRR2=28e6 "MPa/min - Alternative refueling rate" annotation(Dialog(group="Average pressure ramp rate", enable = SAEJ2601 == false));

       parameter SI.Pressure pInitial = 1.013e5  annotation(Dialog(group="Initial Values"));
       parameter SI.Temperature TInitial = T_amb  annotation(Dialog(group="Initial Values"));

      outer SI.Pressure APRR "MPa/min";
     // outer Integer z3;
      outer Integer z5;
      outer parameter SI.Temperature T_amb;
      Real APRR_used;
      SI.Pressure dp;

     /****************** Start values *******************/
    protected
       parameter SI.SpecificEnthalpy hInitial=Medium.specificEnthalpy_pT(T=TInitial,
        p=pInitial) annotation(Dialog(group="Initial Values"));
       parameter SI.MassFlowRate m_flowInitial = 0.0000 annotation(Dialog(group="Initial Values",enable = SAE2601==false));

    equation
      portB.h_outflow =inStream(portA.h_outflow);
      portA.h_outflow= inStream(portB.h_outflow);
    //Deciding which ramp rate to be used
    if SAEJ2601==true then
      APRR=APRR_used;
    else
      APRR_used=APRR2;
    end if;

    portA.p-portB.p=dp "Momentum balance";
    //Deciding APRR for controls and mass balances
    if z5==0 then
      der(portA.p) = APRR/60;
      dp=0;
      portA.m_flow + portB.m_flow = 0;
    //  portA.m_flow=dummy;
    else
    der(portA.p) = 0;
    portB.m_flow=0;
    portA.m_flow=0;
    //der(portA.p)=dummy;
     end if;

       pp1.p=portA.p;
      annotation (
        preferedView="text",
        Documentation(info="<html>
<p>
HydraulicResistor is a simple pressure drop model.
</p>
<p>
For a given dp:
<br>&Delta;p = &Delta;p_0 * &rho;/&rho;_0 * (Vdot/Vdot_0)        &sup2;
<br>Vdot =         &plusmn; sqrt(|&Delta;p|/&Delta;p_0 * &rho;_0/&rho; Vdot_0&sup2;)
</p>
<p>
For a given zeta:
<br>&Delta;p = &zeta; * &rho;/2 * w&sup2;
<br>Vdot = A * w
<br>Vdot = &plusmn; A * sqrt(|&Delta;p|*2 / (&Delta;p * &zeta;))
</p>
</html>"),        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-60,-40},{60,60}},
            initialScale=0.1), graphics={Bitmap(extent={{-50,56},{54,-48}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/APRR.png")}),
        Diagram(coordinateSystem(extent={{-60,-40},{60,60}})));
    end AveragePressureRampRateNewSystem;
  end PressureLosses;

  package Compressor
    model Compressor
      import SI = Modelica.SIunits;

    /******************** Thermodynamic properties*****************************/
        replaceable package Medium =
           CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));

           Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState mediumIS;

    /******************** Ports *****************************/
      Ports.FlowPort                      portA
        annotation (Placement(transformation(extent={{-56,-10},{-36,10}}),
            iconTransformation(extent={{-28,-10},{-8,10}})));
      Ports.FlowPort                      portB
        annotation (Placement(transformation(extent={{40,-10},{60,10}}),
            iconTransformation(extent={{68,-10},{88,10}})));

    /******************** parameters *****************************/
    parameter String CompressorType = "Isentropic" "|Input|" annotation(Dialog(group="Input"),choices(choice = "Isentropic", choice="Polytropic"));

    parameter Integer Strokes=500 "Strokes pr. minut" annotation(Dialog(group="Input"));
    parameter SI.Volume V=0.0001 "Volume of cylinder" annotation(Dialog(group="Input"));
    outer parameter SI.Temperature T_amb;
    /******************** variables *****************************/
    SI.Efficiency eta_is "Isentropic efficiency";
    SI.Efficiency eta_poly "polytropic efficiency";
    SI.Efficiency eta
        "Efficiency of compression, either isentropic or polytropic";
    Real r "Pressure ratio";
    SI.Heat W "Work added to the compression";
    SI.Efficiency VolumetricEfficiency "Volumetric efficiency";
    SI.VolumeFlowRate Vdot "volume flow";
    SI.SpecificEnthalpy dh "Change of enthalpy across the compressor";

    SI.SpecificEnthalpy h_out "Discharge enthalpy of the compressor";
    //exergy
    outer SI.SpecificEntropy s_0;
    outer SI.SpecificEnthalpy h_0;
    SI.Power EA;
    SI.Power EB;
    SI.Power E_D;

    /******************** Equations *****************************/
    equation
    //Dimensioning the compressor and finding the mass and volume flow
    VolumetricEfficiency=-0.05*(r)+0.9 "Volumetric efficiency";
    portA.m_flow=V*mediumA.d*VolumetricEfficiency*Strokes/60 "Mass flow rate";
    Vdot=portA.m_flow/mediumA.d "Volume flowrate";

    // Chooses between isentropic and polytropic efficiency
    //depending users input choice
    if CompressorType == "Isentropic" then
      eta=eta_is;
    else
      eta=eta_poly;
    end if;

    //Compressor equations, the isentropic efficiency
      eta_is=0.1091*(log(r))^3-0.5247*(log(r))^2+0.8577*log(r)+0.3727
        "Valid in the range of 1.1<r<5";
    //Compressor equations, the polytropic efficiency
         eta_poly=0.017*log(Vdot)+0.7;

      r=portB.p/portA.p "Pressure ratio";

    //Finding the properties of the hydrogen in and out of the compressor
      mediumA=Medium.setState_ph(portA.p, inStream(portA.h_outflow));
      mediumIS=Medium.setState_ps(portB.p, Medium.specificEntropy(mediumA));
      mediumB=Medium.setState_ph(portB.p, h_out);

    //Calculating the discharge enthalpy
      h_out=Medium.specificEnthalpy(mediumA)+(mediumIS.h
      -Medium.specificEnthalpy(mediumA))/eta;

    // Balance equations
     portA.m_flow+portB.m_flow=0 "Mass balance";
     portA.h_outflow = inStream(portB.h_outflow)+dh
        "The change in enthalpy across the compressor, inlet";
     portB.h_outflow = inStream(portA.h_outflow)+dh
        "The change in enthalpy across the compressor, outlet";
     actualStream(portA.h_outflow)*portA.m_flow + der(W)
     + actualStream(portB.h_outflow)*portB.m_flow=0 "Energy balance were Q=W";
     dh=-Medium.specificEnthalpy(mediumA)+Medium.specificEnthalpy(mediumB)
        "specific enthalpy difference between in and outlet";
    //Exergy
    der(EA)=portA.m_flow*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)=portA.m_flow*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));
    der(E_D)=(der(EA)+der(W))-der(EB);

      annotation (preferedView="text",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-40,-20},
                {100,60}}),             graphics={Bitmap(extent={{-42,58},{102,-18}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/PistonCompressor.png")}),
        Diagram(coordinateSystem(extent={{-40,-20},{100,60}})),
        Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"));
    end Compressor;

    model CompressorWithStop
      "Used for a cascade fuelling were the compressor should start after switch of tanks"
      import SI = Modelica.SIunits;
    // Fluid properties
        replaceable package Medium =
           CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));

           Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState mediumIS;

    // Ports
      Ports.FlowPort                      portA
        annotation (Placement(transformation(extent={{-56,-10},{-36,10}}),
            iconTransformation(extent={{-26,-10},{-6,10}})));
      Ports.FlowPort                      portB
        annotation (Placement(transformation(extent={{40,-10},{60,10}}),
            iconTransformation(extent={{70,-10},{90,10}})));

    // parameters and constants
    parameter String CompressorType = "Isentropic" "|Input|" annotation(Dialog(group="Input"),choices(choice = "Isentropic", choice="Polytropic"));

    parameter Integer Strokes=500 "Strokes pr. minut" annotation(Dialog(group="Input"));
    parameter SI.Volume V=0.0001 "Volume of cylinder" annotation(Dialog(group="Input"));
    parameter Integer Stop=7 "Numver of tanks to be fueled" annotation(Dialog(group="Input"));
    outer Integer z2;
    outer Integer z1;
    outer parameter SI.Temperature T_amb;
    // Variables
    //SI.Efficiency eta_is "Isentropic efficiency";
    //SI.Efficiency eta_poly "polytropic efficiency";
    SI.Efficiency eta
        "Efficiency of compression, either isentropic or polytropic";
    Real r "Pressure ratio";
    SI.HeatFlowRate W "Work added to the compression";
    SI.Efficiency VolumetricEfficiency "Volumetric efficiency";
    SI.VolumeFlowRate Vdot "volume flow";
    SI.SpecificEnthalpy dh "Change of enthalpy across the compressor";

    SI.SpecificEnthalpy h_out "Discharge enthalpy of the compressor";
    //exergy
    outer SI.SpecificEntropy s_0;
    outer SI.SpecificEnthalpy h_0;
    SI.Power EA;
    SI.Power EB;
    SI.Power E_D;
    equation
    //Dimensioning the compressor and finding the mass and volume flow
    VolumetricEfficiency=-0.05*(r)+0.9 "Volumetric efficiency";
    //portA.m_flow=V*mediumA.d*VolumetricEfficiency*Strokes/60 "Mass flow rate";
    Vdot=portA.m_flow/mediumA.d "Volume flowrate";

      if z2==Stop or z1<=1 then
      portA.m_flow=0;
      else
      portA.m_flow=V*mediumA.d*VolumetricEfficiency*Strokes/60 "Mass flow rate";
      end if;

    // Chooses between isentropic and polytropic efficiency depending users input choice
    if CompressorType == "Isentropic" then
     //Compressor equations, the isentropic efficiency
      eta=0.1091*(log(r))^3-0.5247*(log(r))^2+0.8577*log(r)+0.3727
          "Valid in the range of 1.1<r<5";
    else
      //Compressor equations, the polytropic efficiency
         eta=0.017*log(Vdot)+0.7;
    end if;

    //Compressor equations, the isentropic efficiency
      //eta_is=0.1091*(log(r))^3-0.5247*(log(r))^2+0.8577*log(r)+0.3727
    //    "Valid in the range of 1.1<r<5";

       r=max(portB.p/portA.p,1) "Pressure ratio";

    //Finding the properties of the hydrogen in and out of the compressor
      mediumA=Medium.setState_ph(portA.p, inStream(portA.h_outflow));
      mediumIS=Medium.setState_ps(portB.p, Medium.specificEntropy(mediumA));
      mediumB=Medium.setState_ph(portB.p, h_out);

    //Calculating the discharge enthalpy
      h_out=Medium.specificEnthalpy(mediumA)+(mediumIS.h-Medium.specificEnthalpy(mediumA))/eta;

    // Balance equations
     portA.m_flow+portB.m_flow=0 "Mass balance";
     portA.h_outflow = inStream(portB.h_outflow)+dh
        "The change in enthalpy across the compressor, inlet";
     portB.h_outflow = inStream(portA.h_outflow)+dh
        "The change in enthalpy across the compressor, outlet";
     inStream(portA.h_outflow)*portA.m_flow + der(W) +portB.h_outflow*portB.m_flow=0
        "Energy balance were Q=W";
     dh=-Medium.specificEnthalpy(mediumA)+Medium.specificEnthalpy(mediumB)
        "specific enthalpy difference between in and outlet";
    //Exergy
    der(EA)=portA.m_flow*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)=portA.m_flow*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));
    der(E_D)=(der(EA)+der(W))-der(EB);
      annotation (preferedView="text",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-40,-20},
                {100,60}}),             graphics={Bitmap(extent={{-40,56},{106,-20}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/PistonCompressor.png")}),
        Diagram(coordinateSystem(extent={{-40,-20},{100,60}})),
        Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"));
    end CompressorWithStop;

    model CompressorWithVariableVolume
      "Compressor that has variable volume, variates to satisfy a mass flow at different suction pressures"
      import SI = Modelica.SIunits;
    // Fluid properties
    //replaceable package Medium2 =
    //      MediaTwoPhaseMixture.REFPROPMediumPureSubstance ( final substanceNames={"hydrogen"});

    //Medium.BaseProperties mediumIS;

        replaceable package Medium =
           CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));

           Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState mediumIS;

    // Ports
      Ports.FlowPort portA
        annotation (Placement(transformation(extent={{-56,-10},{-36,10}}),
            iconTransformation(extent={{-26,-10},{-6,10}})));
      Ports.FlowPort portB
        annotation (Placement(transformation(extent={{40,-10},{60,10}}),
            iconTransformation(extent={{70,-10},{90,10}})));
      Ports.PressurePort pressurePort annotation (Placement(transformation(extent={{
                -36,34},{-16,54}}), iconTransformation(extent={{-36,34},{-16,54}})));
      Ports.PressurePort pressurePort1 annotation (Placement(transformation(extent={
                {82,34},{102,54}}), iconTransformation(extent={{82,34},{102,54}})));
    // parameters and constants
    parameter String CompressorType = "Isentropic" "|Input|" annotation(Dialog(group="Input"),choices(choice = "Isentropic", choice="Polytropic"));
    parameter Integer Strokes=500 annotation(Dialog(group="Input"));
    parameter Integer Stop=7 annotation(Dialog(group="Input"));
    outer Integer  z1;
    outer parameter SI.Temperature T_amb;
    // Variables
    SI.Efficiency eta_is;
    SI.Efficiency eta_poly;
    SI.Efficiency eta;
    Real r;
    SI.Volume V;
    SI.HeatFlowRate W;
    SI.Efficiency VolumetricEfficiency;
    SI.VolumeFlowRate Vdot;
    SI.SpecificEnthalpy dh;
    SI.SpecificEnthalpy h_out;
    //exergy
    outer SI.SpecificEntropy s_0;
    outer SI.SpecificEnthalpy h_0;
    SI.Power EA;
    SI.Power EB;
    SI.Power E_D;

    equation
    if CompressorType == "Isentropic" then
      eta=eta_is;
    else
      eta=eta_poly;
    end if;

    //Compressor equations, the isentropic efficiency
      eta_is=0.1091*(log(r))^3-0.5247*(log(r))^2+0.8577*log(r)+0.3727
        "Valid in the range of 1.1<r<5";
    //Compressor equations, the polytropic efficiency
         eta_poly=0.017*log(Vdot)+0.7;

    //Dimensioning the compressor and finding the mass and volume flow
    VolumetricEfficiency=-0.05*(r)+0.9 "Volumetric efficiency";
    portA.m_flow=V*mediumA.d*VolumetricEfficiency*Strokes/60 "Mass flow rate";
    Vdot=portA.m_flow/mediumA.d "Volume flowrate";

    if z1==0 then
      V=0.00225;
    elseif z1==1 then
      V=0.00075;
    else
      V=0.000237;
    end if;

    //Compressor equations, the isentropic efficiency and temperature out
      eta_is=0.1091*(log(r))^3-0.5247*(log(r))^2+0.8577*log(r)+0.3727
        "Valid in the range of 1.1<r<5";
      r=portB.p/portA.p "Pressure ratio";

    //Finding the properties of the hydrogen in and out of the compressor
      mediumA=Medium.setState_ph(portA.p, inStream(portA.h_outflow));
      mediumIS=Medium.setState_ps(portB.p, Medium.specificEntropy(mediumA));
      mediumB=Medium.setState_ph(portB.p, h_out);

    // The enthalpy at the discharge of the compressor
      h_out=Medium.specificEnthalpy(mediumA)+(mediumIS.h-Medium.specificEnthalpy(mediumA))/eta_is;

    // Balance equations
     portA.m_flow+portB.m_flow=0 "Mass balance";
     portA.h_outflow = inStream(portB.h_outflow)+dh
        "The change in enthalpy across the compressor, inlet";
     portB.h_outflow = inStream(portA.h_outflow)+dh
        "The change in enthalpy across the compressor, outlet";

     inStream(portA.h_outflow)*portA.m_flow + der(W) +portB.h_outflow*portB.m_flow=0
        "Energy balance were Q=W";
     dh=-Medium.specificEnthalpy(mediumA)+Medium.specificEnthalpy(mediumB)
        "specific enthalpy difference between in and outlet";
    //Exergy
    der(EA)=portA.m_flow*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)=portA.m_flow*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));
    der(E_D)=(der(EA)+der(W))-der(EB);

    pressurePort.p=portA.p;
    pressurePort1.p=portB.p;

      annotation (preferedView="text",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-40,-20},
                {100,60}}),             graphics={Bitmap(extent={{-40,56},{106,-20}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/PistonCompressor.png")}),
        Diagram(coordinateSystem(extent={{-40,-20},{100,60}})),Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"));
    end CompressorWithVariableVolume;

    model CompressorDirectFuelling
      "Used for a cascade fuelling were the compressor should start after switch of tanks"
      import SI = Modelica.SIunits;
    // Fluid properties
        replaceable package Medium =
           CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));

           Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState mediumIS;

    // Ports
      Ports.FlowPort                      portA
        annotation (Placement(transformation(extent={{-56,-10},{-36,10}}),
            iconTransformation(extent={{-26,-10},{-6,10}})));
      Ports.FlowPort                      portB
        annotation (Placement(transformation(extent={{40,-10},{60,10}}),
            iconTransformation(extent={{70,-10},{90,10}})));

    // parameters and constants
    parameter String CompressorType = "Isentropic" "|Input|" annotation(Dialog(group="Input"),choices(choice = "Isentropic", choice="Polytropic"));

    parameter Integer Strokes=500 "Strokes pr. minut" annotation(Dialog(group="Input"));
    parameter SI.Volume V=0.0001 "Volume of cylinder" annotation(Dialog(group="Input"));
    parameter Integer Stop=7 "Numver of tanks to be fueled" annotation(Dialog(group="Input"));
    outer Integer z4;

    outer parameter SI.Temperature T_amb;
    // Variables
    //SI.Efficiency eta_is "Isentropic efficiency";
    //SI.Efficiency eta_poly "polytropic efficiency";
    SI.Efficiency eta
        "Efficiency of compression, either isentropic or polytropic";
    Real r "Pressure ratio";
    SI.HeatFlowRate W "Work added to the compression";
    SI.Efficiency VolumetricEfficiency "Volumetric efficiency";
    SI.VolumeFlowRate Vdot "volume flow";
    SI.SpecificEnthalpy dh "Change of enthalpy across the compressor";

    SI.SpecificEnthalpy h_out "Discharge enthalpy of the compressor";
    //exergy
    outer SI.SpecificEntropy s_0;
    outer SI.SpecificEnthalpy h_0;
    SI.Power EA;
    SI.Power EB;
    SI.Power E_D;
    equation
    //Dimensioning the compressor and finding the mass and volume flow
    VolumetricEfficiency=-0.05*(r)+0.9 "Volumetric efficiency";
    //portA.m_flow=V*mediumA.d*VolumetricEfficiency*Strokes/60 "Mass flow rate";
    Vdot=portA.m_flow/mediumA.d "Volume flowrate";

      if z4 == 0 then
      portA.m_flow=0;
      else
      portA.m_flow=V*mediumA.d*VolumetricEfficiency*Strokes/60 "Mass flow rate";
      end if;

    // Chooses between isentropic and polytropic efficiency depending users input choice
    if CompressorType == "Isentropic" then
     //Compressor equations, the isentropic efficiency
      eta=0.1091*(log(r))^3-0.5247*(log(r))^2+0.8577*log(r)+0.3727
          "Valid in the range of 1.1<r<5";
    else
      //Compressor equations, the polytropic efficiency
         eta=0.017*log(Vdot)+0.7;
    end if;

    //Compressor equations, the isentropic efficiency
      //eta_is=0.1091*(log(r))^3-0.5247*(log(r))^2+0.8577*log(r)+0.3727
    //    "Valid in the range of 1.1<r<5";

       r=max(portB.p/portA.p,0.1) "Pressure ratio";

    //Finding the properties of the hydrogen in and out of the compressor
      mediumA=Medium.setState_ph(portA.p, inStream(portA.h_outflow));
      mediumIS=Medium.setState_ps(portB.p, Medium.specificEntropy(mediumA));
      mediumB=Medium.setState_ph(portB.p, h_out);

    //Calculating the discharge enthalpy
      h_out=Medium.specificEnthalpy(mediumA)+(mediumIS.h-Medium.specificEnthalpy(mediumA))/eta;

    // Balance equations
     portA.m_flow+portB.m_flow=0 "Mass balance";
     portA.h_outflow = inStream(portB.h_outflow)+dh
        "The change in enthalpy across the compressor, inlet";
     portB.h_outflow = inStream(portA.h_outflow)+dh
        "The change in enthalpy across the compressor, outlet";
     inStream(portA.h_outflow)*portA.m_flow + der(W) +portB.h_outflow*portB.m_flow=0
        "Energy balance were Q=W";
     dh=-Medium.specificEnthalpy(mediumA)+Medium.specificEnthalpy(mediumB)
        "specific enthalpy difference between in and outlet";
    //Exergy
    der(EA)=portA.m_flow*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)=portA.m_flow*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));
    der(E_D)=(der(EA)+der(W))-der(EB);
      annotation (preferedView="text",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-40,-20},
                {100,60}}),             graphics={Bitmap(extent={{-40,56},{106,-20}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/PistonCompressor.png")}),
        Diagram(coordinateSystem(extent={{-40,-20},{100,60}})),
        Documentation(info="<html>
        <a href=\"../Documentation/HydrogenLibaryDocumnetation.pdf\">PhD project by Erasmus Rothuizen</a><br><br>
        </html>"));
    end CompressorDirectFuelling;
  end Compressor;

  package HeatExchangers
    model HeatExchangerFixedTemperature
      "Simple heat exchanger setting the outlet temperature"

     import SI = Modelica.SIunits
        "Renemaing the path to the SI units in modelica library";

    /******************** thermodynamic properties *****************************/
        replaceable package Medium =
           CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState mediumA;

    /******************** Connectors *****************************/

      Ports.FlowPort portA
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Ports.FlowPort portB
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));

    /******************** parameters *****************************/
     Boolean SAEJ2601=true "Use SAE's outlet temperature" annotation (Dialog(group="Design parameters"));
     outer SI.Temperature   T_cool;
     parameter SI.Temperature T_hex = 273.15
        "Temperature out of the heat exchanger"   annotation(Dialog(group="Design parameters",  enable = SAEJ2601 == false));
     parameter Real COP "Coefficient of performance";
     SI.Temperature THEX = (if SAEJ2601 == true then T_cool else T_hex);
    outer parameter SI.Temperature T_amb;

    /******************** Variables *****************************/
    SI.Heat Q "Heat transfer";
    SI.Pressure dp "Change in pressure";
    SI.SpecificEnthalpy dh "Change in enthalpy";
    SI.Power W;
    //Exergy
    outer SI.SpecificEntropy s_0;
    outer SI.SpecificEnthalpy h_0;
    SI.Power EA;
    SI.Power EB;

    SI.Power E_D;
    SI.Power EQ;
    SI.Power EQ1;
    Real dummy;
    /******************** Equations *****************************/
    equation

      dp=0 "Pressure loss";
    inStream(portB.h_outflow)=portA.h_outflow+dh "Enthalpy definition";
    inStream(portA.h_outflow)=portB.h_outflow+dh "Enthalpy definition";

    if portB.m_flow > 0 then
        mediumB = Medium.setState_pT(portB.p, THEX);
      mediumA= Medium.setState_ph(portA.p, inStream(portA.h_outflow));
      actualStream(portA.h_outflow)*portA.m_flow + actualStream(portB.h_outflow)*portB.m_flow
      +der(Q) =0.0 "Energy balance";
      dh=Medium.specificEnthalpy(mediumA)-Medium.specificEnthalpy(mediumB)
          "Change in enthalpy";
    E_D=EA+EQ-EB;
    dummy=1;
    else
        mediumA = Medium.setState_pT(portA.p, THEX);
      mediumB= Medium.setState_ph(portB.p, inStream(portB.h_outflow));
      actualStream(portA.h_outflow)*portA.m_flow + actualStream(portB.h_outflow)*portB.m_flow
      +der(Q) =0.0 "Energy balance";
      dh=Medium.specificEnthalpy(mediumB)-Medium.specificEnthalpy(mediumA)
          "Change in enthalpy";
         // E_D=EA+EQ-EB;
     E_D=EB+EQ-EA;
    dummy=2;
    end if;
    W=-Q/COP;
      portA.m_flow+portB.m_flow=0 "Mass balance";
      dp=portB.p-portA.p "momentum balance";

    //Exergy
    der(EA)= abs(portA.m_flow)*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)= abs(portA.m_flow)*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));
    der(EQ1)=der(Q)*(1-T_cool/T_amb);
    der(EQ)= abs(der(EQ1));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -80},{100,40}}),        graphics={Bitmap(extent={{-84,24},{86,-62}},
                         fileName="modelica://HydrogenRefuelingCoolProp/Graphics/HEX.png")}),
          Diagram(coordinateSystem(extent={{-100,-80},{100,40}})));
    end HeatExchangerFixedTemperature;

    model HeatExchangerFixedTemperatureOneWay
      "Simple heat exchanger setting the outlet temperature"

      import SI = Modelica.SIunits
        "Renemaing the path to the SI units in modelica library";

    /******************** thermodynamic properties *****************************/
        replaceable package Medium =
           CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));
           Medium.ThermodynamicState mediumB;
           Medium.ThermodynamicState mediumA;
           Medium.ThermodynamicState mediumI;

    /******************** Connectors *****************************/

      Ports.FlowPort portA
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Ports.FlowPort portB
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));

    /******************** parameters *****************************/
     Boolean SAEJ2601=true "Use SAE's outlet temperature" annotation (Dialog(group="Design parameters"));
     outer SI.Temperature   T_cool;
     parameter SI.Temperature T_hex = 273.15
        "Temperature out of the heat exchanger"   annotation(Dialog(group="Design parameters",  enable = SAEJ2601 == false));
     parameter Real COP "Coefficient of performance";
     SI.Temperature THEX = (if SAEJ2601 == true then T_cool else T_hex);
    outer parameter SI.Temperature T_amb;

    /******************** Variables *****************************/
     SI.Heat Q1 "Heat transfer";
     SI.Heat Q2 "Heat transfer";
    SI.Heat Q "Heat transfer";
    SI.Pressure dp "Change in pressure";
    SI.SpecificEnthalpy dh "Change in enthalpy";
    SI.Power W;
    //Exergy
    outer SI.SpecificEntropy  s_0;
    outer SI.SpecificEnthalpy  h_0;
    SI.Power EA;
    SI.Power EB;

    SI.Power E_D;
    // SI.Power E_D2;
     SI.Power EQ2;
     SI.Power EQ1;
    SI.Power EQ;

    /******************** Equations *****************************/
    equation

      dp=0 "Pressure loss";
    inStream(portB.h_outflow)=portA.h_outflow+dh "Enthalpy definition";
    inStream(portA.h_outflow)=portB.h_outflow+dh "Enthalpy definition";

      mediumB = Medium.setState_pT(portB.p, THEX);
      mediumA= Medium.setState_ph(portA.p, inStream(portA.h_outflow));
      mediumI = Medium.setState_pT(portA.p, T_amb);

       actualStream(portA.h_outflow)*portA.m_flow + actualStream(portB.h_outflow)*portB.m_flow
       +der(Q) =0.0 "Energy balance";

      dh=Medium.specificEnthalpy(mediumA)-Medium.specificEnthalpy(mediumB)
        "Change in enthalpy";

         portA.m_flow+portB.m_flow=0 "Mass balance";
         dp=portB.p-portA.p "momentum balance";
    if mediumA.T>=T_amb and T_amb > THEX then
     der(Q1)=(-inStream(portA.h_outflow)+mediumI.h)*portA.m_flow;
     der(Q2)=(-mediumI.h+portB.h_outflow)*portA.m_flow;
    else
       der(Q2)=(-inStream(portA.h_outflow)+portB.h_outflow)*portA.m_flow;
      der(Q1)=0;
    end if;
    E_D=EA+EQ-EB;
    // E_D=EA+EQ-EB;
    W=-(Q1+Q2)/COP;
    //Exergy
    der(EA)= abs(portA.m_flow)*(mediumA.h-h_0-T_amb*(mediumA.s-s_0));
    der(EB)= abs(portA.m_flow)*(mediumB.h-h_0-T_amb*(mediumB.s-s_0));

     der(EQ1)=der(Q1)*(1-T_amb/mediumA.T);
     der(EQ2)=der(Q2)*(1-T_amb/T_cool);
     der(EQ)=der(EQ1)+der(EQ2);
    //der(EQ)=(der(Q))*(1-T_amb/T_cool);
    //der(EQ)= abs(der(EQ1));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -80},{100,40}}),        graphics={Bitmap(extent={{-84,24},{86,-62}},
                         fileName="modelica://HydrogenRefuelingCoolProp/Graphics/HEX.png")}),
          Diagram(coordinateSystem(extent={{-100,-80},{100,40}})));
    end HeatExchangerFixedTemperatureOneWay;
  end HeatExchangers;

  package Mixers
    model VolumeMixer "Mixes 2 flows into one or splits 1 flow into two"
      import SI = Modelica.SIunits;

    /****************** Call to gas properties *******************/
        replaceable package Medium =
              CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Medium"));
        Medium.ThermodynamicState medium;
         Medium.ThermodynamicState mediumA;
         Medium.ThermodynamicState mediumB;
         Medium.ThermodynamicState mediumC;
      /*********************Connectors****************************/

      Ports.FlowPort portA(
                          m_flow(final start=m_flowInitial)) "port A"
        annotation (Placement(transformation(extent={{-104,10},{-84,30}}, rotation=
                0), iconTransformation(extent={{-98,10},{-78,30}})));
      Ports.FlowPort portB(
                          m_flow(final start=m_flowInitial)) "port B"
        annotation (Placement(transformation(extent={{50,10},{70,30}},  rotation=0),
            iconTransformation(extent={{56,10},{76,30}})));
      Ports.FlowPort portC(
                          m_flow(final start=-m_flowInitial)) "port C"
        annotation (Placement(transformation(extent={{50,-50},{70,-30}},rotation=0),
            iconTransformation(extent={{56,-50},{76,-30}})));

      /*******************Geometry******************************/
      parameter SI.Volume V=1e-9 "Volume of mixer" annotation(Dialog(group="Geometry"));

      /**********************Initial conditions***************************/
    public
      parameter Boolean fixedInitialPressure = true
        "if true, initial pressure is fixed"
                                            annotation(Dialog(group="Initial Values"));

      parameter SI.Pressure pInitial=1.013e5 "Initial value for air pressure"
        annotation(Dialog(group="Initial Values"));

      parameter SI.Temperature TInitial=T_amb
        "Initial value for air temperature"
        annotation(Dialog(group="Initial Values"));

    outer parameter SI.Temperature T_amb;

    protected
      parameter SI.SpecificEnthalpy hInitial=Medium.specificEnthalpy_pT(T=TInitial, p=pInitial)
        "Initial enthalpy"                                                                                         annotation(Dialog(group="Initial Values"));

      parameter SI.MassFlowRate m_flowInitial=0
        "Start value for mass flow rate"
         annotation(Dialog(group="Initial Values"));

      /********************Variables*****************************/

    public
      SI.SpecificEnthalpy h "Specific enthalpy";
      SI.Pressure p(final start=pInitial, fixed=fixedInitialPressure);
      SI.Mass M "mass of gas in mixer";
      Real drhodt "derivative of density";
      SI.InternalEnergy U;
      SI.SpecificInternalEnergy u;
    SI.SpecificEnthalpy h1;
    SI.SpecificEnthalpy h2;
    SI.SpecificEnthalpy h3;
      //Exergy
     outer SI.SpecificEntropy s_0;
     outer SI.SpecificEnthalpy h_0;
     outer SI.SpecificInternalEnergy u_0;
     SI.Heat E_tank;
     SI.Heat E_streamA;
     SI.Heat E_streamB;
     SI.Heat E_streamC;
     SI.Heat E_D;
    /**********************Equations***************************/

    initial equation
      h=hInitial;

    equation
    medium=Medium.setState_ph(p,h);
    U=(h-p*1/medium.d)*M;
    u=(h-p*1/medium.d);
     if portA.m_flow >=0 then
       inStream(portA.h_outflow) = h1;
     else
       h1=h;
     end if;

     if portB.m_flow >=0 then
       inStream(portB.h_outflow) = h2;
     else
       h2=h;
     end if;

     if portC.m_flow >=0 then
       inStream(portC.h_outflow) = h3;
     else
       h3=h;
     end if;

       portA.h_outflow = h;
       portB.h_outflow = h;
       portC.h_outflow = h;

      portA.p = p;

    //Energy balance
        der(h) = 1/M*(portA.m_flow*noEvent(actualStream(portA.h_outflow) - h) +
          portB.m_flow*(actualStream(portB.h_outflow) - h) +
          portC.m_flow*(actualStream(portC.h_outflow) - h)
          + V*der(p)) "Energy balance";

        M = V*medium.d "Mass in control volume";

     drhodt = Medium.density_derp_h(medium)*der(p)
     + Medium.density_derh_p(medium)*der(h) "Derivative of density";

      drhodt*V   = portA.m_flow + portB.m_flow + portC.m_flow "Mass balance";

        portA.p - portB.p = 0 "Momentum balance";
        portA.p - portC.p = 0 "Momentum balance";

    //Exergy
     if portA.m_flow>= 0 then
     mediumA=Medium.setState_ph(p, inStream(portA.h_outflow));
     else
     mediumA=Medium.setState_ph(p, h);
     end if;
     if portB.m_flow >= 0 then
     mediumB=Medium.setState_ph(p, inStream(portB.h_outflow));
     else
     mediumB=Medium.setState_ph(p, h);
     end if;
     if portB.m_flow >= 0 then
     mediumC=Medium.setState_ph(p, inStream(portC.h_outflow));
     else
     mediumC=Medium.setState_ph(p, h);
     end if;

     der(E_streamA)=portA.m_flow*(mediumA.h-h_0-T_amb*(mediumA.s-s_0))
        "Exergy in stream from port A";
     der(E_streamB)=portB.m_flow*(mediumB.h-h_0-T_amb*(mediumB.s-s_0))
        "Exergy in stream from port B";
     der(E_streamC)=portC.m_flow*(mediumC.h-h_0-T_amb*(mediumC.s-s_0))
        "Exergy in stream from port C";

     der(E_tank)=(u-u_0-T_amb*(medium.s-s_0))*(portA.m_flow+portB.m_flow+portC.m_flow);
     E_tank=E_streamA+E_streamB+E_streamC+E_D;

        annotation(defaultComponentName="Mixer",
          Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-60},{80,80}},
            initialScale=0.1), graphics={Bitmap(extent={{-94,40},{74,-60}},
                fileName=
                  "modelica://HydrogenRefuelingCoolProp/Graphics/FlowConnector.png")}),
          Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-60},{80,80}},
            initialScale=0.1), graphics));
    end VolumeMixer;

    model IdealMixing
    import SI = Modelica.SIunits;

      /********************Thermodynamic properties*****************************/
    replaceable package Medium =
          CoolProp2Modelica.Interfaces.ExternalTwoPhaseMedium annotation(Dialog(group="Gas"));
        Medium.ThermodynamicState medium;
        Medium.ThermodynamicState mediumA;
        Medium.ThermodynamicState mediumB;
        Medium.ThermodynamicState mediumC;
    /********************Connectors*****************************/
      Ports.FlowPort portA
        annotation (Placement(transformation(extent={{-76,-10},{-56,10}}),
            iconTransformation(extent={{-64,10},{-44,30}})));
      Ports.FlowPort portB
        annotation (Placement(transformation(extent={{66,-10},{86,10}}),
            iconTransformation(extent={{90,10},{110,30}})));
      Ports.FlowPort portC
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}}),
            iconTransformation(extent={{90,-50},{110,-30}})));

    /********************Variables*****************************/
      SI.Pressure p;
      SI.SpecificEnthalpy h;
      SI.SpecificEnthalpy hA;
      SI.SpecificEnthalpy hB;
      SI.SpecificEnthalpy hC;

      //Exergy
    outer SI.SpecificEntropy s_0;
    outer SI.SpecificEnthalpy h_0;
    outer parameter SI.Temperature T_amb;
    SI.Heat E_tank;
    SI.Heat E_streamA;
    SI.Heat E_streamB;
    SI.Heat E_streamC;
    SI.Heat E_D;

    equation
    // property call
    medium = Medium.setState_ph(p,h);
    if portA.m_flow >=0 then
      inStream(portA.h_outflow) = hA;
    else
      hA=h;
    end if;

    if portB.m_flow >=0 then
      inStream(portB.h_outflow) = hB;
    else
      hB=h;
    end if;

    if portC.m_flow >=0 then
      inStream(portC.h_outflow) = hC;
    else
      hC=h;
    end if;

    // Mass Balance
    portA.m_flow+portB.m_flow+portC.m_flow=0;

    //Momentum equations
    portA.p=p;
    p-portB.p=0;
    p-portC.p=0;

     portA.h_outflow=h;
     portB.h_outflow=h;
     portC.h_outflow=h;

    //Energy balance
        0 = portA.m_flow*(actualStream(portA.h_outflow) - h) +
          portB.m_flow*(actualStream(portB.h_outflow) - h) +
          portC.m_flow*(actualStream(portC.h_outflow) - h);

    //Exergy
    if portA.m_flow>= 0 then
    mediumA=Medium.setState_ph(p, inStream(portA.h_outflow));
    else
    mediumA=Medium.setState_ph(p, h);
    end if;
    if portB.m_flow >= 0 then
    mediumB=Medium.setState_ph(p, inStream(portB.h_outflow));
    else
    mediumB=Medium.setState_ph(p, h);
    end if;
    if portB.m_flow >= 0 then
    mediumC=Medium.setState_ph(p, inStream(portC.h_outflow));
    else
    mediumC=Medium.setState_ph(p, h);
    end if;

    der(E_streamA)=portA.m_flow*(mediumA.h-h_0-T_amb*(mediumA.s-s_0))
        "Exergy in stream from port A";
    der(E_streamB)=portB.m_flow*(mediumB.h-h_0-T_amb*(mediumB.s-s_0))
        "Exergy in stream from port B";
    der(E_streamC)=portC.m_flow*(mediumC.h-h_0-T_amb*(mediumC.s-s_0))
        "Exergy in stream from port C";

    der(E_tank)=(h-h_0-T_amb*(medium.s-s_0))*(portA.m_flow+portB.m_flow+portC.m_flow);
    E_D=E_streamA+E_streamB+E_streamC;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                {100,40}}),        graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-60,-60},{100,40}}),
            graphics={Bitmap(extent={{-60,40},{108,-60}}, fileName="modelica://HydrogenRefuelingCoolProp/Graphics/FlowConnector.png")}));
    end IdealMixing;
  end Mixers;

  package Switches

    package WithStop
      model Switch2Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate at the closed ports";

      // Calling global variables
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // Variables used for the control
      Integer y;
      Integer z;
      Integer zz;

      // ports
        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,30},{-36,50}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,-50},{-36,-30}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

      //Equations
      equation

      //Deciding if tanks or compressor control the change of ports
      if control ==1 then
          z=z1;
      else
          z=z2;
      end if;

      // Change of ports
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
        else
           out1.m_flow=m_flow;
           out1.h_outflow=inStream(in1.h_outflow);
           in1.m_flow=m_flow;
           in1.h_outflow=inStream(out1.h_outflow);
           in2.m_flow=m_flow;
           in2.h_outflow=inStream(out1.h_outflow);
        end if;

      //Controlling when to stop simulation
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

       if zz==3 and y==1 then
         terminate("Simulation has terminated due to finished refueling");
       elseif  zz==1 and y==0 then
       terminate("Simulation has terminated due to finished refueling");
       end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName="modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch2Flows;

      model Switch3Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;
       outer Integer z5;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,30},{-36,50}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,-10},{-36,10}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-50},{-36,-30}})));

      equation
      //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);

        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
        end if;

      //Controls when to stop simulation depending on input choice
        if control2 ==1 then
      zz=z3;
      y=0;
        else
      zz=z2;
      y=1;
       end if;

      //Termination of the simulation
       if zz==3 and y==1 then
         terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
       elseif  zz==1 and y==0 then
       terminate("Simulation has terminated due to finished refueling");
       end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-80},
                  {80,80}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-80},{80,80}}),
              graphics={Bitmap(extent={{-68,62},{78,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch3Flows;

      model Switch4Flows
        import SI = Modelica.SIunits;

      /******************** Connectors *****************************/
        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,26},{-36,46}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,2},{-36,22}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-22},{-36,-2}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-46},{-36,-26}})));

      /****************** General parameters *******************/
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate 
to/from closed ports";
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      /****************** equations *******************/
      equation

      //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      //Controls when to stop simulation depending on input choice
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);

        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        end if;

      //Termination of the simulation
       if zz==6 and y==1 then
         terminate("Simulation has terminated due to finished 
   refueling and station is back ready for new refueling");
       elseif  zz==1 and y==0 then
       terminate("Simulation has terminated due to finished refueling");
       end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch4Flows;

      model Switch5Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,38},{-36,58}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,14},{-36,34}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-10},{-36,10}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-34},{-36,-14}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-58},{-36,-38}})));
      equation

        //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      //Controls when to stop simulation depending on input choice
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        end if;

      //Termination of the simulation
       if zz==6 and y==1 then
         terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
       elseif  zz==1 and y==0 then
       terminate("Simulation has terminated due to finished refueling");
       end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch5Flows;

      model Switch6Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,50},{-36,70}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,26},{-36,46}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,2},{-36,22}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-22},{-36,-2}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-46},{-36,-26}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-70},{-36,-50}})));
      equation
        //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;
      //Controls when to stop simulation depending on input choice
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;
      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
        end if;
      //Termination of the simulation
      if zz==6 and y==1 then
       terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      elseif  zz==1 and y==0 then
      terminate("Simulation has terminated due to finished refueling");
      end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch6Flows;

      model Switch7Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,44},{-36,64}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,26},{-36,46}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,8},{-36,28}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-10},{-36,10}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-28},{-36,-8}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-46},{-36,-26}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-64},{-36,-44}})));
      equation
        //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;
      //Controls when to stop simulation depending on input choice
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;
      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);

        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        end if;

      //Termination of the simulation
      if zz==7 and y==1 then
        terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      elseif  zz==1 and y==0 then
      terminate("Simulation has terminated due to finished refueling");
      end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch7Flows;

      model Switch8Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,50},{-36,70}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,32},{-36,52}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,14},{-36,34}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-4},{-36,16}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-22},{-36,-2}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-40},{-36,-20}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-58},{-36,-38}})));
        Ports.FlowPort in8
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-58,-76},{-38,-56}})));
      equation
        //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;
      //Controls when to stop simulation depending on input choice
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;
      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

            elseif z==7 then
          in8.p=out1.p;
          in8.h_outflow=inStream(out1.h_outflow);
          inStream(in8.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
        end if;
      //Termination of the simulation
      if zz==8 and y==1 then
        terminate("Signal from switch: Simulation has terminated due to finished refueling and station is back ready for new refueling");
      elseif  zz==1 and y==0 then
      terminate("Signal from switch: Simulation has terminated due to finished refueling");
      end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch8Flows;

      model Switch9Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-80,80},{-60,100}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-80,62},{-60,82}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{48,0},{68,20}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,42},{-60,62}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,22},{-60,42}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,2},{-60,22}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-18},{-60,2}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-38},{-60,-18}})));
        Ports.FlowPort in8
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-58},{-60,-38}})));
        Ports.FlowPort in9
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-78},{-60,-58}})));
      equation
        //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;
      //Controls when to stop simulation depending on input choice
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;
      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

            elseif z==7 then
          in8.p=out1.p;
          in8.h_outflow=inStream(out1.h_outflow);
          inStream(in8.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

            elseif z==8 then
          in9.p=out1.p;
          in9.h_outflow=inStream(out1.h_outflow);
          inStream(in9.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        end if;
      //Termination of the simulation
      if zz==9 and y==1 then
        terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      elseif  zz==1 and y==0 then
      terminate("Simulation has terminated due to finished refueling");
      end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
                  {60,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-80,-80},{60,100}}),
              graphics={Bitmap(extent={{-80,108},{64,-86}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch9Flows;

      model Switch10Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";

      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-80,88},{-60,108}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-80,70},{-60,90}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{48,0},{68,20}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,50},{-60,70}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,30},{-60,50}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,10},{-60,30}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-10},{-60,10}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-30},{-60,-10}})));
        Ports.FlowPort in8
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-50},{-60,-30}})));
        Ports.FlowPort in9
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-70},{-60,-50}})));
        Ports.FlowPort in10
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-90},{-60,-70}})));
      equation
        //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;
      //Controls when to stop simulation depending on input choice
      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;
      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

            elseif z==7 then
          in8.p=out1.p;
          in8.h_outflow=inStream(out1.h_outflow);
          inStream(in8.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

            elseif z==8 then
          in9.p=out1.p;
          in9.h_outflow=inStream(out1.h_outflow);
          inStream(in9.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

                elseif z==9 then
          in10.p=out1.p;
          in10.h_outflow=inStream(out1.h_outflow);
          inStream(in10.h_outflow)=out1.h_outflow;
          in10.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
        else

          out1.m_flow=m_flow;
          out1.h_outflow=inStream(in1.h_outflow);
          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        end if;
      //Termination of the simulation
      if zz==10 and y==1 then
        terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      elseif  zz==1 and y==0 then
      terminate("Simulation has terminated due to finished refueling");
      end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
                  {60,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-80,-80},{60,100}}),
              graphics={Bitmap(extent={{-80,106},{64,-88}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch10Flows;
    end WithStop;

    package WithOutStop
      model Switch2Flows
        import SI = Modelica.SIunits;

      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";

      Integer z;

      //Global control values
       outer Integer z1;
       outer Integer z2;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,30},{-36,50}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,-50},{-36,-30}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

      equation
      //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);

        else
           in2.p=out1.p;
           in2.h_outflow=inStream(out1.h_outflow);
           inStream(in2.h_outflow)=out1.h_outflow;
           in2.m_flow+out1.m_flow=0;

           in1.m_flow=m_flow;
           in1.h_outflow=inStream(out1.h_outflow);

        end if;

      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch2Flows;

      model Switch3Flows
        import SI = Modelica.SIunits;

      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0 "Mass flow rate to/from closed ports";

      Integer z;

      //Global control values
       outer Integer z1;
       outer Integer z2;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,30},{-36,50}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,-10},{-36,10}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-50},{-36,-30}})));

      equation
      //Controlling what causes the shift in port depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);

        else
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);

        end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch3Flows;

      model Switch4Flows
        import SI = Modelica.SIunits;

      /******************** Connectors *****************************/
      // ports
        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,26},{-36,46}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,2},{-36,22}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-22},{-36,-2}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-46},{-36,-26}})));

      /****************** General parameters *******************/
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0 "Mass flow rate 
to/from closed ports";

      Integer z;

      //Global control values
       outer Integer z1;
       outer Integer z2;
      /****************** equations *******************/
      equation
        //Controlling what causes the shift in port
        //depending on input choice
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      //Changing port
        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);

        else
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);

        end if;

      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch4Flows;

      model Switch5Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0;
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,38},{-36,58}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,14},{-36,34}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-10},{-36,10}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-34},{-36,-14}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-58},{-36,-38}})));
      equation
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

        else

          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);

      //     out1.m_flow=m_flow;
      //     out1.h_outflow=inStream(in1.h_outflow);
      //     in1.m_flow=m_flow;
      //     in1.h_outflow=inStream(out1.h_outflow);
      //     in2.m_flow=m_flow;
      //     in2.h_outflow=inStream(out1.h_outflow);
      //     in3.m_flow=m_flow;
      //     in3.h_outflow=inStream(out1.h_outflow);
      //     in4.m_flow=m_flow;
      //     in4.h_outflow=inStream(out1.h_outflow);
      //     in5.m_flow=m_flow;
      //     in5.h_outflow=inStream(out1.h_outflow);

        end if;

      // if zz==6 and y==1 then
      //   terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      // elseif  zz==1 and y==0 then
      // terminate("Simulation has terminated due to finished refueling");
      // end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch5Flows;

      model Switch6Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0;
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,50},{-36,70}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,26},{-36,46}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,2},{-36,22}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-22},{-36,-2}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-46},{-36,-26}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-70},{-36,-50}})));
      equation
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

        else
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);

      //     out1.m_flow=m_flow;
      //     out1.h_outflow=inStream(in1.h_outflow);
      //     in1.m_flow=m_flow;
      //     in1.h_outflow=inStream(out1.h_outflow);
      //     in2.m_flow=m_flow;
      //     in2.h_outflow=inStream(out1.h_outflow);
      //     in3.m_flow=m_flow;
      //     in3.h_outflow=inStream(out1.h_outflow);
      //     in4.m_flow=m_flow;
      //     in4.h_outflow=inStream(out1.h_outflow);
      //     in5.m_flow=m_flow;
      //     in5.h_outflow=inStream(out1.h_outflow);
      //     in6.m_flow=m_flow;
      //     in6.h_outflow=inStream(out1.h_outflow);
        end if;

      //if zz==6 and y==1 then
       // terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      //elseif  zz==1 and y==0 then
      //terminate("Simulation has terminated due to finished refueling");
      //end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-68,62},{78,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch6Flows;

      model Switch7Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0;
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,44},{-36,64}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,26},{-36,46}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,8},{-36,28}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-10},{-36,10}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-28},{-36,-8}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-46},{-36,-26}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-64},{-36,-44}})));
      equation
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);

        else

          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);

      //     out1.m_flow=m_flow;
      //     out1.h_outflow=inStream(in1.h_outflow);
      //     in1.m_flow=m_flow;
      //     in1.h_outflow=inStream(out1.h_outflow);
      //     in2.m_flow=m_flow;
      //     in2.h_outflow=inStream(out1.h_outflow);
      //     in3.m_flow=m_flow;
      //     in3.h_outflow=inStream(out1.h_outflow);
      //     in4.m_flow=m_flow;
      //     in4.h_outflow=inStream(out1.h_outflow);
      //     in5.m_flow=m_flow;
      //     in5.h_outflow=inStream(out1.h_outflow);
      //     in6.m_flow=m_flow;
      //     in6.h_outflow=inStream(out1.h_outflow);
      //     in7.m_flow=m_flow;
      //     in7.h_outflow=inStream(out1.h_outflow);

        end if;

      // if zz==7 and y==1 then
      //   terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      // elseif  zz==1 and y==0 then
      // terminate("Simulation has terminated due to finished refueling");
      // end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch7Flows;

      model Switch8Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0;
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-56,50},{-36,70}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-56,32},{-36,52}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{50,-10},{70,10}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,14},{-36,34}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-4},{-36,16}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-22},{-36,-2}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-40},{-36,-20}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-56,-58},{-36,-38}})));
        Ports.FlowPort in8
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-58,-76},{-38,-56}})));
      equation
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

            elseif z==7 then
          in8.p=out1.p;
          in8.h_outflow=inStream(out1.h_outflow);
          inStream(in8.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

        else
          in8.p=out1.p;
          in8.h_outflow=inStream(out1.h_outflow);
          inStream(in8.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);

      //     out1.m_flow=m_flow;
      //     out1.h_outflow=inStream(in1.h_outflow);
      //     in1.m_flow=m_flow;
      //     in1.h_outflow=inStream(out1.h_outflow);
      //     in2.m_flow=m_flow;
      //     in2.h_outflow=inStream(out1.h_outflow);
      //     in3.m_flow=m_flow;
      //     in3.h_outflow=inStream(out1.h_outflow);
      //     in4.m_flow=m_flow;
      //     in4.h_outflow=inStream(out1.h_outflow);
      //     in5.m_flow=m_flow;
      //     in5.h_outflow=inStream(out1.h_outflow);
      //     in6.m_flow=m_flow;
      //     in6.h_outflow=inStream(out1.h_outflow);
      //     in7.m_flow=m_flow;
      //     in7.h_outflow=inStream(out1.h_outflow);
      //     in8.m_flow=m_flow;
      //     in8.h_outflow=inStream(out1.h_outflow);
        end if;

      // if zz==7 and y==1 then
      //   terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      // elseif  zz==1 and y==0 then
      // terminate("Simulation has terminated due to finished refueling");
      // end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}),         graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-60,-60},{60,60}}),
              graphics={Bitmap(extent={{-66,62},{80,-62}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch8Flows;

      model Switch9Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0;
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-80,80},{-60,100}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-80,62},{-60,82}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{48,0},{68,20}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,42},{-60,62}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,22},{-60,42}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,2},{-60,22}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-18},{-60,2}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-38},{-60,-18}})));
        Ports.FlowPort in8
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-58},{-60,-38}})));
        Ports.FlowPort in9
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-78},{-60,-58}})));
      equation
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

            elseif z==7 then
          in8.p=out1.p;
          in8.h_outflow=inStream(out1.h_outflow);
          inStream(in8.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

            elseif z==8 then
          in9.p=out1.p;
          in9.h_outflow=inStream(out1.h_outflow);
          inStream(in9.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

        else
          in9.p=out1.p;
          in9.h_outflow=inStream(out1.h_outflow);
          inStream(in9.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);

      //     out1.m_flow=m_flow;
      //     out1.h_outflow=inStream(in1.h_outflow);
      //     in1.m_flow=m_flow;
      //     in1.h_outflow=inStream(out1.h_outflow);
      //     in2.m_flow=m_flow;
      //     in2.h_outflow=inStream(out1.h_outflow);
      //     in3.m_flow=m_flow;
      //     in3.h_outflow=inStream(out1.h_outflow);
      //     in4.m_flow=m_flow;
      //     in4.h_outflow=inStream(out1.h_outflow);
      //     in5.m_flow=m_flow;
      //     in5.h_outflow=inStream(out1.h_outflow);
      //     in6.m_flow=m_flow;
      //     in6.h_outflow=inStream(out1.h_outflow);
      //     in7.m_flow=m_flow;
      //     in7.h_outflow=inStream(out1.h_outflow);
      //     in8.m_flow=m_flow;
      //     in8.h_outflow=inStream(out1.h_outflow);
      //     in9.m_flow=m_flow;
      //     in9.h_outflow=inStream(out1.h_outflow);

        end if;

      // if zz==9 and y==1 then
      //   terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      // elseif  zz==1 and y==0 then
      // terminate("Simulation has terminated due to finished refueling");
      // end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
                  {60,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-80,-80},{60,100}}),
              graphics={Bitmap(extent={{-80,108},{64,-86}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch9Flows;

      model Switch10Flows
        import SI = Modelica.SIunits;
      parameter Integer control=1 "Switch control" annotation (choices(
       choice=1 "Vessels at HRS",
       choice=2 "Compressor"), Dialog(group="Control"));

      protected
      parameter Integer control2=1 "Stopping of simulation" annotation (choices(
       choice=1 "When HRS is full",
       choice=2 "When Compressor is finished"), Dialog(group="Control"));

      public
      parameter SI.MassFlowRate m_flow=0;
      Integer y;
      Integer z;
      Integer zz;
       outer Integer z1;
       outer Integer z2;
       outer Integer z3;
       outer Integer z4;

      // parameter Integer z1;
      // parameter Integer z2;
      // parameter Integer z3;
      // parameter Integer z4;

        Ports.FlowPort in1
          annotation (Placement(transformation(extent={{-52,34},{-32,54}}),
              iconTransformation(extent={{-80,88},{-60,108}})));
        Ports.FlowPort in2
          annotation (Placement(transformation(extent={{-50,-14},{-30,6}}),
              iconTransformation(extent={{-80,70},{-60,90}})));
        Ports.FlowPort out1
          annotation (Placement(transformation(extent={{54,-6},{74,14}}),
              iconTransformation(extent={{48,0},{68,20}})));

        Ports.FlowPort in3
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,50},{-60,70}})));

        Ports.FlowPort in4
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,30},{-60,50}})));
        Ports.FlowPort in5
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,10},{-60,30}})));
        Ports.FlowPort in6
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-10},{-60,10}})));
        Ports.FlowPort in7
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-30},{-60,-10}})));
        Ports.FlowPort in8
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-50},{-60,-30}})));
        Ports.FlowPort in9
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-70},{-60,-50}})));
        Ports.FlowPort in10
          annotation (Placement(transformation(extent={{-52,-46},{-32,-26}}),
              iconTransformation(extent={{-80,-90},{-60,-70}})));
      equation
        if control ==1 then
          z=z1;
        else
          z=z2;
        end if;

      if control2 ==1 then
      zz=z3;
      y=0;
      else
      zz=z2;
      y=1;
      end if;

        if z==0 then
          in1.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in1.h_outflow)=out1.h_outflow;
          in1.m_flow+out1.m_flow=0;

          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==1 then
          in2.p=out1.p;
          in2.h_outflow=inStream(out1.h_outflow);
          inStream(in2.h_outflow)=out1.h_outflow;
          in2.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==2 then
          in3.p=out1.p;
          in3.h_outflow=inStream(out1.h_outflow);
          inStream(in3.h_outflow)=out1.h_outflow;
          in3.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==3 then
          in4.p=out1.p;
          in1.h_outflow=inStream(out1.h_outflow);
          inStream(in4.h_outflow)=out1.h_outflow;
          in4.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==4 then
          in5.p=out1.p;
          in5.h_outflow=inStream(out1.h_outflow);
          inStream(in5.h_outflow)=out1.h_outflow;
          in5.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==5 then
          in6.p=out1.p;
          in6.h_outflow=inStream(out1.h_outflow);
          inStream(in6.h_outflow)=out1.h_outflow;
          in6.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

        elseif z==6 then
          in7.p=out1.p;
          in7.h_outflow=inStream(out1.h_outflow);
          inStream(in7.h_outflow)=out1.h_outflow;
          in7.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

            elseif z==7 then
          in8.p=out1.p;
          in8.h_outflow=inStream(out1.h_outflow);
          inStream(in8.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

            elseif z==8 then
          in9.p=out1.p;
          in9.h_outflow=inStream(out1.h_outflow);
          inStream(in9.h_outflow)=out1.h_outflow;
          in8.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in10.m_flow=m_flow;
          in10.h_outflow=inStream(out1.h_outflow);

                elseif z==9 then
          in10.p=out1.p;
          in10.h_outflow=inStream(out1.h_outflow);
          inStream(in10.h_outflow)=out1.h_outflow;
          in10.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);
        else
          in10.p=out1.p;
          in10.h_outflow=inStream(out1.h_outflow);
          inStream(in10.h_outflow)=out1.h_outflow;
          in10.m_flow+out1.m_flow=0;

          in1.m_flow=m_flow;
          in1.h_outflow=inStream(out1.h_outflow);
          in2.m_flow=m_flow;
          in2.h_outflow=inStream(out1.h_outflow);
          in3.m_flow=m_flow;
          in3.h_outflow=inStream(out1.h_outflow);
          in4.m_flow=m_flow;
          in4.h_outflow=inStream(out1.h_outflow);
          in5.m_flow=m_flow;
          in5.h_outflow=inStream(out1.h_outflow);
          in6.m_flow=m_flow;
          in6.h_outflow=inStream(out1.h_outflow);
          in7.m_flow=m_flow;
          in7.h_outflow=inStream(out1.h_outflow);
          in8.m_flow=m_flow;
          in8.h_outflow=inStream(out1.h_outflow);
          in9.m_flow=m_flow;
          in9.h_outflow=inStream(out1.h_outflow);

      //
      //     out1.m_flow=m_flow;
      //     out1.h_outflow=inStream(in1.h_outflow);
      //     in1.m_flow=m_flow;
      //     in1.h_outflow=inStream(out1.h_outflow);
      //     in2.m_flow=m_flow;
      //     in2.h_outflow=inStream(out1.h_outflow);
      //     in3.m_flow=m_flow;
      //     in3.h_outflow=inStream(out1.h_outflow);
      //     in4.m_flow=m_flow;
      //     in4.h_outflow=inStream(out1.h_outflow);
      //     in5.m_flow=m_flow;
      //     in5.h_outflow=inStream(out1.h_outflow);
      //     in6.m_flow=m_flow;
      //     in6.h_outflow=inStream(out1.h_outflow);
      //     in7.m_flow=m_flow;
      //     in7.h_outflow=inStream(out1.h_outflow);
      //     in8.m_flow=m_flow;
      //     in8.h_outflow=inStream(out1.h_outflow);
      //     in9.m_flow=m_flow;
      //     in9.h_outflow=inStream(out1.h_outflow);
      //     in10.m_flow=m_flow;
      //     in10.h_outflow=inStream(out1.h_outflow);

        end if;

      // if zz==10 and y==1 then
      //   terminate("Simulation has terminated due to finished refueling and station is back ready for new refueling");
      // elseif  zz==1 and y==0 then
      // terminate("Simulation has terminated due to finished refueling");
      // end if;
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
                  {60,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-80,-80},{60,100}}),
              graphics={Bitmap(extent={{-80,106},{64,-88}}, fileName=
                    "modelica://HydrogenRefuelingCoolProp/Graphics/FlowSwitch.png")}));
      end Switch10Flows;
    end WithOutStop;
  end Switches;

  package Functions
    function squareRootFunction
      input Real x;
      input Real delta_x;
      output Real y;

    protected
    Real a;
    Real b;

    algorithm
      a := -1/(4*delta_x^(5/2));
      b := 5/(4*sqrt(delta_x));

    if (x > delta_x) then
      y := sqrt(x);
    elseif (x < -delta_x) then
      y := -sqrt(-x);
    else
      y := (a*x*x + b)*x;
    end if;

    end squareRootFunction;

  end Functions;

  package Controls
    model ControlMultiplebanks
      import SI = Modelica.SIunits;

    /******************** Connectors *****************************/

      Ports.PressurePort pp1
        annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
            iconTransformation(extent={{-30,-108},{-10,-88}})));
      Ports.PressurePort pp2
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{10,-108},{30,-88}})));
      Ports.PressurePort pp3
        annotation (Placement(transformation(extent={{88,-10},{108,10}}),
            iconTransformation(extent={{88,-10},{108,10}})));
      Ports.PressurePort pp4
        annotation (Placement(transformation(extent={{-110,-76},{-90,-56}}),
            iconTransformation(extent={{-110,-102},{-90,-82}})));
      Ports.PressurePort pp5
        annotation (Placement(transformation(extent={{-110,-46},{-90,-26}}),
            iconTransformation(extent={{-110,-84},{-90,-64}})));
      Ports.PressurePort pp6
        annotation (Placement(transformation(extent={{-110,-18},{-90,2}}),
            iconTransformation(extent={{-110,-64},{-90,-44}})));

      Ports.PressurePort pp7
        annotation (Placement(transformation(extent={{-110,14},{-90,34}}),
            iconTransformation(extent={{-110,-44},{-90,-24}})));
      Ports.PressurePort pp8
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,-24},{-90,-4}})));
      Ports.PressurePort pp9
        annotation (Placement(transformation(extent={{-110,12},{-90,32}}),
            iconTransformation(extent={{-110,-2},{-90,18}})));
      Ports.PressurePort pp10
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,24},{-90,44}})));
      Ports.PressurePort pp11
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,44},{-90,64}})));
      Ports.PressurePort pp12
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,64},{-90,84}})));
      Ports.PressurePort pp13
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,86},{-90,106}})));

    /****************** General parameters *******************/
    outer SI.Pressure  P_end;
    parameter SI.Pressure Switch_pressure=10e5 "Pressure across 
reduction valve"     annotation(Dialog(group="Refuelling tank switch pressure"));
    //parameter SI.Pressure Switch_pressure2( start=10e5);

     parameter SI.Pressure Tank1= 45e6 "Tank1" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank2 = 65e6 "Tank2" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank3 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank4 = 95e6 "Tank4" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank5 = 95e6 "Tank5" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank6 = 95e6 "Tank6" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank7 = 95e6 "Tank7" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank8 = 95e6 "Tank8" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank9 = 95e6 "Tank9" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank10 = 95e6 "Tank10" annotation(Dialog(group="Compressor switching pressure"));

    /****************** variables *******************/
    Integer z1(start=0);
    Integer z2(start=0);
    Integer z3(start=0);
    Integer z4=0;

    /****************** equations *******************/
    algorithm
    // controlling tank shifts (up to 5 tanks)
      when pp1.p-pp2.p <= Switch_pressure and z1==0 then
      z1 :=1;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==1 then
      z1 :=2;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==2 then
      z1 :=3;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==3 then
      z1 :=4;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==4 then
      z1 :=5;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==5 then
      z1 :=6;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==6 then
      z1 :=7;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==7 then
      z1 :=8;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==8 then
      z1 :=9;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==9 then
      z1 :=10;
      end when;

    //Controlling which tank to be fuelled by the compressor
      when  z2==0 and pp4.p>=Tank1 then
         z2:=1;
      elsewhen  z2==1 and pp5.p>=Tank2 then
         z2:=2;
      elsewhen z2==2 and pp6.p>=Tank3 then
         z2:=3;
      elsewhen z2==3 and pp7.p>=Tank4 then
         z2:=4;
      elsewhen z2==4 and pp8.p>=Tank5 then
         z2:=5;
      elsewhen z2==5 and pp9.p>=Tank6 then
         z2:=6;
      elsewhen z2==6 and pp10.p>=Tank7 then
         z2:=7;
      elsewhen z2==7 and pp11.p>=Tank8 then
         z2:=8;
      elsewhen z2==8 and pp12.p>=Tank9 then
         z2:=9;
      elsewhen z2==9 and pp13.p>=Tank10 then
         z2:=10;
      end when;

    //Signal when fueling has finished
      when pp3.p<P_end then
      z3:=0;
      elsewhen pp3.p>=P_end then
      z3:=1;
      end when;

      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                          graphics={Ellipse(
              extent={{80,60},{-80,-80}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-64,10},{68,-12}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              textString="Control")}));
    end ControlMultiplebanks;

    model ControlMultiplebanksCompFueling
      import SI = Modelica.SIunits;

    //       replaceable package Medium =
    //        MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
    //
    //         Medium.BaseProperties medium1;
    //         Medium.BaseProperties medium2;
    //         Medium.BaseProperties medium3;

    outer SI.Pressure  P_end;
    parameter SI.Pressure Switch_pressure=10e5
        "Pressure across reduction valve"                                        annotation(Dialog(group="Refuelling tank switch pressure"));
    //parameter SI.Pressure Switch_pressure2( start=10e5);
    parameter SI.Pressure Switch_pressure2=0 "Pressure across reduction valve" annotation(Dialog(group="Refuelling tank switch pressure"));
    //parameter SI.Pressure Switch_pressure2( start=10e5);
     parameter SI.Pressure Tank1= 45e6 "Tank1" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank2 = 65e6 "Tank2" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank3 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank4 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank5 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank6 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank7 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank8 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank9 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank10 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
    Integer z1(start=0);
    Integer z2(start=0);
    Integer z3(start=0);
    Integer z4(start=0);

    Integer y1(start=0);

      Ports.PressurePort pp1
        annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
            iconTransformation(extent={{-30,-108},{-10,-88}})));
      Ports.PressurePort pp2
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{10,-108},{30,-88}})));
      Ports.PressurePort pp3
        annotation (Placement(transformation(extent={{88,-10},{108,10}}),
            iconTransformation(extent={{88,-10},{108,10}})));
      Ports.PressurePort pp4
        annotation (Placement(transformation(extent={{-110,-76},{-90,-56}}),
            iconTransformation(extent={{-110,-102},{-90,-82}})));
      Ports.PressurePort pp5
        annotation (Placement(transformation(extent={{-110,-46},{-90,-26}}),
            iconTransformation(extent={{-110,-84},{-90,-64}})));
      Ports.PressurePort pp6
        annotation (Placement(transformation(extent={{-110,-18},{-90,2}}),
            iconTransformation(extent={{-110,-64},{-90,-44}})));

      Ports.PressurePort pp7
        annotation (Placement(transformation(extent={{-110,14},{-90,34}}),
            iconTransformation(extent={{-110,-44},{-90,-24}})));
      Ports.PressurePort pp8
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,-24},{-90,-4}})));
      Ports.PressurePort pp9
        annotation (Placement(transformation(extent={{-110,12},{-90,32}}),
            iconTransformation(extent={{-110,-2},{-90,18}})));
      Ports.PressurePort pp10
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,24},{-90,44}})));
      Ports.PressurePort pp11
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,44},{-90,64}})));
      Ports.PressurePort pp12
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,64},{-90,84}})));
      Ports.PressurePort pp13
        annotation (Placement(transformation(extent={{-110,44},{-90,64}}),
            iconTransformation(extent={{-110,86},{-90,106}})));
    equation
    //   medium1.p=Tank1;
    //   medium1.T=T_amb;
    //   medium2.p=Tank2;
    //   medium2.T=T_amb;
    //   medium3.p=Tank3;
    //   medium3.T=T_amb;

    algorithm
     when pp1.p-pp2.p <= 140e5 and z1>=1 and y1==0 then
    z4:=1;
    y1:=1;
     elsewhen pp1.p>=80e6 and y1==1 then
      z4:=0;
      y1:=2;
     elsewhen pp1.p-pp2.p <= 40e5 and y1==2 then
       z4:=1;
       y1:=1;
     end when;

    // controlling tank shifts (up to 5 tanks)
      when pp1.p-pp2.p <= Switch_pressure and z1==0 then
      z1 :=1;
      elsewhen pp1.p-pp2.p <= Switch_pressure2 and z1==1 then
      z1 :=2;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==2 then
      z1 :=3;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==3 then
      z1 :=4;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==4 then
      z1 :=5;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==5 then
      z1 :=6;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==6 then
      z1 :=7;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==7 then
      z1 :=8;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==8 then
      z1 :=9;
      elsewhen pp1.p-pp2.p <= Switch_pressure and z1==9 then
      z1 :=10;
      end when;

    //Controlling which tank to be fuelled by the compressor
      when  z2==0 and pp4.p>=Tank1 then
         z2:=1;
      elsewhen  z2==1 and pp5.p>=Tank2 then
         z2:=2;
      elsewhen z2==2 and pp6.p>=Tank3 then
         z2:=3;
      elsewhen z2==3 and pp7.p>=Tank4 then
         z2:=4;
      elsewhen z2==4 and pp8.p>=Tank5 then
         z2:=5;
      elsewhen z2==5 and pp9.p>=Tank6 then
         z2:=6;
      elsewhen z2==6 and pp10.p>=Tank7 then
         z2:=7;
      elsewhen z2==7 and pp11.p>=Tank8 then
         z2:=8;
      elsewhen z2==8 and pp12.p>=Tank9 then
         z2:=9;
      elsewhen z2==9 and pp13.p>=Tank10 then
         z2:=10;
      end when;

    //Signal when fueling has finished
      when pp3.p<P_end then
      z3:=0;
      elsewhen pp3.p>=P_end then
      z3:=1;
      end when;

    // signal for a full cycle to have finished

    equation
      connect(pp12, pp12) annotation (Line(
          points={{-100,54},{-100,54},{-100,54}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                          graphics={Ellipse(
              extent={{80,60},{-80,-80}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-64,10},{68,-12}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              textString="Control")}));
    end ControlMultiplebanksCompFueling;

    model ControlCompressorFueling
      import SI = Modelica.SIunits;

    //       replaceable package Medium =
    //        MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
    //
    //         Medium.BaseProperties medium1;
    //         Medium.BaseProperties medium2;
    //         Medium.BaseProperties medium3;

    outer SI.Pressure  P_end;
    parameter Real ratio=4 "Pressure across reduction valve" annotation(Dialog(group="Refuelling tank switch pressure"));
    //parameter SI.Pressure Switch_pressure2( start=10e5);
    parameter Real ratio2=4 "Pressure across reduction valve" annotation(Dialog(group="Refuelling tank switch pressure"));
    //parameter SI.Pressure Switch_pressure2( start=10e5);
     parameter SI.Pressure Tank1= 45e6 "Tank1" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank2 = 65e6 "Tank2" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank3 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank4 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank5 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));

    Integer z1;
    Integer z2(start=0);
    Integer z3(start=0);
    Integer z4=0;

      Ports.PressurePort pp1
        annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
            iconTransformation(extent={{-30,-108},{-10,-88}})));
      Ports.PressurePort pp2
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{10,-108},{30,-88}})));
      Ports.PressurePort pp3
        annotation (Placement(transformation(extent={{88,-10},{108,10}}),
            iconTransformation(extent={{88,-10},{108,10}})));
      Ports.PressurePort pp4
        annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
            iconTransformation(extent={{-110,-90},{-90,-70}})));
      Ports.PressurePort pp5
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
            iconTransformation(extent={{-110,-50},{-90,-30}})));
      Ports.PressurePort pp6
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));
    // initial equation
    //   z1=0;
    //   z2=0;
    //   z3=0;
    //   z4=0;

      Ports.PressurePort pp7
        annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
            iconTransformation(extent={{-110,30},{-90,50}})));
      Ports.PressurePort pp8
        annotation (Placement(transformation(extent={{-110,72},{-90,92}}),
            iconTransformation(extent={{-108,70},{-88,90}})));

      Real r;

    initial equation

    if pp2.p/pp4.p>=ratio and pp2.p/pp5.p<ratio then
      z1=1;
    elseif pp2.p/pp4.p>=ratio and pp2.p/pp5.p>ratio then
      z1=2;
    else
      z1= 0;
    end if;

    equation

      r=pp2.p/pp1.p;
    //   medium1.p=Tank1;
    //   medium1.T=T_amb;
    //   medium2.p=Tank2;
    //   medium2.T=T_amb;
    //   medium3.p=Tank3;
    //   medium3.T=T_amb;

    algorithm
    // controlling tank shifts (up to 5 tanks)

      when r >= ratio and z1==0 then
      z1 :=1;
      elsewhen r >= ratio and z1==1 then
      z1 :=2;
      elsewhen r >= ratio and z1==2 then
      z1 :=3;
      elsewhen r >= ratio and z1==3 then
      z1 :=4;
      elsewhen r >= ratio and z1==4 then
      z1 :=5;
      end when;

    //Controlling which tank to be fuelled by the compressor
      when  z2==0 and pp4.p>=Tank1 then
         z2:=1;
      elsewhen  z2==1 and pp5.p>=Tank2 then
         z2:=2;
      elsewhen z2==2 and pp6.p>=Tank3 then
         z2:=3;
      elsewhen z2==3 and pp7.p>=Tank4 then
         z2:=4;
      elsewhen z2==4 and pp8.p>=Tank5 then
         z2:=5;
      end when;

    //Signal when fueling has finished
      when pp3.p<P_end then
      z3:=0;
      elsewhen pp3.p>=P_end then
      z3:=1;
      end when;

    // signal for a full cycle to have finished

    equation

      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                          graphics={Ellipse(
              extent={{80,60},{-80,-80}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-64,10},{68,-12}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              textString="Control")}));
    end ControlCompressorFueling;

    model ControlCompressorFueling2
      import SI = Modelica.SIunits;

    //       replaceable package Medium =
    //        MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
    //
    //         Medium.BaseProperties medium1;
    //         Medium.BaseProperties medium2;
    //         Medium.BaseProperties medium3;

    outer SI.Pressure  P_end;
    parameter SI.Pressure p_switch=10e5
        "Pressure across reduction valve when changing tank"                                 annotation(Dialog(group="Refuelling tank switch pressure"));
    //parameter SI.Pressure Switch_pressure2( start=10e5);

     parameter SI.Pressure Tank1= 45e6 "Tank1" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank2 = 65e6 "Tank2" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank3 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank4 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
     parameter SI.Pressure Tank5 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));

    Integer z1( start=0);
    Integer z2(start=0);
    Integer z3(start=0);
    Integer z4(start=0);

      Ports.PressurePort pp1
        annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
            iconTransformation(extent={{-30,-108},{-10,-88}})));
      Ports.PressurePort pp2
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{10,-108},{30,-88}})));
      Ports.PressurePort pp3
        annotation (Placement(transformation(extent={{88,-10},{108,10}}),
            iconTransformation(extent={{88,-10},{108,10}})));
      Ports.PressurePort pp4
        annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
            iconTransformation(extent={{-110,-90},{-90,-70}})));
      Ports.PressurePort pp5
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
            iconTransformation(extent={{-110,-50},{-90,-30}})));
      Ports.PressurePort pp6
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));
    // initial equation
    //   z1=0;
    //   z2=0;
    //   z3=0;
    //   z4=0;

      Ports.PressurePort pp7
        annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
            iconTransformation(extent={{-110,30},{-90,50}})));
      Ports.PressurePort pp8
        annotation (Placement(transformation(extent={{-110,72},{-90,92}}),
            iconTransformation(extent={{-108,70},{-88,90}})));

      Real r;

    // initial equation
    //
    // if pp2.p/pp4.p>=ratio and pp2.p/pp5.p<ratio then
    //   z1=1;
    // elseif pp2.p/pp4.p>=ratio and pp2.p/pp5.p>ratio then
    //   z1=2;
    // else
    //   z1= 0;
    // end if;

    equation
       r=pp2.p/pp1.p;
    //   medium1.p=Tank1;
    //   medium1.T=T_amb;
    //   medium2.p=Tank2;
    //   medium2.T=T_amb;
    //   medium3.p=Tank3;
    //   medium3.T=T_amb;

    algorithm
    // controlling tank shifts (up to 5 tanks)

      when pp1.p-pp2.p <= p_switch and z1==0 then
      z1 :=1;
      z4 :=1;
    //   elsewhen pp1.p-pp2.p <= -1e5 and z1==1 then
    //   z1 :=2;
    //   elsewhen r >= ratio and z1==2 then
    //   z1 :=3;
    //   elsewhen r >= ratio and z1==3 then
    //   z1 :=4;
    //   elsewhen r >= ratio and z1==4 then
    //   z1 :=5;
      end when;

    //Controlling which tank to be fuelled by the compressor
      when  z2==0 and pp4.p>=Tank1 then
         z2:=1;
      elsewhen  z2==1 and pp5.p>=Tank2 then
         z2:=2;
      elsewhen z2==2 and pp6.p>=Tank3 then
         z2:=3;
      elsewhen z2==3 and pp7.p>=Tank4 then
         z2:=4;
      elsewhen z2==4 and pp8.p>=Tank5 then
         z2:=5;
      end when;

    //Signal when fueling has finished
      when pp3.p<P_end then
      z3:=0;
      elsewhen pp3.p>=P_end then
      z3:=1;
      end when;

    // signal for a full cycle to have finished

    equation

      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                          graphics={Ellipse(
              extent={{80,60},{-80,-80}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-64,10},{68,-12}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              textString="Control")}));
    end ControlCompressorFueling2;

    model ControlNewSystem
      import SI = Modelica.SIunits;

    //       replaceable package Medium =
    //        MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
    //
    //         Medium.BaseProperties medium1;
    //         Medium.BaseProperties medium2;
    //         Medium.BaseProperties medium3;
    outer parameter SI.Pressure P_end;
    parameter SI.Pressure p_comp_start=140e5
        "Pressure across reduction valve when compressor starts"                                 annotation(Dialog(group="Refuelling tank switch pressure"));
    parameter SI.Pressure p_comp_stop=900e5
        " At what pressure the compressor stops";
    parameter SI.Pressure p_comp_start2=80e5
        "the pressure difference when the compressor starts again ";
    parameter SI.Pressure p_switch= 10e5
        "Pressure across the reduction valve to change to compressor";

    //  parameter SI.Pressure Tank1= 45e6 "Tank1" annotation(Dialog(group="Compressor switching pressure"));
    //  parameter SI.Pressure Tank2 = 65e6 "Tank2" annotation(Dialog(group="Compressor switching pressure"));
    //  parameter SI.Pressure Tank3 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
    //  parameter SI.Pressure Tank4 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));
    //  parameter SI.Pressure Tank5 = 95e6 "Tank3" annotation(Dialog(group="Compressor switching pressure"));

    Integer z1( start=0);
    parameter Integer z2=0;
    Integer z3( start=0);
    Integer z4( start=0);
    Integer y1( start=0);

      Ports.PressurePort pp1
        annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
            iconTransformation(extent={{-30,-108},{-10,-88}})));
      Ports.PressurePort pp2
        annotation (Placement(transformation(extent={{10,-108},{30,-88}}),
            iconTransformation(extent={{10,-108},{30,-88}})));
       Ports.PressurePort pp3
        annotation (Placement(transformation(extent={{88,-10},{108,10}}),
            iconTransformation(extent={{88,-10},{108,10}})));
    //   Ports.PressurePort pp4
    //     annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
    //         iconTransformation(extent={{-110,-90},{-90,-70}})));
    //   Ports.PressurePort pp5
    //     annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
    //         iconTransformation(extent={{-110,-50},{-90,-30}})));
    //   Ports.PressurePort pp6
    //     annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
    //         iconTransformation(extent={{-110,-10},{-90,10}})));
    // initial equation
    //   z1=0;
    //   z2=0;
    //   z3=0;
    //   z4=0;

    //   Ports.PressurePort pp7
    //     annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
    //         iconTransformation(extent={{-110,30},{-90,50}})));
    //   Ports.PressurePort pp8
    //     annotation (Placement(transformation(extent={{-110,72},{-90,92}}),
    //         iconTransformation(extent={{-108,70},{-88,90}})));

    //  Real r;

    // initial equation
    //
    // if pp2.p/pp4.p>=ratio and pp2.p/pp5.p<ratio then
    //   z1=1;
    // elseif pp2.p/pp4.p>=ratio and pp2.p/pp5.p>ratio then
    //   z1=2;
    // else
    //   z1= 0;
    // end if;

    equation
      // r=pp2.p/pp1.p;
    //   medium1.p=Tank1;
    //   medium1.T=T_amb;
    //   medium2.p=Tank2;
    //   medium2.T=T_amb;
    //   medium3.p=Tank3;
    //   medium3.T=T_amb;

    algorithm
    // controlling tank shifts (up to 5 tanks)
     when pp1.p-pp2.p <= p_comp_start and z1>=1 and y1==0 then
    z4:=1;
    y1:=1;
     elsewhen pp1.p>=pp2.p+p_comp_stop and y1==1 or pp1.p >= 100e6 and y1==1 then
      z4:=0;
      y1:=2;
     elsewhen pp1.p-pp2.p <= p_comp_start2 and y1==2 then
       z4:=1;
       y1:=1;
     end when;

      when pp1.p-pp2.p <= p_switch and z1==0 then
      z1 :=1;
    //   elsewhen pp1.p-pp2.p <= p_switch and z1==1 then
    //   z1 :=2;
    //   elsewhen r >= ratio and z1==2 then
    //        z1 :=3;
    //    elsewhen r >= ratio and z1==3 then
    //    z1 :=4;
    //    elsewhen r >= ratio and z1==4 then
    //   z1 :=5;
      end when;

    //Controlling which tank to be fuelled by the compressor
    //   when  z2==0 and pp4.p>=Tank1 then
    //      z2:=1;
    //   elsewhen  z2==1 and pp5.p>=Tank2 then
    //      z2:=2;
    //   elsewhen z2==2 and pp6.p>=Tank3 then
    //      z2:=3;
    //   elsewhen z2==3 and pp7.p>=Tank4 then
    //      z2:=4;
    //   elsewhen z2==4 and pp8.p>=Tank5 then
    //      z2:=5;
    //   end when;
    //
    //Signal when fueling has finished
       when pp3.p<P_end then
       z3:=0;
       elsewhen pp3.p>=P_end then
       z3:=1;
       end when;

    // signal for a full cycle to have finished

    equation

      annotation (preferedView="text", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                          graphics={Ellipse(
              extent={{80,60},{-80,-80}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-64,10},{68,-12}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              textString="Control")}));
    end ControlNewSystem;
  end Controls;

  package Templates
    model Template
      import SI = Modelica.SIunits;

    /*********************** Thermodynamic property call ***********************************/
     replaceable package Medium = CoolProp2Modelica.Media.Hydrogen (onePhase=true)
       constrainedby Modelica.Media.Interfaces.PartialMedium
                                                   annotation (choicesAllMatching=true);
    Medium.ThermodynamicState medium;
    /****************** General parameters *******************/
    inner parameter SI.Temperature T_amb=HRSinfo.T_amb;
    inner SI.Temperature  T_cool=HRSinfo.T_cool;
    inner SI.Pressure  P_amb;
    inner SI.Pressure P_start;
    inner Real SOC_target;
    inner SI.Pressure P_end;
    inner SI.Pressure P_ref;
    inner Real APRR;

    inner SI.SpecificEntropy s_0;
    inner SI.SpecificEnthalpy h_0;
    inner SI.SpecificInternalEnergy u_0;

    inner Integer z1;
    inner Integer z2;
    inner Integer z3;
    inner Integer z4;

      HRSInfo HRSinfo
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
    /****************** equations *******************/
    equation
      medium=Medium.setState_pT(P_amb, T_amb);

      control.z1=z1;
      control.z2=z2;
      control.z3=z3;
      control.z4=z4;

    s_0=medium.s;
    h_0=medium.h;
    u_0=h_0-P_amb*1/medium.d;

    HRSinfo.P_amb=P_amb;
    HRSinfo.P_start=P_start;
    HRSinfo.FP=P_end;
    HRSinfo.SOC=SOC_target;
    HRSinfo.APRR=APRR;
    HRSinfo.P_ref=P_ref;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics));
    end Template;

    model Template2
      import SI = Modelica.SIunits;

    /*********************** Thermodynamic property call ***********************************/
     replaceable package Medium = CoolProp2Modelica.Media.Hydrogen (onePhase=true)
       constrainedby Modelica.Media.Interfaces.PartialMedium
                                                   annotation (choicesAllMatching=true);
    Medium.ThermodynamicState medium;
    /****************** General parameters *******************/
    inner parameter SI.Temperature T_amb=HRSinfo.T_amb;
    inner SI.Temperature  T_cool=HRSinfo.T_cool;
    inner SI.Pressure  P_amb;
    inner SI.Pressure P_start;
    inner Real SOC_target;
    inner SI.Pressure P_end;
    inner SI.Pressure P_ref;
    inner Real APRR;

    inner SI.SpecificEntropy s_0;
    inner SI.SpecificEnthalpy h_0;
    inner SI.SpecificInternalEnergy u_0;

      HRSInfo HRSinfo
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
    /****************** equations *******************/
    equation
      medium=Medium.setState_pT(P_amb, T_amb);

    s_0=medium.s;
    h_0=medium.h;
    u_0=h_0-P_amb*1/medium.d;

    HRSinfo.P_amb=P_amb;
    HRSinfo.P_start=P_start;
    HRSinfo.FP=P_end;
    HRSinfo.SOC=SOC_target;
    HRSinfo.APRR=APRR;
    HRSinfo.P_ref=P_ref;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics));
    end Template2;
  end Templates;

  package Examples


    model DirectCompression
      import SI = Modelica.SIunits;

    /*********************** Thermodynamic property call ***********************************/
     replaceable package Medium = CoolProp2Modelica.Media.Hydrogen (onePhase=true)
       constrainedby Modelica.Media.Interfaces.PartialMedium
                                                   annotation (choicesAllMatching=true);
    Medium.ThermodynamicState medium;
    /****************** General parameters *******************/
    inner parameter SI.Temperature T_amb=HRSinfo.T_amb;
    inner SI.Temperature  T_cool=HRSinfo.T_cool;
    inner SI.Pressure  P_amb;
    inner SI.Pressure P_start;
    inner Real SOC_target;
    inner SI.Pressure P_end;
    inner SI.Pressure P_ref;
    inner Real APRR;

    inner SI.SpecificEntropy s_0;
    inner SI.SpecificEnthalpy h_0;
    inner SI.SpecificInternalEnergy u_0;

    inner Integer z1;
    inner Integer z2;
    inner Integer z3;
    inner Integer z4;
    inner Integer z5=0;

      HRSInfo HRSinfo
        annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
    /****************** equations *******************/
      Controls.ControlCompressorFueling2 control
        annotation (Placement(transformation(extent={{-8,74},{22,96}})));
      Compressor.CompressorDirectFuelling compressorDirectFuelling(redeclare
          package Medium = Medium, V=0.0003)
        annotation (Placement(transformation(extent={{-68,-2},{-54,6}})));
      Tanks.Tank1 Bank(
        redeclare package Medium = Medium,
        Adiabatic=false,
        V=100,
        m_flowStart=0,
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-98,-4},{-76,4}})));
      PressureLosses.PressureLoss pressureLoss(
        redeclare package Medium = Medium,
        Length=25,
        kv=0.8,
        K_length=22.5,
        inputChoice="Tube",
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-30,-4},{-14,4}})));
      HeatExchangers.HeatExchangerFixedTemperatureOneWay
                                                   heatExchangerFixedTemperature(
          redeclare package Medium = Medium,
        COP=2,
        SAEJ2601=false,
        T_hex=293.15)
        annotation (Placement(transformation(extent={{-52,-8},{-32,4}})));
      Switches.WithOutStop.Switch2Flows switch2Flows(control=1)
        annotation (Placement(transformation(extent={{6,-2},{18,10}})));
      PressureLosses.PressureLossWithControl
                                  pressureLoss1(
        redeclare package Medium = Medium,
        inputChoice="Valve",
        kv=0.2,
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-38,6},{-22,14}})));
      PressureLosses.PressureLoss pressureLoss2(
        redeclare package Medium = Medium,
        kv=0.8,
        Length=35,
        K_length=37.5,
        inputChoice="Tube",
        pInitial=20000000)
                annotation (Placement(transformation(extent={{28,0},{44,8}})));
      PressureLosses.PressureLoss pressureLoss3(
        redeclare package Medium = Medium,
        inputChoice="Valve",
        kv=0.06,
        pInitial=2000000)
                annotation (Placement(transformation(extent={{88,0},{104,8}})));
      HeatExchangers.HeatExchangerFixedTemperatureOneWay
                                                   heatExchangerFixedTemperature1(
          redeclare package Medium = Medium, COP=1.5)
        annotation (Placement(transformation(extent={{56,-4},{76,8}})));
      Tanks.Tank1 HSS(
        redeclare package Medium = Medium,
        V=0.172,
        m_flowStart=0.001,
        Adiabatic=false,
        pInitial=2000000)
        annotation (Placement(transformation(extent={{140,0},{116,8}})));
      HeatTransfer.HeatTransferTank heatTransferTank(
        xCFRP=0.035,
        dInner=0.46,
        xLiner=0.006,
        h_charging=450)
        annotation (Placement(transformation(extent={{122,-30},{142,-10}})));
      HeatTransfer.HeatTransferTank heatTransferTank1(
        tank=1,
        Charging=false,
        xCFRP=0.05,
        xLiner=0.1,
        dInner=0.462,
        LInner=581)
        annotation (Placement(transformation(extent={{-96,-30},{-76,-10}})));
      Tanks.Tank2 tank2_1(
        redeclare package Medium = Medium,
        Adiabatic=true,
        V=1e-12,
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-12,-16},{10,-8}})));
    equation
      medium=Medium.setState_pT(P_amb, T_amb);

      control.z1=z1;
      control.z2=z2;
      control.z3=z3;
      control.z4=z4;

    s_0=medium.s;
    h_0=medium.h;
    u_0=h_0-P_amb*1/medium.d;

    HRSinfo.P_amb=P_amb;
    HRSinfo.P_start=P_start;
    HRSinfo.FP=P_end;
    HRSinfo.SOC=SOC_target;
    HRSinfo.APRR=APRR;
    HRSinfo.P_ref=P_ref;

      connect(heatExchangerFixedTemperature.portA, compressorDirectFuelling.portB)
        annotation (Line(
          points={{-50,0},{-56,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss.portA, heatExchangerFixedTemperature.portB) annotation (
          Line(
          points={{-29.8,0},{-34,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(Bank.pp, control.pp4)    annotation (Line(
          points={{-88,3.8},{-86,3.8},{-86,76.2},{-8,76.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss1.portB, switch2Flows.in1) annotation (Line(
          points={{-22.6,10},{-8,10},{-8,8},{7.4,8}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss1.portA, Bank.portA)    annotation (Line(
          points={{-37.8,10},{-77.7,10},{-77.7,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss1.pp1, control.pp1) annotation (Line(
          points={{-36,13},{-36,68},{4,68},{4,74.22}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss1.pp2, control.pp2) annotation (Line(
          points={{-24,13},{-24,62},{10,62},{10,74.22}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss2.portA, switch2Flows.out1) annotation (Line(
          points={{28.2,4},{18,4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatExchangerFixedTemperature1.portA, pressureLoss2.portB)
        annotation (Line(
          points={{58,4},{43.4,4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(HSS.portA, pressureLoss3.portB)     annotation (Line(
          points={{117.855,4},{103.4,4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(HSS.pp, control.pp3)     annotation (Line(
          points={{129.091,7.8},{129.091,85},{21.7,85}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(HSS.pp, control.pp8)     annotation (Line(
          points={{129.091,7.8},{129.091,93.8},{-7.7,93.8}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(HSS.pp, control.pp7)     annotation (Line(
          points={{129.091,7.8},{129.091,89.4},{-8,89.4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(HSS.pp, control.pp6)     annotation (Line(
          points={{129.091,7.8},{129.091,85},{-8,85}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(HSS.pp, control.pp5)     annotation (Line(
          points={{129.091,7.8},{129.091,80.6},{-8,80.6}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatExchangerFixedTemperature1.portB, pressureLoss3.portA)
        annotation (Line(
          points={{74,4},{88.2,4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

    algorithm
       when HSS.medium.d>=40.2 then
       terminate("One fueling cycle has been accomplished");
       end when;

    equation
      connect(heatTransferTank.heatFlow, HSS.heatFlow) annotation (Line(
          points={{130.4,-11},{130.4,-5.5},{129.091,-5.5},{129.091,0.1}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatTransferTank1.heatFlow, Bank.heatFlow) annotation (Line(
          points={{-87.6,-11},{-87.6,-7.5},{-88,-7.5},{-88,-3.9}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(tank2_1.portB, switch2Flows.in2) annotation (Line(
          points={{8.3,-12},{10,-12},{10,0},{7.4,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(tank2_1.portA, pressureLoss.portB) annotation (Line(
          points={{-11.3,-12},{-11.3,-11},{-14.6,-11},{-14.6,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(compressorDirectFuelling.portA, Bank.portA) annotation (Line(
          points={{-65.6,0},{-77.7,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -40},{160,100}}),       graphics), Icon(coordinateSystem(extent={{-100,
                -40},{160,100}})));
    end DirectCompression;

    model CascadeSystem
      import SI = Modelica.SIunits;

    /*********************** Thermodynamic property call ***********************************/
     replaceable package Medium = CoolProp2Modelica.Media.Hydrogen (onePhase=true)
       constrainedby Modelica.Media.Interfaces.PartialMedium
                                                   annotation (choicesAllMatching=true);
    Medium.ThermodynamicState medium;
    /****************** General parameters *******************/
    inner parameter SI.Temperature T_amb=HRSinfo.T_amb;
    inner SI.Temperature  T_cool=HRSinfo.T_cool;
    inner SI.Pressure  P_amb;
    inner SI.Pressure P_start;
    inner Real SOC_target;
    inner SI.Pressure P_end;
    inner SI.Pressure P_ref;
    inner Real APRR;

    inner SI.SpecificEntropy s_0;
    inner SI.SpecificEnthalpy h_0;
    inner SI.SpecificInternalEnergy u_0;

    inner Integer z1;
    inner Integer z2;
    inner Integer z3;
    inner Integer z4;
    inner Integer z5(start=0);
      HRSInfo HRSinfo
        annotation (Placement(transformation(extent={{-138,80},{-118,100}})));
    /****************** equations *******************/
      Tanks.Tank1 Tank1(
        redeclare package Medium = Medium,
        Adiabatic=false,
        pInitial=60000000)
        annotation (Placement(transformation(extent={{-116,-8},{-94,0}})));
      Tanks.Tank1 Tank2(
        redeclare package Medium = Medium,
        Adiabatic=false,
        pInitial=80000000)
        annotation (Placement(transformation(extent={{-118,-38},{-96,-30}})));
      Tanks.Tank1 Tank3(
        redeclare package Medium = Medium,
        Adiabatic=false,
        fixedInitialPressure=true,
        pInitial=100000000)
        annotation (Placement(transformation(extent={{-116,-66},{-94,-58}})));
      Tanks.Tank1 Bank(
        redeclare package Medium = Medium,
        V=100,
        Adiabatic=false,
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-116,28},{-94,36}})));
      Tanks.Tank1 HSS(
        redeclare package Medium = Medium,
        V=0.172,
        Adiabatic=false,
        pInitial=2000000)
        annotation (Placement(transformation(extent={{152,-52},{132,-44}})));
      PressureLosses.PressureLoss pressureLoss(
        redeclare package Medium = Medium,
        inputChoice="Valve",
        kv=0.06,
        pInitial=2000000)
        annotation (Placement(transformation(extent={{108,-52},{124,-44}})));
      PressureLosses.AveragePressureRampRate averagePressureRampRate(redeclare
          package Medium = Medium, pInitial=2000000)
        annotation (Placement(transformation(extent={{84,-52},{96,-40}})));
      PressureLosses.PressureLoss pressureLoss1(
        redeclare package Medium = Medium,
        Length=25,
        K_length=22.5,
        pInitial=200000000000)
        annotation (Placement(transformation(extent={{58,-52},{74,-44}})));
      PressureLosses.PressureLoss pressureLoss2(
        redeclare package Medium = Medium,
        kv=0.5,
        inputChoice="Tube",
        Length=10,
        K_length=15,
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-10,-50},{6,-42}})));
      HeatExchangers.HeatExchangerFixedTemperatureOneWay
                                                   heatExchangerFixedTemperature(
          redeclare package Medium = Medium, COP=1.5)
        annotation (Placement(transformation(extent={{32,-56},{52,-44}})));
      PressureLosses.ReductionValve reductionValve(
        redeclare package Medium = Medium,
        pInitialIn=30000000,
        pInitialOut=2000000)
        annotation (Placement(transformation(extent={{14,-52},{26,-44}})));
      Switches.WithOutStop.Switch4Flows switch4Flows(control=1)
        annotation (Placement(transformation(extent={{-30,-54},{-18,-42}})));
      Compressor.CompressorWithStop compressorWithStop(Stop=3, redeclare
          package Medium =
                   Medium)
        annotation (Placement(transformation(extent={{-90,30},{-76,38}})));
      Switches.WithStop.Switch3Flows switch3Flows(control=2, control2=2)
        annotation (Placement(transformation(extent={{-50,0},{-36,16}})));
      PressureLosses.PressureLoss pressureLoss4(
        redeclare package Medium = Medium,
        Length=25,
        K_length=22.5,
        pInitial=52000000)
        annotation (Placement(transformation(extent={{-52,28},{-36,36}})));
      Mixers.VolumeMixer idealMixing(
        redeclare package Medium = Medium,
        fixedInitialPressure=false,
        pInitial=52000000)
        annotation (Placement(transformation(extent={{-86,-16},{-70,-6}})));
      Mixers.VolumeMixer idealMixing1(
        redeclare package Medium = Medium,
        fixedInitialPressure=false,
        pInitial=74000000)
        annotation (Placement(transformation(extent={{-86,-42},{-70,-32}})));
      Mixers.VolumeMixer idealMixing2(
        redeclare package Medium = Medium,
        fixedInitialPressure=false,
        pInitial=95000000)
        annotation (Placement(transformation(extent={{-86,-70},{-70,-60}})));
      Controls.ControlMultiplebanks control(
        Tank1=60000000,
        Tank2=80000000,
        Tank3=100000000)
        annotation (Placement(transformation(extent={{6,66},{38,96}})));
      HeatExchangers.HeatExchangerFixedTemperatureOneWay
                                                   heatExchangerFixedTemperature1(
        redeclare package Medium = Medium,
        SAEJ2601=false,
        COP=2,
        T_hex=293.15)
        annotation (Placement(transformation(extent={{-76,24},{-56,36}})));
      HeatTransfer.HeatTransferTank heatTransferTank(
        xCFRP=0.035,
        dInner=0.46,
        xLiner=0.006,
        h_charging=450)
        annotation (Placement(transformation(extent={{134,-78},{154,-58}})));
      HeatTransfer.HeatTransferTank heatTransferTank1(
        tank=1,
        Charging=false,
        xCFRP=0.05,
        xLiner=0.1,
        dInner=0.462,
        LInner=581)
        annotation (Placement(transformation(extent={{-114,6},{-94,26}})));
      HeatTransfer.HeatTransferTank heatTransferTank2(
        dInner=0.46,
        LInner=5.5,
        tank=3,
        xCFRP=0.04)
        annotation (Placement(transformation(extent={{-114,-32},{-94,-12}})));
      HeatTransfer.HeatTransferTank heatTransferTank3(
        dInner=0.046,
        LInner=5.5,
        xCFRP=0.04)
        annotation (Placement(transformation(extent={{-116,-60},{-96,-40}})));
      HeatTransfer.HeatTransferTank heatTransferTank4(
        dInner=0.46,
        LInner=5.5,
        xCFRP=0.04)
        annotation (Placement(transformation(extent={{-114,-88},{-94,-68}})));
    equation
      medium=Medium.setState_pT(P_amb, T_amb);

      control.z1=z1;
      control.z2=z2;
      control.z3=z3;
      control.z4=z4;

    s_0=medium.s;
    h_0=medium.h;
    u_0=h_0-P_amb*1/medium.d;

    HRSinfo.P_amb=P_amb;
    HRSinfo.P_start=P_start;
    HRSinfo.FP=P_end;
    HRSinfo.SOC=SOC_target;
    HRSinfo.APRR=APRR;
    HRSinfo.P_ref=P_ref;

      connect(averagePressureRampRate.portB, pressureLoss.portA) annotation (Line(
          points={{95.2,-47.2},{102.6,-47.2},{102.6,-48},{108.2,-48}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss.portB, HSS.portA) annotation (Line(
          points={{123.4,-48},{133.545,-48}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss1.portB, averagePressureRampRate.portA) annotation (Line(
          points={{73.4,-48},{80,-48},{80,-47.2},{85,-47.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatExchangerFixedTemperature.portB, pressureLoss1.portA) annotation (
         Line(
          points={{50,-48},{58.2,-48}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(reductionValve.portB, heatExchangerFixedTemperature.portA)
        annotation (Line(
          points={{26,-48},{34,-48}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(reductionValve.portA, pressureLoss2.portB) annotation (Line(
          points={{14,-48},{10,-48},{10,-46},{5.4,-46}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(switch4Flows.out1, pressureLoss2.portA) annotation (Line(
          points={{-18,-48},{-14,-48},{-14,-46},{-9.8,-46}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(Bank.portA, switch4Flows.in1) annotation (Line(
          points={{-95.7,32},{-94,32},{-94,48},{-28.6,48},{-28.6,-44.4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss4.portB, switch3Flows.out1) annotation (Line(
          points={{-36.6,32},{-32,32},{-32,8},{-38,8}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(idealMixing.portA, Tank1.portA) annotation (Line(
          points={{-84.9333,-10.2857},{-90.3167,-10.2857},{-90.3167,-4},{-95.7,
              -4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(idealMixing1.portA, Tank2.portA) annotation (Line(
          points={{-84.9333,-36.2857},{-90.3167,-36.2857},{-90.3167,-34},{-97.7,
              -34}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(idealMixing2.portA, Tank3.portA) annotation (Line(
          points={{-84.9333,-64.2857},{-90.3167,-64.2857},{-90.3167,-62},{-95.7,
              -62}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(idealMixing.portB, switch3Flows.in1) annotation (Line(
          points={{-71.2444,-10.2857},{-60,-10.2857},{-60,12},{-48.6,12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(switch3Flows.in2, idealMixing1.portB) annotation (Line(
          points={{-48.6,8},{-56,8},{-56,-36.2857},{-71.2444,-36.2857}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(idealMixing2.portB, switch3Flows.in3) annotation (Line(
          points={{-71.2444,-64.2857},{-52,-64.2857},{-52,4},{-48.6,4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(idealMixing.portC, switch4Flows.in2) annotation (Line(
          points={{-71.2444,-14.5714},{-48,-14.5714},{-48,-46.8},{-28.6,-46.8}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(idealMixing1.portC, switch4Flows.in3) annotation (Line(
          points={{-71.2444,-40.5714},{-56,-40.5714},{-56,-49.2},{-28.6,-49.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(idealMixing2.portC, switch4Flows.in4) annotation (Line(
          points={{-71.2444,-68.5714},{-46,-68.5714},{-46,-51.6},{-28.6,-51.6}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(Bank.portA, compressorWithStop.portA) annotation (Line(
          points={{-95.7,32},{-87.6,32}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp2, reductionValve.pp2) annotation (Line(
          points={{25.2,66.3},{25.2,16},{24,16},{24,-45.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp1, reductionValve.pp1) annotation (Line(
          points={{18.8,66.3},{18.8,-45.2},{16,-45.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp4, Tank1.pp) annotation (Line(
          points={{6,67.2},{-62,67.2},{-62,68},{-118,68},{-118,2},{-106,2},{
              -106,-0.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(control.pp5, Tank2.pp) annotation (Line(
          points={{6,69.9},{-62,69.9},{-62,70},{-128,70},{-128,-30.2},{-108,
              -30.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(control.pp6, Tank3.pp) annotation (Line(
          points={{6,72.9},{-64,72.9},{-64,72},{-132,72},{-132,-58.2},{-106,-58.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(HSS.pp, control.pp3) annotation (Line(
          points={{142.909,-44.2},{142.909,81},{37.68,81}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp7, HSS.pp) annotation (Line(
          points={{6,75.9},{78,75.9},{78,76},{142.909,76},{142.909,-44.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp8, HSS.pp) annotation (Line(
          points={{6,78.9},{16,78.9},{16,76},{142.909,76},{142.909,-44.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp9, HSS.pp) annotation (Line(
          points={{6,82.2},{14,82.2},{14,76},{142.909,76},{142.909,-44.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp10, HSS.pp) annotation (Line(
          points={{6,86.1},{10,86.1},{10,76},{142.909,76},{142.909,-44.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp11, HSS.pp) annotation (Line(
          points={{6,89.1},{18,89.1},{18,76},{142.909,76},{142.909,-44.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(control.pp12, HSS.pp) annotation (Line(
          points={{6,92.1},{10,92.1},{10,76},{142.909,76},{142.909,-44.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatExchangerFixedTemperature1.portB, pressureLoss4.portA)
        annotation (Line(
          points={{-58,32},{-51.8,32}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatExchangerFixedTemperature1.portA, compressorWithStop.portB)
        annotation (Line(
          points={{-74,32},{-78,32}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(averagePressureRampRate.pp1, control.pp13) annotation (Line(
          points={{90,-41.44},{90,95.4},{6,95.4}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
    algorithm
       when HSS.medium.d>=40.2 then
       z5:=1;
       end when;
    equation
      connect(heatTransferTank.heatFlow, HSS.heatFlow) annotation (Line(
          points={{142.4,-59},{142.4,-55.5},{142.909,-55.5},{142.909,-51.9}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(heatTransferTank1.heatFlow, Bank.heatFlow) annotation (Line(
          points={{-105.6,25},{-105.6,25.5},{-106,25.5},{-106,28.1}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatTransferTank2.heatFlow, Tank1.heatFlow) annotation (Line(
          points={{-105.6,-13},{-105.6,-10.5},{-106,-10.5},{-106,-7.9}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatTransferTank3.heatFlow, Tank2.heatFlow) annotation (Line(
          points={{-107.6,-41},{-107.6,-41.5},{-108,-41.5},{-108,-37.9}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatTransferTank4.heatFlow, Tank3.heatFlow) annotation (Line(
          points={{-105.6,-69},{-105.6,-68.5},{-106,-68.5},{-106,-65.9}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
                -100},{160,100}}),      graphics),
        Icon(coordinateSystem(extent={{-140,-100},{160,100}})),
        experiment(StopTime=600),
        __Dymola_experimentSetupOutput);
    end CascadeSystem;

    model NewSystem
      import SI = Modelica.SIunits;

    /*********************** Thermodynamic property call ***********************************/
     replaceable package Medium = CoolProp2Modelica.Media.Hydrogen (onePhase=true)
       constrainedby Modelica.Media.Interfaces.PartialMedium
                                                   annotation (choicesAllMatching=true);
    Medium.ThermodynamicState medium;
    /****************** General parameters *******************/
    inner parameter SI.Temperature T_amb=HRSinfo.T_amb;
    inner SI.Temperature  T_cool=HRSinfo.T_cool;
    inner SI.Pressure  P_amb;
    inner SI.Pressure P_start;
    inner Real SOC_target;
    inner SI.Pressure P_end;
    inner SI.Pressure P_ref;
    inner Real APRR;

    inner SI.SpecificEntropy s_0;
    inner SI.SpecificEnthalpy h_0;
    inner SI.SpecificInternalEnergy u_0;

    inner Integer z1;
    inner Integer z2;
    inner Integer z3;
    inner Integer z4;
    inner Integer z5=0;

      HRSInfo HRSinfo
        annotation (Placement(transformation(extent={{-120,80},{-100,100}})));

    /****************** equations *******************/
      Controls.ControlNewSystem control(
        p_comp_start=35000000,
        p_comp_stop=30000000,
        p_comp_start2=2000000)
        annotation (Placement(transformation(extent={{60,78},{80,98}})));
      Tanks.Tank1 Bank(
        redeclare package Medium = Medium,
        m_flowStart=-0.001,
        V=100,
        Adiabatic=false,
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-112,-20},{-90,-12}})));
      PressureLosses.PressureLoss pressureLoss2(
        redeclare package Medium = Medium,
        kv=0.8,
        inputChoice="Tube",
        Length=10,
        K_length=15,
        pInitial=30000000)
                annotation (Placement(transformation(extent={{60,-16},{76,-8}})));
      PressureLosses.PressureLoss pressureLoss3(
        redeclare package Medium = Medium,
        inputChoice="Valve",
        kv=0.6,
        pInitial=2000000)
                annotation (Placement(transformation(extent={{144,-16},{160,
                -8}})));
      HeatExchangers.HeatExchangerFixedTemperatureOneWay
                                                   heatExchangerFixedTemperature1(
          redeclare package Medium = Medium, COP=1.5)
        annotation (Placement(transformation(extent={{96,-20},{116,-8}})));
      Tanks.Tank1 HSS(
        redeclare package Medium = Medium,
        V=0.172,
        m_flowStart=0.001,
        Adiabatic=false,
        pInitial=2000000)
        annotation (Placement(transformation(extent={{190,-16},{166,-8}})));
      PressureLosses.AveragePressureRampRate averagePressureRampRate(
          redeclare package Medium = Medium, pInitial=2000000)
        annotation (Placement(transformation(extent={{128,-16},{140,-6}})));
      PressureLosses.ReductionValve reductionValve(
        redeclare package Medium = Medium,
        pInitialIn=30000000,
        pInitialOut=2000000)
        annotation (Placement(transformation(extent={{80,-16},{92,-8}})));
      PressureLosses.PressureLoss pressureLoss(
        redeclare package Medium = Medium,
        Length=25,
        kv=0.8,
        inputChoice="Tube",
        K_length=22.5,
        pInitial=30000000)
        annotation (Placement(transformation(extent={{-4,-34},{12,-26}})));
      HeatExchangers.HeatExchangerFixedTemperatureOneWay
                                                   heatExchangerFixedTemperature(
          redeclare package Medium = Medium,
        SAEJ2601=false,
        COP=2,
        T_hex=293.15)
        annotation (Placement(transformation(extent={{-34,-38},{-14,-26}})));
      Switches.WithOutStop.Switch2Flows switch2Flows(control=1)
        annotation (Placement(transformation(extent={{42,-18},{54,-6}})));
      Compressor.CompressorDirectFuelling compressorDirectFuelling(
        redeclare package Medium = Medium,
        V=0.0003,
        Strokes=440)
        annotation (Placement(transformation(extent={{-56,-32},{-42,-24}})));
      Tanks.Tank2 tankTwoWay(
        redeclare package Medium = Medium,
        V=0.025,
        pInitial=87000000)
        annotation (Placement(transformation(extent={{20,-34},{36,-26}})));
      PressureLosses.PressureLoss pressureLoss1(
        redeclare package Medium = Medium,
        kv=0.8,
        inputChoice="Tube",
        Length=25,
        K_length=22.5,
        pInitial=2000000)
                annotation (Placement(transformation(extent={{110,-30},{126,
                -22}})));
      HeatTransfer.HeatTransferTank heatTransferTank(
        xCFRP=0.035,
        dInner=0.46,
        xLiner=0.006,
        h_charging=450)
        annotation (Placement(transformation(extent={{172,-44},{192,-24}})));
      HeatTransfer.HeatTransferTank heatTransferTank1(
        tank=1,
        Charging=false,
        xCFRP=0.05,
        xLiner=0.1,
        dInner=0.462,
        LInner=581)
        annotation (Placement(transformation(extent={{-110,-46},{-90,-26}})));
    equation
      medium=Medium.setState_pT(P_amb, T_amb);

      control.z1=z1;
      control.z2=z2;
      control.z3=z3;
      control.z4=z4;

    s_0=medium.s;
    h_0=medium.h;
    u_0=h_0-P_amb*1/medium.d;

    HRSinfo.P_amb=P_amb;
    HRSinfo.P_start=P_start;
    HRSinfo.FP=P_end;
    HRSinfo.SOC=SOC_target;
    HRSinfo.APRR=APRR;
    HRSinfo.P_ref=P_ref;

    algorithm
       when HSS.medium.d>=40.2 then
       terminate("One fueling cycle has been accomplished");
       end when;

    equation
      connect(HSS.portA,pressureLoss3. portB)     annotation (Line(
          points={{167.855,-12},{159.4,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(HSS.pp, control.pp3) annotation (Line(
          points={{179.091,-8.2},{179.091,88},{79.8,88}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(averagePressureRampRate.portB, pressureLoss3.portA) annotation (
         Line(
          points={{139.2,-12},{144.2,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(reductionValve.portB, heatExchangerFixedTemperature1.portA)
        annotation (Line(
          points={{92,-12},{98,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(reductionValve.portA, pressureLoss2.portB) annotation (Line(
          points={{80,-12},{75.4,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(reductionValve.pp2, control.pp2) annotation (Line(
          points={{90,-9.2},{92,-9.2},{92,78.2},{72,78.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss.portA,heatExchangerFixedTemperature. portB) annotation (
          Line(
          points={{-3.8,-30},{-16,-30}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(switch2Flows.out1, pressureLoss2.portA) annotation (Line(
          points={{54,-12},{60.2,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(switch2Flows.in1, Bank.portA) annotation (Line(
          points={{43.4,-8},{-88,-8},{-88,-16},{-91.7,-16}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(compressorDirectFuelling.portB, heatExchangerFixedTemperature.portA)
        annotation (Line(
          points={{-44,-30},{-32,-30}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(tankTwoWay.portB, switch2Flows.in2) annotation (Line(
          points={{34.7636,-30},{42,-30},{42,-16},{43.4,-16}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(tankTwoWay.portA, pressureLoss.portB) annotation (Line(
          points={{20.5091,-30},{11.4,-30}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(reductionValve.pp1, control.pp1) annotation (Line(
          points={{82,-9.2},{82,32},{68,32},{68,78.2}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss1.portB, averagePressureRampRate.portA) annotation (
         Line(
          points={{125.4,-26},{129,-26},{129,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(pressureLoss1.portA, heatExchangerFixedTemperature1.portB)
        annotation (Line(
          points={{110.2,-26},{112,-26},{112,-12},{114,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(compressorDirectFuelling.portA, Bank.portA) annotation (Line(
          points={{-53.6,-30},{-72,-30},{-72,-16},{-91.7,-16}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(heatTransferTank.heatFlow, HSS.heatFlow) annotation (Line(
          points={{180.4,-25},{180.4,-20.5},{179.091,-20.5},{179.091,-15.9}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(heatTransferTank1.heatFlow, Bank.heatFlow) annotation (Line(
          points={{-101.6,-27},{-101.6,-23.5},{-102,-23.5},{-102,-19.9}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
                -100},{200,100}}),      graphics), Icon(coordinateSystem(extent={{-120,
                -100},{200,100}})));
    end NewSystem;
  end Examples;

  annotation (uses(Modelica(version="3.2"), CoolProp2Modelica(version="3.3.0")));
end HydrogenRefuelingCoolProp;
