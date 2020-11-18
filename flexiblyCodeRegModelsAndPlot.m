% Flexibly automate regression models and plotting/saving output
% Email Lindsay Olson with questions: olsonlindsaya@gmail.com



for G = 1:3
    
    switch G
        
        case {1}
            gender = 1; %boys
            thisGender = 'Boys'
            thisDir = '/Volumes/LO_drive/restingStateData/wholeSample/corrPlotFigures_bxAnalyses/ASDboys_sig_ASDB_X2ROIs_pos/';
        case {2}
            gender = 0; %girls
            thisGender = 'Girls'
            thisDir = '/Volumes/LO_drive/restingStateData/wholeSample/corrPlotFigures_bxAnalyses/ASDgirls_sig_ASDB_X2ROIs_pos/';
        case {3}
            gender = 2;
            thisGender = 'Combined'
            thisDir = '/Volumes/LO_drive/restingStateData/wholeSample/corrPlotFigures_bxAnalyses/combinedGenders_sig_ASDB_X2ROIs_pos/';
    end
    
    
    for c = 1:length(predictorArray)
        
        thisPredictor = predictorArray{c};
        thisPredictorName = predictorNames{c};
        
        if gender == 2
            domainArray = {ADOS_Array; ADI_Array; FIQ_Array; genderArray};
            domainNames = {'ADOS'; 'ADI'; 'FSIQ'; 'Gender'};
        else
            domainArray = {ADOS_Array; ADI_Array; FIQ_Array};
            domainNames = {'ADOS'; 'ADI'; 'FSIQ'};
        end
            
            
        
        
        for i = 1:length(domainArray)
            
            if gender == 2
                
                thisDomain = domainArray{i}
                thisDomainName = domainNames{i};
                
                
                mdl = fitlm(thisPredictor, thisDomain);
                [r, pval] = corr(thisPredictor, thisDomain, 'Rows', 'complete');
                

                thisVarGroupCoefficients = strcat('ASD_', thisDomainName, thisPredictorName, thisGender, '_MdlCoeffs')
                
            else
                
                thisDomain = domainArray{i}
                thisDomainName = domainNames{i};
                
                mdl = fitlm([thisPredictor(genderArray==gender)], thisDomain(genderArray==gender));
                [r, pval] = corr(thisPredictor(genderArray==gender), thisDomain(genderArray==gender), 'Rows', 'complete');
                
                thisVarGroupCoefficients = strcat('ASD_', thisDomainName, thisPredictorName, thisGender, '_MdlCoeffs')
            end
   
            
            
            eval([thisVarGroupCoefficients '= table2array(mdl.Coefficients)']) 
%             clear r pval thisFigName
            
         
            
            %% PLOT %%
            close all
            
            thisPrecision = digits(3);
     
            
            r = num2str(r);
            pval = num2str(pval);
            
            figure()
            hold on
            
           
            
            
            if gender == 2
                
                if strmatch(thisDomainName, 'Gender')
                    
                    h = boxplot(thisPredictor, genderArray)
                    set(h,{'linew'}, {3})
                    ylabel(thisPredictorName)
%                     xlabel(genderArray)
                    set(gca,'xtick',1:2, 'xticklabel',{'Girls','Boys'}) 
                    thisFigName = strcat(thisDomainName, thisGender, 'corrPlot.fig');
                    set(findobj(get(h(1), 'parent'), 'type', 'text'), 'fontsize', 40)
                    
                    dim = [.2 .5 .3 .3];
                    str = strcat({'r:'}, {' '},  r, {'pval:'}, {' '}, pval);
                    annotation('textbox',dim,'String',str,'FitBoxToText','on')
                    
                    thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.fig');
                    
                    saveas(1, strcat(thisDir,thisFigName))
                    thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                    %         thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                    saveas(1, strcat(thisDir,thisFigName))
                    
                else
                    
                    plot(thisPredictor, thisDomain, '.', 'Markersize', 15)
                    set(gca, 'Fontsize', 13)
                    xlabel(thisPredictorName)
                    ylabel(thisDomainName)
                    
                    title(thisGender)
                    %         Annotate the figure %
                    
                    
                    dim = [.2 .5 .3 .3];
                    str = strcat({'r:'}, {' '},  r, {'pval:'}, {' '}, pval);
                    annotation('textbox',dim,'String',str,'FitBoxToText','on')
                    h = lsline;
                    set(h(1), 'Linewidth', 3);
                    %         thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                    thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.fig');
                    
                    saveas(1, strcat(thisDir,thisFigName))
                    thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                    %         thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                    saveas(1, strcat(thisDir,thisFigName))
                    
                end
                
                
            else
                
                plot(thisPredictor(genderArray==gender), thisDomain(genderArray==gender), '.', 'Markersize', 15)
                set(gca, 'Fontsize', 13)
                xlabel(thisPredictorName)
                ylabel(thisDomainName)
                
                title(thisGender)
                %         Annotate the figure %
                
                
                dim = [.2 .5 .3 .3];
                str = strcat({'r:'}, {' '},  r, {'pval:'}, {' '}, pval);
                annotation('textbox',dim,'String',str,'FitBoxToText','on')
                h = lsline;
                set(h(1), 'Linewidth', 3);
                %         thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.fig');
                
                saveas(1, strcat(thisDir,thisFigName))
                thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                %         thisFigName = strcat(thisPredictorName, '_', thisDomainName, thisGender, 'corrPlot.jpg');
                saveas(1, strcat(thisDir,thisFigName))
                
            end % plot loop
            
        end %predictor loop
        
    end % domain loop
    
