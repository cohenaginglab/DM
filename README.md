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

Example of use of the [DM_calc function](https://github.com/cohenaginglab/DM/blob/f4c227e39e806722e2a5aba1c36e27279a3f4cf3/DM%20calculation.R):
```
data$DM17 <- DM_calc(data, var.list = DM17, own.rp = F, log = T)
```
