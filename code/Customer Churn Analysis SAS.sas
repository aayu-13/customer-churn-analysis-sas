proc import datafile="/home/your-folder/churn.csv"
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
