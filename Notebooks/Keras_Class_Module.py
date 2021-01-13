#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#Create a class for Deep Learning models.

from sklearn.model_selection import train_test_split
import tensorflow as tf
from sklearn.metrics import mean_squared_error, mean_absolute_error
from tensorflow.keras.callbacks import EarlyStopping
from sklearn.preprocessing import MinMaxScaler
import numpy as np
import pandas as pd 

class DeepLearning():
    
    def __init__(self, X, y, regression_type, units=20, hidden_layers=1, drop="None", input_dim=5, output_shape=5, optimizer="adam", activation="relu"):
        self.X = X
        self.y = y
        self.input_dim = input_dim
        self.activation = activation
        self.optimizer = optimizer
        self.output_shape = output_shape
        self.model_split()
        self.regression_type = regression_type
        self.drop = drop
        self.units=units
        self.hidden_layers = hidden_layers
        
    def model_split(self):
        X_train, X_test, y_train, y_test = train_test_split(self.X, self.y, train_size=.7)
        scaler = MinMaxScaler()
        X_train = scaler.fit_transform(X_train)
        X_test = scaler.transform(X_test)
        self.X_train = X_train
        self.y_train = y_train
        self.X_test = X_test
        self.y_test = y_test
    
    def make_model(self):
        model = tf.keras.models.Sequential()
        
        model.add(tf.keras.layers.Dense(self.units, activation=self.activation, input_dim= self.input_dim))
        for x in range(self.hidden_layers):
            model.add(tf.keras.layers.Dense(self.units, activation=self.activation))
        
        model.add(tf.keras.layers.Dense(self.output_shape))
        self.model = model
    
    
    def compile_model(self):
        self.model.compile(loss="mse", optimizer="adam", metrics=["mse"])
    
    def fit_model(self):
        early_stopping = EarlyStopping(monitor="val_loss", mode="min", verbose=1, patience=25)
        
        self.model.fit(self.X_train, self.y_train, epochs=600, validation_data=(self.X_test, self.y_test), callbacks=[early_stopping])
        
    def evaluate_model(self):
        ypred = self.model.predict(self.X_test)
        
        if self.regression_type=="multi":
            list_of_regions = ["NA", "EU", "JP","Other","Global"]
            if self.drop!="None":
                list_of_regions.remove(self.drop)
            for i, region in enumerate(list_of_regions):
                print(f"{region} RMSE: %.4f" % np.sqrt(mean_squared_error(self.y_test[:,i],ypred[:,i])))
                print("\n")
                print(f"{region} MSE: %.4f" % mean_squared_error(self.y_test[:,i],ypred[:,i]))
                print("\n")
                print(f"{region} MAE: %.4f" % mean_absolute_error(self.y_test[:,i],ypred[:,i]))
                print("\n")
                print(f"The mean sales of {region} for this dataset is %.4f" % np.mean(self.y[:,i]))
                print("\n")
            
        else:
            print("NA RMSE: %.4f" % np.sqrt(mean_squared_error(self.y_test, ypred)))
            print("\n")

            print("NA MSE: %.4f" % mean_squared_error(self.y_test, ypred))
            print("\n")

            print("NA MAE: %.4f" % mean_absolute_error(self.y_test, ypred))
            print("\n")
            
            print("The mean of NA_Sales for this dataset is %.4f" % np.mean(self.y))
            
        
    def graph_model(self):
        loss_df = pd.DataFrame(self.model.history.history)
        loss_df.plot()

