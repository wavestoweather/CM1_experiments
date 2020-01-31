#!/usr/bin/env python3
##### -*- coding: utf-8 -*-
"""
Created on Wed Nov 20 17:04:58 2019

@author: egroot
"""

import numpy as np
import matplotlib.pyplot as pl
import matplotlib
matplotlib.rcParams.update({'font.size': 48})

list_of_sims=["control_ref_200m","cubic_res_200m","ref_res_1km","ref_res_500m","controlling_lve_0.6","controlling_lve_0.8","controlling_lve_0.9","controlling_lve_1.1","controlling_lve_1.2","controlling_vadv_0.0","controlling_vadv_0.5","controlling_vadv_0.8","controlling_vadv_1.5"]
list_full_names=["reference/rect.: 200m","cubic: 200m","rect.: 1000m","rect.: 500m","lv x0.6","lv x0.8","lv x0.9","lv x1.1","lv x1.2","no vert. u/v adv.","vert. u/v adv. x0.5","vert. u/v adv. x0.8","vert. u/v adv. x1.5"]
list_clrs =["black","grey","grey","grey",(0.4,0,0),(0.55,0,0),(0.7,0,0),(0.85,0,0),(1,0,0),(0,0.55,0),(0,0.7,0),(0,0.85,0),(0,1,0)]
list_styles = ["-","--",":","-","-","-","-","--","--","-","-","-","--"]
list_w = [10,6,6,3,3,3,3,5,5,3,3,3,5]
def readfiles(sim):
    '''
    This function reads the files with values generated by the integrated vertical profiles script, obtained over the selected region in that file as mean values and instantaneous values of the quantities of interest
    '''
    path="/lustre/project/m2_jgu-w2w/w2w/egroot/CM1mod/cm1r19.8/run/"+sim+"/"
    div_array=np.genfromtxt(path+"div.csv",delimiter=",")
    cond_array=np.genfromtxt(path+"qtend.csv",delimiter=",")
    momadv_array=np.genfromtxt(path+"momadv.csv",delimiter=",")
    deltaMSE_array=np.genfromtxt(path+"delta_MSE.csv",delimiter=",")
    z_array=np.genfromtxt(path+"zarray.csv",delimiter=",")
    sim_array=np.array([z_array,div_array,cond_array,momadv_array,deltaMSE_array])
    return sim_array

def genplot():
    fig = pl.figure(figsize=(75,32))
    ax1,ax2,ax3,ax4 = fig.add_subplot(141),fig.add_subplot(142),fig.add_subplot(143),fig.add_subplot(144)
    return fig,ax1,ax2,ax3,ax4

def plotvariables(simarray,simname,cr,s,w):
    ax1.plot(simarray[1,:],simarray[0,:], ls=s, lw=w,c=cr)
    ax2.plot(simarray[2,:],simarray[0,:], ls=s, lw=w,c=cr,label=simname)
    ax3.plot(simarray[3,:],simarray[0,:], ls=s, lw=w,c=cr)
    ax4.plot(simarray[4,:],simarray[0,:],ls=s, lw=w,c=cr)

def addlegends(axis,string):
    axis.set_xlabel(string)
    axis.set_ylim(-1,21)
    ax2.legend(fontsize=36)
    axis.xaxis.grid()

## the actual job done:

fig,ax1,ax2,ax3,ax4=genplot()
all_numbers=np.zeros((len(list_of_sims),5,200))
for i in np.arange(len(list_of_sims)):
    result = readfiles(list_of_sims[i])
  ##  nlev = len(result[0,:])
  ##  all_numbers[i,:,:nlev]=result
    plotvariables(result,list_full_names[i],list_clrs[i],list_styles[i],list_w[i])

addlegends(ax1,r"Divergence ($10^{-5} s^{-1}$)")
addlegends(ax2,r"Condensation rate ($s^{-1}$)")
addlegends(ax3,r"Vert. adv. of hor. mom. ($ms^{-2}$)")
addlegends(ax4,r"$\Delta$Moist static energy ($J/kg$)")
fig.savefig("/lustre/project/m2_jgu-w2w/w2w/egroot/CM1mod/cm1r19.8/run/budgets/budget_overview.png")
fig.savefig("/lustre/project/m2_jgu-w2w/w2w/egroot/CM1mod/cm1r19.8/run/budgets/budget_overview.pdf")
