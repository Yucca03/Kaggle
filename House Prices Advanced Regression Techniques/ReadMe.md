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
##### 3.	Data Cleaning：將缺失值補上該有的值，這裡有兩種區別1. 類別型態：計算眾數，將缺失值填入該值。2. 數值型態：計算該欄位所有值的平均值，將缺失值填入平均數。
##### 4.	Separate：將合起來的欄位以ID再次分成Training Data跟Test Data。


### Algorithm without feature selection
##### 1.	Decision tree: 這邊都是先跑沒有特別挑選特定欄位，並且以10 - fold Cross Validation做訓練，最後跑出來的結果分數為：0.24654，Ranking：1972
##### 2.	Support Vector Machine: 沒有特別挑選特定欄位，最後跑出來的結果分數為：0.12748，Ranking：985。
##### 3.	Random Forest: 沒有特別挑選特定欄位，最後跑出來的結果分數為：0.14673。
##### 4.	Linear Regression: 沒有特別挑選特定欄位，最後跑出來的結果分數為：0.18879。

### Feature selection
##### 使用隨機森林，選擇對於演算法較重要的欄位，使用R裡面的函式Variable importance plot，選擇IncNodePurity高的欄位，我們對每一個演算法分別用前三名、前五名、前十名的Feature去做分析。

### Algorithm with feature selection
##### 1.	Decision tree: 經過特定欄位的選擇，分別跑了前三名、前五名、前十名的Feature去做分析，最後用前三個Feature去跑分數最高，所以我們以最高的Score來當結果。Score：0.23645。
##### 2.	Support Vector Machine: 經過特定欄位的選擇，分別跑了前三名、前五名、前十名的Feature去做分析，最後用前三個Feature去跑分數最高，所以我們以最高的Score來當結果。Score：0.17663。
### 3.	Random forest: 經過特定欄位的選擇，分別跑了前三名、前五名、前十名的Feature去做分析，並且用500棵樹去做Training，最後用前十個Feature去跑分數最高，所以我們以最高的Score來當結果。Score：0.17795。
### 4.	Linear Regression: 經過特定欄位的選擇，分別跑了前三名、前五名、前十名的Feature去做分析，最後用前三個Feature去跑分數最高，所以我們以最高的Score來當結果。Score：0.17989。
