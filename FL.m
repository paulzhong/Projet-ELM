function [numberofclass1, numberofclass2, numberofclass3, class1,class2,class3,class4,esofclass1,esofclass2,esofclass3] = FL(T,P,Y)
%%[T,~,P,~,Y,~] = ELM('baogang_train.txt', 'baogang_test.txt', 0,20, 'sig');  %%����ELM�����µ�����

t0=0.05;         %%���������ı仯��Χ

%%��ʼ���������class1Ϊ���ӣ�class2Ϊ���٣�class3Ϊ���䣬class4��¼ÿ��λ�����ݵķ�������
%%esofclass1��esofclass2��esofclass3�ֱ�Ϊclass123��Ӧλ�õĹ���ֵ
%%numberofclass1��numberofclass2��numberofclass3�ֱ�Ϊclass123�����ݸ���
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


startpoint=P(size(P,1),1);         %%��ѵ�������һ�е�һ��������Ϊ�Ƚ���ʼ��
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
