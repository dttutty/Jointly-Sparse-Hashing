function [map,Pre, Rec,Fmeasure,B_dataset,B_test] = test_traditional_MapPreRec( dataset_L, test_L,B_dataset, B_test )
   %% test MAP
    S = compute_S(dataset_L,test_L) ;
    B_dataset = compactbit(B_dataset);
    B_test = compactbit(B_test);
    Dhamm = hammingDist(B_test, B_dataset);
    map = callMap(S', Dhamm)

   %% test Pre and Recall
    hammRadius = 2;
    cateTrainTest = bsxfun(@eq, dataset_L, test_L');
    hammTrainTest = hammingDist(B_test, B_dataset)';
    % hash lookup: precision and reall
    Ret = (hammTrainTest <= hammRadius+0.00001);
    [Pre, Rec] = evaluate_macro(cateTrainTest, Ret)
    Fmeasure = F1_measure(Pre, Rec)
end