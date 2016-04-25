function [numberofclass1, numberofclass2, numberofclass3, class1,class2,class3,class4,esofclass1,esofclass2,esofclass3] = FL(T,P,Y)
%%[T,~,P,~,Y,~] = ELM('baogang_train.txt', 'baogang_test.txt', 0,20, 'sig');  %%调用ELM函数下的数据

t0=0.05;         %%设置增减的变化范围

%%初始化储存矩阵，class1为增加，class2为减少，class3为不变，class4记录每个位置数据的分类结果；
%%esofclass1、esofclass2、esofclass3分别为class123对应位置的估计值
%%numberofclass1、numberofclass2、numberofclass3分别为class123的数据个数
class1=zeros(1,1);
class2=zeros(1,1);
class3=zeros(1,1);
class4=zeros(1,1);        
esofclass1=zeros(1,1);
esofclass2=zeros(1,1);
esofclass3=zeros(1,1);
numberofclass1=0;
numberofclass2=0;
numberofclass3=0;


startpoint=P(size(P,1),1);         %%将训练集最后一行第一个数据设为比较起始点
element=startpoint;
clear startpoint;
a = 0;
b = 0;
c = 0;
for i = 1:(size(T,2))
    if (T(1,i)-element>t0)
        numberofclass1=numberofclass1+1;
        a=a+1;
        class1(1,a)=T(1,i);
        esofclass1(1,a)=Y(1,i);
        class4(1,i)=1;
    else if (T(1,i)-element<-t0)
            numberofclass2=numberofclass2+1;
            b=b+1;
            class2(1,b)=T(1,i);
            esofclass2(1,b)=Y(1,i);
            class4(1,i)=2;
        else 
            numberofclass3=numberofclass3+1;
            c=c+1;
            class3(1,c)=T(1,i);
            esofclass3(1,c)=Y(1,i);
            class4(1,i)=3;
        end
     end
     element = T(1,i);
end
