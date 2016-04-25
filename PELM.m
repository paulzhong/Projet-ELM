%%[T,TVT,P,TVP,Y,TY] = ELM('baogang_train.txt', 'baogang_test.txt', 0,20, 'sig'); 
function [classofMp1,classofMp2,classofMp3,classofcP1,classofcP2,classofcP3,classofPos1,classofPos2,classofPos3,classofw] = PELM(T,~,P,~,Y,~)
[numberofclass1, numberofclass2, numberofclass3, class1,class2,class3,class4,esofclass1,esofclass2,esofclass3] = FL(T,P,Y);

%%Y=sort(Y);
NumberofData=size(P,2);
NumberofInputNeurons=size(P,1);
%%NumberofTestData=size(TY,2);

%%初始化
classofMp1 = zeros(1,1);
classofMp2 = zeros(1,1);
classofMp3 = zeros(1,1);
classofcP1 = zeros(1,1);
classofcP2 = zeros(1,1);
classofcP3 = zeros(1,1);
classofPos1 = zeros(1,1);
classofPos2 = zeros(1,1);
classofPos3 = zeros(1,1);
classofPos = zeros(1,1);
classofw = zeros(1,1);

%%计算三类的偏差bias
bias1=mse(esofclass1,class1);
bias2=mse(esofclass2,class2);
bias3=mse(esofclass3,class3);                                               %%step2

%%对于均值中心模型，计算校正的训练误差均方差MSEC
R=0;
for j=1:NumberofData
    switch class4(1,j)
        case 1
            bias=bias1;
            R=R+(Y(1,j)-T(1,j)-bias)^2;
        case 2
            bias=bias2;
            R=R+(Y(1,j)-T(1,j)-bias)^2;
        case 3
            bias=bias3;
            R=R+(Y(1,j)-T(1,j)-bias)^2;
    end
end
MSEC=R/(NumberofData-NumberofInputNeurons-2);                               %%step3


for i=1:NumberofData
    
    %%三类所有样本的概率密度函数均值的计算
    gauss1=0;
    gauss2=0;
    gauss3=0;
    for j=1:NumberofData
        switch class4(1,j);
            case 1
                h=P(:,j)'*(inv(P*P'))*P(:,j);                               %%step1 杠杆值
                SEP=sqrt((1+h)*MSEC);                                       %%step4 预报标准差SEP
                gauss1=gauss1+(exp(-1/2*((Y(1,i)-Y(1,j))/SEP)^2))/(SEP*sqrt(2*pi));  %%step5 样本的概率密度函数的高斯分布的叠加和
            case 2
                h=P(:,j)'*(inv(P*P'))*P(:,j);                               %%step1 
                SEP=sqrt((1+h)*MSEC);                                        
                gauss2=gauss2+(exp(-1/2*((Y(1,i)-Y(1,j))/SEP)^2))/(SEP*sqrt(2*pi));   
            case 3
                h=P(:,j)'*(inv(P*P'))*P(:,j);                               %%step1 
                SEP=sqrt((1+h)*MSEC);                                      
                gauss3=gauss3+(exp(-1/2*((Y(1,i)-Y(1,j))/SEP)^2))/(SEP*sqrt(2*pi));  
        end
    end
    Mp1=gauss1/numberofclass1;                                              %%step6 三类所有样本的概率密度函数的均值
    Mp2=gauss2/numberofclass2;
    Mp3=gauss3/numberofclass3;
    
    Pri1=numberofclass1/NumberofData;                                       %%step7 先验概率
    Pri2=numberofclass2/NumberofData;
    Pri3=numberofclass3/NumberofData;          
    
    cP1=Mp1*Pri1;                                                           %%先验概率乘积
    cP2=Mp2*Pri2;
    cP3=Mp3*Pri3;
    
    p1=cP1/(Mp1*Pri1+Mp2*Pri2+Mp3*Pri3);                                    %%step8 后验概率
    p2=cP2/(Mp1*Pri1+Mp2*Pri2+Mp3*Pri3);
    p3=cP3/(Mp1*Pri1+Mp2*Pri2+Mp3*Pri3);
    
    if(p1>p2&&p1>p3)                                                        %%step9 贝叶斯决策规则
        w=1;
        Pos = p1;
    else if(p2>p1&&p2>p3)
            w=2;
            Pos = p2;
        else
            w=3;
            Pos = p3;
        end
    end
    classofMp1(1,i) = Mp1;
    classofMp2(1,i) = Mp2;
    classofMp3(1,i) = Mp3;
    classofcP1(1,i) = cP1;
    classofcP2(1,i) = cP2;
    classofcP3(1,i) = cP3;
    classofPos1(1,i) = p1;
    classofPos2(1,i) = p2;
    classofPos3(1,i) = p3;
    classofPos(1,i) = Pos;
    classofw(1,i) = w;
end
