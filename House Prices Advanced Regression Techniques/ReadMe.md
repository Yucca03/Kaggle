## House Prices: Advanced Regression Techniques

### 資料集：
##### Training Data：train.csv
##### Testing Data：test.csv
### 分析工具：
##### R Language

### Data Preprocessing
##### 在資料的前處理，首先觀察一下Training Data，發現裡面有許多Missing Value，這會大大影響預測的結果，所以用以下的步驟做資料的前處理：
##### 1.	Combine：將Testing Data與Training Data兩個Data Set做結合，原因是因為如果分開處理可能會導致兩邊的欄位不一致，並且結合能增加處理的速度。
##### 2.	Data Reduction：將N/A值超過Data Set數一半的欄位刪除，刪除的欄位有Alley、FireplaceQu、PoolQC、Fence和MiscFeature。
##### 3.	Data Cleaning：將缺失值補上該有的值，這裡有兩種區別1. 類別型態：我們去計算眾數，將缺失值填入該值。2. 數值型態：計算該欄位所有值的平均值，將缺失值填入平均數。
##### 4.	Separate：將合起來的欄位以ID再次分成Training Data跟Test Data。
