function [map] = mnist_demo(codelens,data_set,dataset_L,test_data,test_L,dataName)

    %% public parameter
    AnchorNum = 500; Knum = 5;
    anchor_nm = ['anchor_' num2str(AnchorNum)];
    eval(['[~,' anchor_nm '] = litekmeans(data_set, AnchorNum, ''MaxIter'', 10);']);
    eval(['anchor_set.' anchor_nm '= ' anchor_nm, ';']);
    eval(['anchor = anchor_set.' anchor_nm ';'])

    %% JSH
    [~,Z, ~] = get_Z( data_set, anchor, Knum ,0 );  
    maxItr=10; alpha=10;
    [F,~] = JSH(data_set',Z,codelens,codelens,alpha,maxItr);
    H = data_set*F' > 0;
    tH = test_data*F' > 0;
    [map,Pre,Rec,Fmeasure,B_dataset,B_test] = test_traditional_MapPreRec( dataset_L, test_L,H, tH);
    save(['a-result/','JSH',dataName, num2str(codelens), 'bits.mat'],'B_dataset','B_test','map','Pre','Rec','Fmeasure');
    
end