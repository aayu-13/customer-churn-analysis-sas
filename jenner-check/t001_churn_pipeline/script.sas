/* Customer Churn Analysis pipeline (from code/Customer Churn Analysis SAS.sas)
   Adapted to run self-contained: a leading DATA _null_ step materializes a
   sample of the repository's own data/churn.csv to a work file, so the
   PROC IMPORT below reads it exactly as written in the repository. Apart from
   pointing PROC IMPORT at that local copy, every PROC / SQL / DATA step is
   unchanged from the original. The sample is a deterministic 150-row subset of
   data/churn.csv (all three contract types, ~28% churn). */

filename churncsv "churn.csv";
data _null_;
  file churncsv;
  put 'customerID,gender,SeniorCitizen,Partner,Dependents,tenure,PhoneService,MultipleLines,InternetService,OnlineSecurity,OnlineBackup,DeviceProtection,TechSupport,StreamingTV,StreamingMovies,Contract,PaperlessBilling,PaymentMethod,MonthlyCharges,TotalCharges,Churn';
  put '7590-VHVEG,Female,0,Yes,No,1,No,No phone service,DSL,No,Yes,No,No,No,No,Month-to-month,Yes,Electronic check,29.85,29.85,No';
  put '7760-OYPDY,Female,0,No,No,2,Yes,No,Fiber optic,No,No,No,No,Yes,No,Month-to-month,Yes,Electronic check,80.65,144.15,Yes';
  put '9848-JQJTX,Male,0,No,No,72,Yes,Yes,Fiber optic,No,Yes,Yes,No,Yes,Yes,Two year,Yes,Bank transfer (automatic),100.9,7459.05,No';
  put '4080-OGPJL,Female,0,No,No,8,Yes,Yes,DSL,Yes,No,No,Yes,No,Yes,Month-to-month,No,Electronic check,71.15,563.65,Yes';
  put '0956-SYCWG,Female,0,No,No,13,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Electronic check,19.65,244.8,No';
  put '1251-KRREG,Male,0,No,No,2,Yes,Yes,DSL,No,Yes,No,No,No,No,Month-to-month,Yes,Mailed check,54.4,114.1,Yes';
  put '2080-SRCDE,Female,0,No,Yes,1,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Mailed check,25.4,25.4,No';
  put '2739-CACDQ,Female,1,No,No,17,Yes,Yes,Fiber optic,No,No,Yes,No,No,No,Month-to-month,Yes,Credit card (automatic),82.65,1470.05,No';
  put '6158-HDPXZ,Male,0,No,No,1,No,No phone service,DSL,No,No,No,No,No,No,Month-to-month,No,Mailed check,25.35,25.35,No';
  put '3935-TBRZZ,Male,0,Yes,Yes,44,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Mailed check,25.7,1110.5,No';
  put '4933-IKULF,Female,1,No,No,17,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Mailed check,20.65,330.6,No';
  put '6705-LXORM,Female,1,Yes,No,5,Yes,No,Fiber optic,No,No,No,No,No,No,Month-to-month,No,Electronic check,70.05,302.6,No';
  put '7319-VENRZ,Male,0,No,No,7,Yes,No,DSL,No,No,Yes,Yes,Yes,No,Month-to-month,No,Bank transfer (automatic),64.3,445.95,No';
  put '4765-OXPPD,Female,0,Yes,Yes,9,Yes,No,DSL,Yes,Yes,Yes,Yes,No,No,Month-to-month,No,Mailed check,65,663.05,Yes';
  put '4464-JCOLN,Male,0,Yes,Yes,2,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Mailed check,19.85,35.9,Yes';
  put '7133-VBDCG,Female,0,No,No,25,Yes,No,Fiber optic,Yes,Yes,No,No,No,No,Month-to-month,Yes,Bank transfer (automatic),79.85,2015.35,Yes';
  put '1410-RSCMR,Male,0,Yes,Yes,7,Yes,No,DSL,Yes,No,Yes,Yes,No,Yes,Month-to-month,Yes,Credit card (automatic),71.35,515.75,No';
  put '3009-JWMPU,Male,0,No,No,62,Yes,Yes,Fiber optic,No,No,Yes,No,Yes,Yes,One year,Yes,Electronic check,96.75,6125.4,Yes';
  put '6916-HIJSE,Female,0,No,No,65,Yes,No,DSL,Yes,Yes,Yes,Yes,Yes,Yes,Two year,Yes,Bank transfer (automatic),84.85,5459.2,No';
  put '9227-LUNBG,Female,0,No,No,1,No,No phone service,DSL,No,No,No,No,No,No,Month-to-month,No,Electronic check,24.6,24.6,Yes';
  put '0835-DUUIQ,Female,0,No,Yes,24,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Bank transfer (automatic),21.05,531.55,No';
  put '3717-OFRTN,Male,0,No,No,1,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Bank transfer (automatic),19.75,19.75,No';
  put '8146-QQKZH,Female,0,Yes,No,71,Yes,No,DSL,Yes,No,Yes,Yes,Yes,Yes,Two year,No,Bank transfer (automatic),81.85,5924.4,No';
  put '1751-NCDLI,Male,1,Yes,No,46,Yes,Yes,Fiber optic,No,No,Yes,No,Yes,Yes,Month-to-month,Yes,Electronic check,98.85,4564.9,No';
  put '0098-BOWSO,Male,0,No,No,27,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,Yes,Electronic check,19.4,529.8,No';
  put '1346-UFHAX,Female,0,No,No,13,Yes,Yes,Fiber optic,Yes,No,No,No,No,No,Month-to-month,Yes,Credit card (automatic),80,1029.35,No';
  put '9091-WTUUY,Male,0,Yes,Yes,64,Yes,No,DSL,Yes,No,Yes,Yes,Yes,No,Two year,No,Mailed check,69.25,4447.75,No';
  put '8480-PPONV,Male,0,Yes,Yes,62,Yes,Yes,Fiber optic,Yes,Yes,Yes,Yes,Yes,Yes,Two year,No,Bank transfer (automatic),115.55,7159.05,No';
  put '9788-YTFGE,Male,0,No,No,7,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,Yes,Mailed check,19.95,147.5,No';
  put '3084-DOWLE,Female,0,Yes,No,72,Yes,Yes,DSL,Yes,Yes,Yes,Yes,Yes,Yes,Two year,No,Bank transfer (automatic),92,6474.4,No';
  put '7024-OHCCK,Female,1,No,No,2,Yes,Yes,Fiber optic,No,No,No,No,Yes,Yes,Month-to-month,Yes,Electronic check,93.85,170.85,Yes';
  put '6362-QHAFM,Male,0,Yes,No,42,Yes,Yes,Fiber optic,No,No,Yes,Yes,Yes,Yes,One year,Yes,Electronic check,108.3,4586.15,No';
  put '1769-GRUIK,Female,0,No,No,18,Yes,No,Fiber optic,No,No,No,No,No,No,Month-to-month,Yes,Electronic check,71.1,1247.75,No';
  put '6518-KZXCB,Male,0,No,No,22,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Two year,No,Mailed check,25.25,566.5,No';
  put '7552-KEYGT,Male,0,Yes,No,27,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Two year,No,Bank transfer (automatic),19.55,520.55,No';
  put '9490-DFPMD,Female,1,No,No,42,Yes,Yes,Fiber optic,No,No,No,No,Yes,No,Month-to-month,Yes,Electronic check,84.65,3541.35,Yes';
  put '1696-MZVAU,Male,0,Yes,Yes,39,No,No phone service,DSL,No,No,No,No,No,No,One year,Yes,Credit card (automatic),25.25,947.75,No';
  put '9804-ICWBG,Male,0,No,No,1,Yes,No,Fiber optic,No,No,No,No,No,No,Month-to-month,Yes,Electronic check,69.9,69.9,Yes';
  put '7530-HDYDS,Female,0,No,No,38,Yes,No,Fiber optic,No,Yes,Yes,Yes,No,No,Month-to-month,Yes,Credit card (automatic),84.25,3264.5,Yes';
  put '8286-AFUYI,Male,0,No,No,1,Yes,No,DSL,Yes,No,No,No,No,No,Month-to-month,No,Electronic check,47.95,47.95,No';
  put '6474-FVJLC,Male,0,No,No,2,Yes,Yes,Fiber optic,No,No,No,No,No,Yes,Month-to-month,Yes,Electronic check,86,165.45,Yes';
  put '4566-GOLUK,Male,0,Yes,Yes,47,Yes,Yes,Fiber optic,No,No,Yes,Yes,Yes,Yes,Month-to-month,Yes,Bank transfer (automatic),107.35,5118.95,Yes';
  put '1024-VRZHF,Male,0,Yes,No,11,Yes,Yes,Fiber optic,No,No,No,No,No,No,Month-to-month,Yes,Electronic check,74.95,825.7,Yes';
  put '0181-RITDD,Male,0,Yes,Yes,62,Yes,No,Fiber optic,Yes,Yes,Yes,Yes,Yes,Yes,Two year,No,Mailed check,108.15,6825.65,No';
  put '9079-LWTFD,Male,0,No,No,47,Yes,Yes,Fiber optic,Yes,Yes,No,Yes,Yes,No,Month-to-month,No,Mailed check,100.75,4669.2,No';
  put '8984-HPEMB,Female,0,No,No,71,Yes,Yes,Fiber optic,Yes,Yes,Yes,Yes,Yes,Yes,Two year,Yes,Electronic check,118.65,8477.6,No';
  put '6635-CPNUN,Male,0,Yes,No,28,Yes,Yes,Fiber optic,No,Yes,Yes,No,Yes,No,Month-to-month,No,Credit card (automatic),96.6,2684.35,No';
  put '4365-MSDYN,Male,0,Yes,No,8,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,Yes,Bank transfer (automatic),19.55,161.15,No';
  put '4957-TIALW,Female,0,No,Yes,15,Yes,No,DSL,Yes,Yes,Yes,Yes,No,No,One year,No,Credit card (automatic),65.6,1010,No';
  put '7377-DMMRI,Male,0,No,No,2,Yes,No,DSL,Yes,No,No,No,No,No,Month-to-month,Yes,Electronic check,47.8,92.45,Yes';
  put '8739-XNIKG,Female,0,No,No,5,Yes,Yes,Fiber optic,No,No,No,No,Yes,No,Month-to-month,Yes,Electronic check,84,424.75,No';
  put '3722-WPXTK,Male,0,No,No,1,Yes,No,Fiber optic,No,No,No,No,Yes,Yes,Month-to-month,Yes,Electronic check,88.35,88.35,Yes';
  put '1254-IZEYF,Female,1,No,No,31,Yes,Yes,Fiber optic,No,Yes,No,No,Yes,Yes,Month-to-month,Yes,Electronic check,99.95,3186.65,Yes';
  put '1552-TKMXS,Female,0,Yes,No,42,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Credit card (automatic),20.35,869.9,No';
  put '7758-UJWYS,Male,0,Yes,Yes,34,No,No phone service,DSL,No,No,No,Yes,Yes,No,Two year,Yes,Electronic check,40.55,1325.85,No';
  put '9624-EGDEQ,Female,0,No,No,37,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Two year,No,Mailed check,19.8,813.3,No';
  put '9018-PCIOK,Female,0,No,No,55,Yes,No,DSL,No,Yes,Yes,No,No,Yes,Two year,Yes,Mailed check,64.75,3617.1,No';
  put '7341-LXCAF,Male,0,Yes,No,4,Yes,Yes,Fiber optic,No,No,No,No,No,No,Month-to-month,Yes,Electronic check,74.65,301.4,Yes';
  put '9392-XBGTD,Male,0,No,Yes,27,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Two year,No,Mailed check,20.6,581.85,No';
  put '2770-NSVDG,Male,0,Yes,No,24,No,No phone service,DSL,No,No,Yes,No,No,No,Month-to-month,No,Electronic check,29.1,688,No';
  put '3251-YMVWZ,Male,0,No,No,53,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Bank transfer (automatic),24.05,1301.9,No';
  put '7244-KXYZN,Female,0,No,No,24,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Credit card (automatic),20.45,527.35,No';
  put '0484-FFVBJ,Male,0,No,No,32,Yes,No,DSL,No,No,No,No,Yes,Yes,One year,Yes,Bank transfer (automatic),64.85,2010.95,No';
  put '6898-MDLZW,Male,0,No,No,12,Yes,No,DSL,No,Yes,No,Yes,No,No,Month-to-month,Yes,Mailed check,53.75,648.65,No';
  put '8084-OIVBS,Female,0,No,No,11,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Mailed check,20,211.95,No';
  put '0617-FHSGK,Male,0,No,Yes,49,Yes,Yes,Fiber optic,No,No,No,No,No,No,Month-to-month,No,Credit card (automatic),75.2,3678.3,Yes';
  put '0516-WJVXC,Female,0,No,No,5,Yes,No,DSL,Yes,No,No,Yes,No,No,Month-to-month,No,Electronic check,54.2,308.25,Yes';
  put '3629-WEAAM,Female,0,No,No,8,Yes,No,DSL,No,No,Yes,Yes,No,Yes,Month-to-month,No,Mailed check,64.1,504.05,No';
  put '4393-OBCRR,Female,0,No,No,3,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Mailed check,20.25,71.2,No';
  put '3665-JATSN,Female,0,No,No,19,No,No phone service,DSL,No,Yes,No,No,No,Yes,Month-to-month,Yes,Electronic check,39.7,710.05,No';
  put '7075-BNDVQ,Female,0,No,No,4,No,No phone service,DSL,Yes,No,Yes,No,No,No,Month-to-month,No,Mailed check,35,135.75,No';
  put '0840-DFEZH,Female,0,No,No,7,Yes,Yes,Fiber optic,No,No,No,No,No,No,Month-to-month,Yes,Electronic check,75.35,564.65,No';
  put '4585-HETAI,Female,0,Yes,Yes,4,Yes,No,Fiber optic,No,No,Yes,No,No,No,Month-to-month,Yes,Electronic check,73.75,325.45,Yes';
  put '2430-USGXP,Male,0,Yes,No,24,Yes,Yes,Fiber optic,No,No,Yes,No,Yes,Yes,Month-to-month,Yes,Electronic check,101.05,2391.8,Yes';
  put '7673-LPRNY,Female,0,No,No,23,Yes,Yes,DSL,Yes,No,Yes,No,Yes,Yes,One year,Yes,Electronic check,78.55,1843.05,No';
  put '5889-JTMUL,Female,1,Yes,No,50,Yes,Yes,Fiber optic,No,Yes,Yes,No,Yes,No,Month-to-month,Yes,Electronic check,95.05,4888.7,Yes';
  put '1730-ZMAME,Female,1,No,No,32,Yes,No,Fiber optic,No,No,No,No,No,Yes,Month-to-month,Yes,Electronic check,79.5,2665,No';
  put '6479-VDGRK,Female,0,Yes,Yes,72,Yes,No,DSL,Yes,Yes,Yes,Yes,Yes,Yes,Two year,No,Bank transfer (automatic),85.3,6129.2,No';
  put '3194-ORPIK,Female,0,Yes,Yes,50,Yes,Yes,Fiber optic,No,No,No,No,Yes,No,Month-to-month,Yes,Bank transfer (automatic),84.4,4116.15,Yes';
  put '6961-VCPMC,Male,1,Yes,No,46,Yes,No,Fiber optic,No,No,No,No,No,Yes,Month-to-month,Yes,Electronic check,80.4,3605.2,Yes';
  put '8617-ENBDS,Male,0,No,No,3,Yes,No,Fiber optic,No,No,Yes,No,No,No,Month-to-month,Yes,Credit card (automatic),73.6,232.5,No';
  put '8625-AZYZY,Male,0,Yes,No,24,Yes,Yes,Fiber optic,No,Yes,Yes,No,Yes,Yes,Month-to-month,Yes,Electronic check,104.65,2542.45,Yes';
  put '0237-YFUTL,Female,0,Yes,No,50,Yes,Yes,Fiber optic,Yes,Yes,No,Yes,Yes,Yes,Month-to-month,Yes,Bank transfer (automatic),109.65,5405.8,No';
  put '2773-OVBPK,Male,0,Yes,No,67,Yes,Yes,Fiber optic,No,Yes,Yes,Yes,Yes,Yes,Two year,Yes,Bank transfer (automatic),111.3,7567.2,No';
  put '4355-CVPVS,Female,0,Yes,Yes,56,Yes,No,Fiber optic,No,No,No,No,Yes,Yes,One year,No,Bank transfer (automatic),88.9,4968,No';
  put '0618-XWMSS,Male,0,No,Yes,28,Yes,No,Fiber optic,Yes,No,No,No,No,No,Month-to-month,Yes,Bank transfer (automatic),74.9,2068.55,Yes';
  put '5404-GGUKR,Male,0,No,No,5,Yes,No,DSL,No,Yes,No,No,No,No,Month-to-month,Yes,Electronic check,51.35,262.3,No';
  put '4282-YMKNA,Female,0,No,No,9,Yes,Yes,Fiber optic,No,No,No,No,No,No,Month-to-month,Yes,Electronic check,74.75,706.6,Yes';
  put '3079-BCHLN,Male,0,Yes,No,47,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Bank transfer (automatic),19.9,942.95,No';
  put '6917-IAYHD,Male,0,No,Yes,1,No,No phone service,DSL,No,Yes,No,Yes,No,No,Month-to-month,No,Mailed check,33.6,33.6,No';
  put '5108-ADXWO,Male,0,No,No,11,Yes,No,Fiber optic,Yes,No,No,No,No,No,Month-to-month,Yes,Electronic check,73.5,791.75,Yes';
  put '5955-EPOAZ,Female,0,No,No,6,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,Yes,Mailed check,20.95,109.5,No';
  put '6873-UDNLD,Male,0,No,No,40,Yes,No,DSL,Yes,No,Yes,No,No,Yes,Month-to-month,No,Electronic check,67.45,2731,No';
  put '3372-CDXFJ,Male,0,Yes,Yes,13,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Bank transfer (automatic),24.5,343.6,No';
  put '0378-XSZPU,Male,0,Yes,No,58,Yes,No,DSL,Yes,Yes,Yes,No,No,No,One year,No,Credit card (automatic),60.3,3563.8,Yes';
  put '3606-SBKRY,Male,0,No,No,31,No,No phone service,DSL,No,No,Yes,No,Yes,Yes,One year,Yes,Electronic check,50.05,1523.4,No';
  put '0707-HOVVN,Female,1,No,No,70,Yes,Yes,DSL,No,Yes,Yes,Yes,Yes,No,Two year,Yes,Bank transfer (automatic),75.5,5212.65,No';
  put '7787-BNTZM,Male,0,No,No,6,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Bank transfer (automatic),20.15,130.5,No';
  put '1734-ZMNTZ,Female,0,Yes,Yes,11,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Two year,No,Mailed check,25,300.7,No';
  put '2091-MJTFX,Female,0,Yes,Yes,30,No,No phone service,DSL,No,No,No,Yes,Yes,Yes,Month-to-month,No,Credit card (automatic),51.2,1561.5,Yes';
  put '5365-LLFYV,Female,0,No,No,2,Yes,No,DSL,No,No,No,No,No,No,Month-to-month,Yes,Mailed check,45.85,105.6,No';
  put '8884-FEEWR,Male,0,No,No,35,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Bank transfer (automatic),20.6,754,No';
  put '0366-NQSHS,Male,0,No,No,2,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Mailed check,19.35,46.35,No';
  put '9058-MJLZC,Female,0,No,No,24,Yes,No,Fiber optic,Yes,No,No,No,Yes,Yes,Month-to-month,Yes,Electronic check,94.6,2283.15,No';
  put '4393-RYCRE,Male,0,No,No,44,Yes,No,Fiber optic,Yes,Yes,Yes,No,Yes,Yes,One year,Yes,Electronic check,106.05,4510.8,No';
  put '4584-LBNMK,Male,1,Yes,No,45,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Credit card (automatic),24.7,1174.35,No';
  put '7124-UGSUR,Female,1,Yes,No,61,Yes,Yes,Fiber optic,No,Yes,Yes,No,Yes,Yes,One year,Yes,Credit card (automatic),104.4,6405,Yes';
  put '1848-LBZHY,Female,0,Yes,No,7,Yes,No,DSL,Yes,No,No,No,No,No,Month-to-month,Yes,Bank transfer (automatic),50.3,355.1,No';
  put '1644-IRKSF,Female,0,Yes,Yes,33,Yes,No,Fiber optic,No,No,Yes,No,Yes,Yes,One year,Yes,Electronic check,93.8,3124.5,Yes';
  put '8020-BWHYL,Female,1,No,No,15,Yes,No,Fiber optic,No,Yes,No,No,No,No,Month-to-month,Yes,Credit card (automatic),75.3,1147.45,Yes';
  put '7721-DVEKZ,Female,0,No,No,1,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Mailed check,19.65,19.65,No';
  put '5018-HEKFO,Female,0,No,No,10,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,Yes,Mailed check,24.5,270.15,No';
  put '9309-BZGNT,Male,1,Yes,No,69,No,No phone service,DSL,No,No,Yes,No,No,No,One year,Yes,Credit card (automatic),29.8,2134.3,No';
  put '8053-WWDRO,Female,0,Yes,No,6,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Bank transfer (automatic),19.5,146.3,Yes';
  put '6082-GLJIX,Male,0,No,No,18,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Mailed check,19.25,331.35,No';
  put '4097-YODCF,Male,0,No,Yes,34,Yes,Yes,Fiber optic,Yes,Yes,No,No,Yes,Yes,One year,Yes,Electronic check,103.8,3470.8,No';
  put '3026-ATZYV,Female,0,Yes,Yes,37,Yes,No,DSL,Yes,Yes,No,No,Yes,Yes,One year,No,Bank transfer (automatic),75.1,2658.8,No';
  put '4631-OACRM,Male,1,No,No,15,Yes,No,Fiber optic,No,No,No,No,No,Yes,Month-to-month,Yes,Electronic check,79.4,1156.1,Yes';
  put '7880-XSOJX,Male,0,No,No,4,No,No phone service,DSL,Yes,Yes,No,Yes,No,No,Month-to-month,No,Mailed check,42.4,146.4,No';
  put '4508-OEBEY,Male,0,Yes,No,31,Yes,No,DSL,Yes,Yes,Yes,Yes,No,Yes,One year,Yes,Credit card (automatic),75.5,2424.45,No';
  put '5393-RXQSZ,Male,0,No,No,1,Yes,No,Fiber optic,No,No,No,No,No,Yes,Month-to-month,No,Electronic check,79.6,79.6,Yes';
  put '9386-LDCZR,Male,0,No,No,43,Yes,No,Fiber optic,Yes,Yes,Yes,Yes,No,No,One year,Yes,Credit card (automatic),90.65,3882.3,No';
  put '6408-WHTEF,Male,0,Yes,Yes,72,Yes,Yes,DSL,Yes,Yes,Yes,Yes,Yes,Yes,Two year,Yes,Mailed check,89.4,6376.55,No';
  put '1818-ESQMW,Female,0,No,No,27,Yes,No,Fiber optic,No,No,Yes,Yes,No,Yes,Month-to-month,Yes,Electronic check,89.2,2383.6,No';
  put '0402-OAMEN,Female,0,Yes,Yes,72,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Two year,No,Bank transfer (automatic),24.45,1709.1,No';
  put '2296-DKZFP,Female,0,Yes,No,65,Yes,No,DSL,Yes,Yes,Yes,No,No,Yes,Two year,No,Bank transfer (automatic),71,4386.2,No';
  put '5965-GGPRW,Male,0,Yes,Yes,72,Yes,Yes,Fiber optic,Yes,No,Yes,No,Yes,Yes,Two year,No,Bank transfer (automatic),105.25,7609.75,No';
  put '4673-KKSLS,Female,0,No,No,31,Yes,No,Fiber optic,Yes,No,Yes,Yes,No,No,Month-to-month,No,Electronic check,87.6,2724.25,No';
  put '4250-ZBWLV,Male,0,No,No,68,Yes,Yes,Fiber optic,No,Yes,Yes,Yes,Yes,Yes,One year,No,Electronic check,108.45,7176.55,Yes';
  put '0613-WUXUM,Female,0,Yes,Yes,70,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Two year,Yes,Mailed check,19.2,1401.4,No';
  put '5438-QMDDL,Female,0,Yes,No,19,Yes,No,DSL,No,Yes,No,No,No,Yes,Month-to-month,Yes,Mailed check,59.8,1130.85,No';
  put '6776-TLWOI,Male,0,No,No,3,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Mailed check,19.85,64.55,Yes';
  put '3058-WQDRE,Male,0,No,No,13,No,No phone service,DSL,No,No,No,No,No,No,Month-to-month,Yes,Bank transfer (automatic),25.15,331.85,No';
  put '9374-YOLBJ,Female,0,Yes,Yes,1,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Electronic check,19.25,19.25,No';
  put '7356-IWLFW,Male,0,Yes,Yes,46,Yes,Yes,Fiber optic,No,Yes,No,No,No,No,Month-to-month,Yes,Bank transfer (automatic),80,3769.7,No';
  put '6048-QBXKL,Female,1,No,No,2,Yes,Yes,DSL,No,Yes,No,No,No,No,Month-to-month,Yes,Credit card (automatic),56.55,118.25,No';
  put '3999-WRNGR,Female,0,Yes,Yes,60,No,No phone service,DSL,No,Yes,No,No,Yes,Yes,Month-to-month,Yes,Electronic check,49.75,3069.45,No';
  put '9137-UIYPG,Female,0,Yes,Yes,35,Yes,No,Fiber optic,Yes,No,Yes,Yes,Yes,Yes,Month-to-month,Yes,Electronic check,106.9,3756.45,No';
  put '2100-BDNSN,Female,0,Yes,No,5,Yes,Yes,DSL,No,No,Yes,Yes,Yes,No,Month-to-month,No,Bank transfer (automatic),67.95,350.3,Yes';
  put '1104-TNLZA,Male,1,Yes,No,28,Yes,Yes,Fiber optic,No,Yes,No,Yes,Yes,Yes,Month-to-month,Yes,Electronic check,105.8,2998,No';
  put '7696-AMHOD,Female,0,Yes,Yes,49,Yes,No,DSL,No,Yes,Yes,No,Yes,Yes,One year,No,Credit card (automatic),78,3824.2,No';
  put '1074-WVEVG,Female,0,Yes,No,59,Yes,No,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,One year,No,Mailed check,20.35,1267,No';
  put '6258-NGCNG,Male,0,No,No,7,Yes,Yes,No,No internet service,No internet service,No internet service,No internet service,No internet service,No internet service,Month-to-month,No,Mailed check,23.5,173,No';
  put '6898-RBTLU,Female,0,Yes,Yes,49,Yes,Yes,DSL,No,Yes,No,Yes,Yes,Yes,Two year,No,Bank transfer (automatic),79.3,3902.45,No';
  put '9739-JLPQJ,Female,0,Yes,Yes,72,Yes,Yes,Fiber optic,Yes,Yes,Yes,Yes,Yes,Yes,Two year,No,Credit card (automatic),117.5,8670.1,No';
  put '0270-THENM,Male,0,Yes,Yes,72,Yes,Yes,DSL,Yes,Yes,Yes,Yes,No,No,Two year,No,Bank transfer (automatic),69.85,5102.35,No';
  put '1273-MTETI,Female,1,No,No,4,Yes,Yes,Fiber optic,No,No,Yes,No,No,Yes,Month-to-month,Yes,Electronic check,88.85,372.45,Yes';
  put '9108-EJFJP,Female,0,Yes,No,1,Yes,No,DSL,Yes,Yes,No,No,No,No,Month-to-month,Yes,Mailed check,53.55,53.55,No';
  put '2451-YMUXS,Male,1,No,No,67,Yes,Yes,DSL,Yes,Yes,No,Yes,No,No,Two year,Yes,Bank transfer (automatic),64.55,4250.1,No';
  put '4501-VCPFK,Male,0,No,No,26,No,No phone service,DSL,No,No,Yes,Yes,No,No,Month-to-month,No,Electronic check,35.75,1022.5,No';
run;

proc import datafile="churn.csv"
    out=work.churn_data
    dbms=csv
    replace;
    getnames=yes;
    guessingrows=max;
run;

proc contents data=churn_data;
run;

proc print data=churn_data(obs=10);
run;

proc sql;
    select
        Churn,
        count(*) as Total_Customers,
        calculated Total_Customers * 100 / (select count(*) from churn_data) as Percentage
    from churn_data
    group by Churn;
quit;

proc sql;
    select
        Contract,
        Churn,
        count(*) as Count
    from churn_data
    group by Contract, Churn;
quit;

data high_risk;
    set churn_data;
    if tenure < 12 and MonthlyCharges > 70 then Risk = "High";
    else Risk = "Low";
run;

proc freq data=high_risk;
    tables Risk*Churn;
run;
