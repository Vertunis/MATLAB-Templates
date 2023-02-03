function [dp]= fu1(~,y)
dp=zeros(2,1) ; % dp wird als Spaltenvektor generiert  
dp(1)=y(2); 
dp(2)=-0.2*y(2)-2*y(1)+10; 
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


