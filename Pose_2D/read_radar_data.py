#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep  4 20:11:40 2018

@author: alexalcocer
"""

import numpy as np
import matplotlib.pyplot as plt
import robotteknikk as rob

M = np.genfromtxt('radar_data.csv', delimiter=",")
N = M.shape[0] #


PTO = np.zeros((N,2)) # store target position [xto yto]
xso = M[:,0]
yso = M[:,1]
theta = M[:,2]*np.pi/180 # convert to radians
xst = M[:,3]
yst = M[:,4]

plt.figure(1)
plt.clf()
plt.subplot(121)
plt.plot(xso,yso,'b^-')
plt.xlabel('x [m]')
plt.ylabel('y [m]')
plt.legend('Ship')
plt.grid()
plt.title('Ship GPS position measurements')
plt.subplot(122)
plt.plot(xst,yst,'ko-')
plt.plot(0,0,'b^-')
plt.xlabel('radar x [m]')
plt.ylabel('radar y [m]')
plt.legend('target','Ship')
plt.title('RADAR target relative position measurements')
plt.grid()
plt.axis('equal')

plt.figure(2)
plt.plot(theta,'.-',label='Heading')
plt.xlabel('Time [s]')
plt.ylabel('Heading [deg]')
plt.legend()
plt.title('Ship heading measurements')
plt.grid()


    
