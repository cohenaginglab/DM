# DM

This code is intended to calculate physiological dysregulation using the Mahalanobis distance (DM). DM represents an estimation of an individual's overall homeostatic state, by measuring the distance of its biomarker profile compared to a reference population. Depending on available variables, three versions can be calculated:
1. DM9: MCH, RDW, platelet count, red blood cell count, hemoglobin, white blood cell count, basophil proportion, HDL, and lymphocyte proportion.
2. DM17: MCH, RDW, platelet count, red blood cell count, hemoglobin, white blood cell count, basophil proportion, HDL, lymphocyte proportion, GGT, AST, alkaline phosphatase, total proteins, calcium, albumin, potassium, and vitamin B12.
3. DM31: MCH, RDW, platelet count, red blood cell count, hemoglobin, white blood cell count, basophil proportion, HDL, lymphocyte proportion, GGT, AST, alkaline phosphatase, total proteins, calcium, albumin, potassium, vitamin B12, hematocrit, MCHC, neutrophil proportion, monocyte proportion, ferritin, glucose, chloride, sodium, folate, total cholesterol, triglycerides, lactate dehydrogenase, uric acid, and ALT.

## Important steps before calculating DM:
1. Make sure all variables are correctly labeled and all units are in SI units. See [the variable list](https://github.com/cohenaginglab/DM/blob/6262be62e8cfa90df7d1f1393f1ba48d991d2458/Variable%20units.pdf) for more details.
2. We provide the needed summary statistics (biomarker means and SDs, and the variance-covariance matrix) from our reference population, which is comprised of 3414 individuals drawn from three datasets, two from the USA (BLSA and NHANES) and one from Italy (InChianti). We strongly encourage the use of our reference population, unless users are working with a population that has highly specific characteristics (e.g. patients with cancer). In this case, it is possible to use the study population as its own reference population, provided that it has a sufficient sample size (>100). To do so, use the "own.rp = T" argument in the DM_calc function.
3. You can specify the chosen DM version in the "var.list" argument (e.g. var.list = DM17).
4. DM usually has a log-normal distribution. Choose "log = T" if you want to use it in statistical operations that require a normal distribution.
5. DM calculation requires complete observations, hence NA will be returned when data are missing.

Example of use of the [DM_calc function](https://github.com/cohenaginglab/DM/blob/9a29f512b20c901be2a82c984b7b8dc1a1e78e0d/DM%20calculation.R):
```
data$DM17 <- DM_calc(data, var.list = DM17, own.rp = F, log = T)
```

## We also provide the summary statistics needed to calculate DM versions from previous articles:
- [Dansereau G, Wey TW, Legault V, Brunet MA, Kemnitz JW, Ferrucci L, Cohen AA. Conservation of physiological dysregulation signatures of aging across primates. Aging Cell. 2019 Apr;18(2):e12925. doi: 10.1111/acel.12925.]()
- [Cohen AA, Legault V, Li Q, Fried LP, Ferrucci L. Men Sustain Higher Dysregulation Levels Than Women Without Becoming Frail. J Gerontol A Biol Sci Med Sci. 2018 Jan 16;73(2):175-184. doi: 10.1093/gerona/glx146.]()
- [Cohen AA, Li Q, Milot E, Leroux M, Faucher S, Morissette-Thomas V, Legault V, Fried LP, Ferrucci L. Statistical distance as a measure of physiological dysregulation is largely robust to variation in its biomarker composition. PLoS One. 2015 Apr 13;10(4):e0122541. doi: 10.1371/journal.pone.0122541.]()
- [Li Q, Wang S, Milot E, Bergeron P, Ferrucci L, Fried LP, Cohen AA. Homeostatic dysregulation proceeds in parallel in multiple physiological systems. Aging Cell. 2015 Dec;14(6):1103-12. doi: 10.1111/acel.12402.]()
- [Milot E, Morissette-Thomas V, Li Q, Fried LP, Ferrucci L, Cohen AA. Trajectories of physiological dysregulation predicts mortality and health outcomes in a consistent manner across three populations. Mech Ageing Dev. 2014 Nov-Dec;141-142:56-63. doi: 10.1016/j.mad.2014.10.001.](https://raw.githubusercontent.com/cohenaginglab/DM/main/Milot2014)
