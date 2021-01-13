#!/usr/bin/env python
# coding: utf-8

# In[ ]:

from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import pandas as pd
import numpy as np
import hvplot.pandas
from path import Path
import plotly.express as px


class GraphKMeans():
    
    # Class Level Attributes
    n_clusters=4
    
    def __init__(self, data):
        self.data = data
    
    def scale_data(self):
        scaler = StandardScaler()
        self.scaled_data = scaler.fit_transform(self.data)
    
    def elbow_curve(self):
        inertia=[]
        k=list(range(1,11))
        for i in k:
            km=KMeans(n_clusters=i)
            km.fit(self.scaled_data)
            inertia.append(km.inertia_)
        elbow_data = {"k":k, "inertia": inertia}
        elbow_df = pd.DataFrame(elbow_data)
        return elbow_df.hvplot.line(x="k", y="inertia", title="Elbow_Curve")
    
    def cluster_data(self, k):
        
        km = KMeans(n_clusters=k)
        km.fit(self.data)
        my_labels = km.predict(self.data)
        classes = pd.DataFrame(my_labels)
        self.data.reset_index(drop=True, inplace=True)
        my_full_df = pd.concat([self.data, classes], axis=1)
        my_full_df.rename({0:"class"},axis=1,inplace=True)
        x_name = my_full_df.columns[0]
        y_name = my_full_df.columns[1]
        z_name = my_full_df.columns[2]
        classes = my_full_df.columns[3]

        
        fig = px.scatter_3d(my_full_df, x=x_name,y=y_name,z=z_name,color="class",symbol="class",
                   width=800)
        fig
        fig.update_layout(legend=dict(x=0,y=1))
        fig.show()
    