end % gender loop


%% Regression TD and ASD--Does Dx or Sex predict the AVERAGE w/in and between domain connectivity? 

ID_Array = vertcat(ADOS_ADI(:, 1), TD_Array(:, 1));
genderArray = cell2mat(vertcat(ADOS_ADI(:, 9), TD_Array(:, 3)));
DxArray = vertcat(ones(length(ADOS_ADI), 1), zeros(length(TD_Array), 1));

sensoryWithinArray = cell2mat(vertcat(ADOS_ADI(:, 10), TD_Array(:, 10)));
sensoryBetweenArray = cell2mat(vertcat(ADOS_ADI(:, 11), TD_Array(:, 11)));
DMNWithinArray = cell2mat(vertcat(ADOS_ADI(:, 12), TD_Array(:, 12)));
DMNBetweenArray = cell2mat(vertcat(ADOS_ADI(:, 13), TD_Array(:, 13)));
AttnWithinArray = cell2mat(vertcat(ADOS_ADI(:, 14), TD_Array(:, 14)));
AttnBetweenArray = cell2mat(vertcat(ADOS_ADI(:, 15), TD_Array(:, 15)));


RMSD_Array = cell2mat(vertcat(ADOS_ADI(:, 7), TD_Array(:, 8)));
Age_Array = cell2mat(vertcat(ADOS_ADI(:, 8), TD_Array(:, 4)));
FIQ_Array = cell2mat(vertcat(ADOS_ADI(:, 16), TD_Array(:, 7)));


predictorArray = {sensoryWithinArray; sensoryBetweenArray; DMNWithinArray; DMNBetweenArray; AttnWithinArray; AttnBetweenArray};
predictorNames = {'sensoryWithin'; 'sensoryBetween'; 'DMNWithin'; 'DMNBetween'; 'AttnWithin'; 'AttnBetween'};

thisDir = '/Volumes/LO_drive/restingStateData/wholeSample/regAnalyses_12042017/';

for c = 1:length(predictorArray)
    
    thisPredictor = predictorArray{c};
    thisPredictorName = predictorNames{c};
    
    domainArray = [genderArray, DxArray, genderArray.*DxArray];
    domainNames = {'Gender'; 'Diagnosis'; 'GenderByDx'};
    
%     domainArray = [genderArray];
%     domainNames = {'Gender'};
%     
    domainArray = [DxArray];
    domainNames = {'Diagnosis'};
    
    
    theseCovariates = [FIQ_Array, Age_Array];
    theseCovariateNames = {'FSIQ'; 'Age'};
    
    
    mdl = fitlm([domainArray theseCovariates], thisPredictor);
    %     [r, pval] = corr(thisPredictor, thisDomain, 'Rows', 'complete');
    
    
    thisVarGroupCoefficients = strcat(thisPredictorName, '_MdlCoeffs_withCovariates')
    
    
    
    eval([thisVarGroupCoefficients '= table2array(mdl.Coefficients)'])
    
    
    mdl = fitlm(domainArray, thisPredictor);
    
    
    
    thisVarGroupCoefficients = strcat(thisPredictorName, '_MdlCoeffs')
    
    
    
    eval([thisVarGroupCoefficients '= table2array(mdl.Coefficients)'])
  

end %predictor loop