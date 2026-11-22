# Representation Propagation: A Fast and Reliable Semi-supervised Learning Method (RP)

## File List
DEMO.m—Reproduce the single-run pipeline: load data → similarity → sampling → init → iterate → evaluate
normalize.m—Normalize each sample in a given dataset
calculateS.m—Builds the N×N similarity matrix S from pairwise distances
labelY.m—Equal-per-class stratified sampling of labeled samples
iniWandF.m—Initializes the dense coefficient tensor W (N×N×C) and appropriateness F (N×C)
updateWandF.m—Iterative updates of W and F; calls normalizeMinMax.m
normalizeMinMax.m—Per-sample min-max normalization for F
iniLabled.m—Placeholder initialization helper

## Environment
MATLAB version: R2022b
Memory: 64 GB workstation

## Datasets and Hyperparameters
Each .mat file contains a matrix whose last column is the class label and whose remaining columns are features. DEMO.m uses:
sigma(Gaussian kernel width, it is tuned over [0.01, 1] with an interval of 0.01)
r(nominal labeled ratio): 0.03
T(number of iterations): 300
paraeta(parameter η): min(mean(S))
paragamma(parameter γ) : min(mean(S))
Dataset-specific sigma values used in the experiments:
ecoli: 0.11
vehicle: 0.16
flare: 0.07
contraceptive: 0.02
phoneme: 0.09
nursery: 0.16

## Sampling Protocol for labeled samples for each dataset
labelY.m implements equal-per-class stratified sampling. Specifically,
Numlabeled = floor(N*r);
numC = ceil(Numlabeled/C);
Please note that
The realized labeled fraction is C*numC / N, which can differ from the nominal r on used multi-class datasets. For Ecoli (N=336, C=8): 3% gives numC = 2, i.e. 16 labeled samples (4.76%).
If a class has fewer than numC samples, all its samples are labeled and it contributes no unlabeled samples. Such classes are therefore excluded from the unlabeled accuracy.
DEMO.m reports accuracy on unListLabeled only.

## Normalization
updateWandF.m calls F = normalizeMinMax(F); inside every iteration, before the convergence check. normalizeMinMax.m performs per-sample min–max normalization, mapping each row of F to [0,1].

## Outputs
DEMO.m prints/stores:
ACC: unlabeled accuracy on unListLabeled
time: CPU time of the iterative updates
W, F: final coefficient tensor and appropriateness matrix
preY: predicted labels for all unlabeled samples

##Reproducibility Statement:
This repository corresponds to lastest tag RPSemi, the version used to produce the reported results in the manuscript as follows.
After setting the parameters, by wrapping the pipeline in DEMO.m in a loop of 30 runs, the classification accuracy of RP on each dataset shown in Fig. 4 and the classification results in Fig. 11. In addition, by randomly selecting one sample from each class as a labeled sample, the classification results on the synthetic dataset in Fig. 3 and the LFW dataset in Fig. 8 can be obtained.
By recording F at every iteration via updateWandF.m, the iterative convergence behavior of RP shown in Fig. 5, Fig. 3(c), and Fig. 8(c) can be generated. Accordingly, the risk-coverage curves for selective classification under different thresholds of the label appropriateness in Fig. S3 can be investigated using the F after achieving convergence.
The runtime of each RP run can be recorded via initime=cputime; and time=cputime-initime; in DEMO.m, from which Fig. 6 can be generated.
By setting different values of sigma in DEMO.m, the influence of sigma on the classification performance of RP can be observed, from which Fig. 7 can be generated.
By varying r in DEMO.m (nominal 3%, 5%, 10%, and 15%), the influence of different labeled-sample ratios on the classification performance of RP can be observed to generate Fig. S2 and Table SIV.

## Complexity and Memory (implementation-aware)
Time: dominated by similarity construction O(N2d) and the iterative updates O(μN2KT)
Space: the coefficient tensor is a dense N×N×C array plus the dense N×N similarity matrix, i.e.
O((K+1)N2). The quantity μKN2 is the number of coefficients that are updated/nonzero, not the memory allocated by the dense array. These two are not equivalent.

