﻿within TransiEnt.Producer.Combined.LargeScaleCHP.Base.Characteristics;
record PQ_Characteristics_STGeneric "Scaleable steam turbine plant based on WT, Source: Ebsilon Professional Model"



//________________________________________________________________________________//
// Component of the TransiEnt Library, version: 2.0.2                             //
//                                                                                //
// Licensed by Hamburg University of Technology under the 3-BSD-clause.           //
// Copyright 2021, Hamburg University of Technology.                              //
//________________________________________________________________________________//
//                                                                                //
// TransiEnt.EE, ResiliEntEE, IntegraNet and IntegraNet II are research projects  //
// supported by the German Federal Ministry of Economics and Energy               //
// (FKZ 03ET4003, 03ET4048, 0324027 and 03EI1008).                                //
// The TransiEnt Library research team consists of the following project partners://
// Institute of Engineering Thermodynamics (Hamburg University of Technology),    //
// Institute of Energy Systems (Hamburg University of Technology),                //
// Institute of Electrical Power and Energy Technology                            //
// (Hamburg University of Technology)                                             //
// Fraunhofer Institute for Environmental, Safety, and Energy Technology UMSICHT, //
// Gas- und Wärme-Institut Essen						  //
// and                                                                            //
// XRG Simulation GmbH (Hamburg, Germany).                                        //
//________________________________________________________________________________//






  extends Generic_PQ_Characteristics(
  PQboundaries=[
         0,    0.9876,    0.3921;
    0.0550,    1.0000,    0.3846;
    0.4276,    0.9424,    0.3341;
    0.9838,    0.8748,    0.8462;
    1.0000,    0.8748,    0.8462],
  PQ_HeatInput_Matrix=[
  0,0,0.124824684431978,0.25,0.374824684431978,0.5,0.625175315568022,0.75,0.874824684431978,1;
  0,0.8/eta_total_best*[0.000486144871171609,0.242100145843461,0.491006319883325,0.739912493923189,0.988818667963053,1.23772484200292,1.48614487117161,1.73845405930967,1.99124939231891];
  0.124939231891104,0.8/eta_total_best*[0.300437530384054,0.368983957219251,0.491006319883325,0.739912493923189,0.988818667963053,1.23772484200292,1.48614487117161,1.73845405930967,1.99124939231891];
  0.249878463782207,0.8/eta_total_best*[0.612542537676227,0.67379679144385,0.740398638794361,0.811375789985416,0.988818667963053,1.23772484200292,1.48614487117161,1.73845405930967,1.99124939231891];
  0.374817695673311,0.8/eta_total_best*[0.93048128342246,0.983471074380165,1.04229460379193,1.10646572678658,1.17598444336412,1.24842002916869,1.48614487117161,1.73845405930967,1.99124939231891];
  0.500243072435586,0.8/eta_total_best*[1.26008750607681,1.30384054448226,1.3543996110841,1.41079241614001,1.4725328147788,1.53962080700049,1.60865337870685,1.73845405930967,1.99124939231891];
  0.625182304326689,0.8/eta_total_best*[1.60525036460865,1.63684978123481,1.67574137092854,1.72192513368984,1.7739426349052,1.83179387457462,1.89499270782693,1.96305298979096,2.03159941662615];
  0.750121536217793,0.8/eta_total_best*[1.94263490520175,1.96256684491979,1.99124939231891,2.02771025765678,2.0719494409334,2.12007778317939,2.17355371900826,2.23189110354886,2.29606222654351];
  0.875060768108896,0.8/eta_total_best*[2.26981040350024,2.27661643169665,2.29363150218765,2.31939718035975,2.35294117647059,2.393777345649,2.44093339815265,2.49440933398153,2.55274671852212];
  1,0.8/eta_total_best*[2.62858531842489,2.62129314535732,2.62615459406903,2.64122508507535,2.66699076324745,2.7019931939718,2.74477394263491,2.79484686436558,2.85075352455032]],
  eta_total_best=0.8);

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>record for generic PQ characteristics of a scaleable steam turbine plant based on WT</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">4.Interfaces</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>All records (PQ diagrams and Heat input matrixes) included in this package are included with the intention of illustrating the modelling concept.</p>
<p>However, users are encouraged to create their own records based on the plants and scenarios that they want to simulate.</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>These characteristics are based on an Ebsilon model.</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
</html>"));
end PQ_Characteristics_STGeneric;
