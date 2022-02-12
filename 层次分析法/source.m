clear;clc  ##初始化

#load judgeMat.txt
disp("请输入判断矩阵");
judgeMat = input("");
[r,c] = size(judgeMat);

ERROR = 0; ##0正确,1不是对称矩阵,2没有通过一致性检验

##检测输入的矩阵是否是正互反矩阵
if r ~= c
  ERROR = 1;
elseif sum(sum(judgeMat .* judgeMat' ~= 1)) == 0
  ERROR = 0;
else
  ERROR = 1;
end

##对输入的判断矩阵进行一致性检验
if ERROR == 0
  [V,D] = eig(judgeMat);
  MAX_EIG = max(D(:));
  RI=[0 0.1 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];  ##平均随机一致性指标
  CI = (MAX_EIG - r)/(r - 1);  ##计算一致性指标
  CR = CI / RI(r);
  disp("一致性指标");
  disp(CR);
  if CR >= 0.1
    ERROR = 2;
  end
end

if ERROR == 0;
  ##算术平均法求权重
  sumColumn = sum(judgeMat); ##按列求和
  AM = judgeMat ./ sumColumn; ##归一化处理
  AM = sum(AM,2) ./ r;
  disp("算术平均法");
  disp(AM);
  
  ##几何平均值法求权重
  prodJudgeMat = prod(judgeMat,2); ##将判断矩阵按行相乘，得到一个列向量
  GM = prodJudgeMat .^ (1/r);
  GM = GM/sum(GM);
  disp("几何平均值法");
  disp(GM);
  
  ##特征值法求权重
  [r2,c2] = find(D == MAX_EIG); ##求出最大特征值所在列
  fEig = V(:,c2) ./ sum(V(:,c2));
  disp("特征值法");
  disp(fEig);
end