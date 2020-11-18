%% email lindsay olson w/ questions: olsonlindsaya@gmail.com

%% Run Regression Models %%
 allConn = [roi_comps_rho_ASD_Boys; roi_comps_rho_ASD_Girls; roi_comps_rho_TD_Girls; roi_comps_rho_TD_Boys];
 
dxArray = cell2mat(allSubjects(:,10))
genderArray = cell2mat(allSubjects(:,11))

 intxn_dx_gender = num2cell(dxArray.*genderArray);

  subj_array(:,:) = horzcat(allSubjects(:,2), allSubjects(:,5), allSubjects(:,6), allSubjects(:,4), allSubjects(:,8),...
     allSubjects(:,10), allSubjects(:,11), intxn_dx_gender)
 
 subj_array = cell2mat(subj_array)
 

     

%% Main effects models only w/ site as random effect
 for rc = 1:length(roi_comps)
     
     thisRC = roi_comps_rho(:,rc)
     
     tbl = array2table([thisRC subj_array], 'VariableNames', {'FC','ID', 'Age', 'IQ', 'Motion', 'Site', 'dx', 'gender', 'genderXDx'});
    
     
     
    lme = fitlme(tbl, 'FC ~ dx + gender + (1|Site)')
  
         
    Coefficients = lme.Coefficients;
    Intercept(rc, 1) = Coefficients.Estimate(1);
    Beta_Dx(rc, 1) = Coefficients.Estimate(2);
    Beta_Gender(rc, 1) = Coefficients.Estimate(3);
    

    
    tstat_Coefficients(rc, 1) = Coefficients.tStat(1);
    tstat_dx(rc,1)= Coefficients.tStat(2)
    tstat_gender(rc, 1) = Coefficients.tStat(3)

    pvals_Gender(rc, 1) = Coefficients(2, 4);
    pvals_Dx(rc, 1) = Coefficients(3, 4);

     
 end
 

ME_Gender = find(pvals_Gender<0.05)
ME_Dx = find(pvals_Dx<0.05)

%% Model with ME and dxXGender intxn, with site as random effect


 for rc = 1:length(roi_comps)
     
     thisRC = roi_comps_rho(:,rc);
     
     tbl = array2table([thisRC subj_array], 'VariableNames', {'FC','ID', 'Age', 'IQ', 'Motion', 'Site', 'dx', 'gender', 'genderXDx'});
    
     
     
    lme = fitlme(tbl, 'FC ~ dx + gender + genderXDx + (1|Site)');

         
    Coefficients = lme.Coefficients;
    Intercept(rc, 1) = Coefficients.Estimate(1);
    Beta_Dx(rc, 1) = Coefficients.Estimate(2);
    Beta_Gender(rc, 1) = Coefficients.Estimate(3);
    
    Beta_Intxn_DxGender(rc, 1) = Coefficients.Estimate(4);
    
    
    tstat_Intercept(rc, 1) = Coefficients.tStat(1);
    tstat_dx(rc,1)= Coefficients.tStat(2);
    tstat_gender(rc, 1) = Coefficients.tStat(3);
    tstat_Intxn_DxGender(rc, 1) = Coefficients.Estimate(4);
    
    pvals_Intercept(rc, 1) = Coefficients.pValue(1);
    pvals_Gender(rc, 1) = Coefficients.pValue(2);
    pvals_Dx(rc, 1) = Coefficients.pValue(3);
    pvals_Intxn_DxGender(rc, 1) = Coefficients.pValue(4);
   
     
 end
 
sigIntxn_DxGender = find(pvals_Intxn_DxGender<0.05);
ME_Gender = find(pvals_Gender<0.05)
ME_Dx = find(pvals_Dx<0.05)
